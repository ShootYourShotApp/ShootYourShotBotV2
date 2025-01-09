import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart' as rive;
import 'package:sysbotv2/provider/chatProvider.dart';

class VoiceChatScreen extends StatefulWidget {
  const VoiceChatScreen({super.key});

  @override
  State<VoiceChatScreen> createState() => _VoiceChatScreenState();
}

class _VoiceChatScreenState extends State<VoiceChatScreen> {
  late Timer _timer;
  int remainingSeconds = 30 * 60; // 30 minutes in seconds
  RxString status = 'stop'.obs;
  bool _hasPlayedGreeting = false;
  // Rive animation controllers
  rive.StateMachineController? _controller;

  @override
  void initState() {
    super.initState();
    _playGreetingAfterBuild();
    startTimer();
  }

  void _onRiveInit(rive.Artboard artboard) {
    final controller =
        rive.StateMachineController.fromArtboard(artboard, 'State Machine 1');
    if (controller != null) {
      artboard.addController(controller);
      _controller = controller;

      // Get stage input
      final stageInput =
          controller.findInput<double>('stage') as rive.SMINumber?;
      print('Stage input found: ${stageInput != null}');

      // Set initial state (0=idle, 1=listen, 2=searching, 3=talking)
      stageInput?.value = 3; // Start with talking
    }
  }

  void updateRiveState(ChatState newState) {
    final stageInput =
        _controller?.findInput<double>('stage') as rive.SMINumber?;

    switch (newState) {
      case ChatState.idle:
        stageInput?.value = 0;
        break;
      case ChatState.listening:
        stageInput?.value = 1;
        break;
      case ChatState.processing:
        stageInput?.value = 2;
        break;
      case ChatState.speaking:
        stageInput?.value = 3;
        break;
    }
  }

  void _playGreetingAfterBuild() {
    // Use a post-frame callback to ensure the widget is fully built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_hasPlayedGreeting) {
        _hasPlayedGreeting = true;
        final chatProvider = Provider.of<ChatProvider>(context, listen: false);
        chatProvider.playInitialGreeting();
      }
    });
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (remainingSeconds > 0) {
          remainingSeconds--;
        } else {
          _timer.cancel();
        }
      });
    });
  }

  String formatTime(int seconds) {
    final int minutes = seconds ~/ 60;
    final int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller?.dispose();

    // Get the chat provider and cancel the conversation
    final chatProvider = Provider.of<ChatProvider>(context, listen: false);
    chatProvider.cancelConversation();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        // Get the chat provider and cancel the conversation
        final chatProvider = Provider.of<ChatProvider>(context, listen: false);
        chatProvider.cancelConversation();
        return true;
      },
      child: Scaffold(
        body: Consumer<ChatProvider>(
          builder: (context, chatProvider, child) {
            updateRiveState(
                chatProvider.state); // Moved outside post-frame callback

            // Update status for UI
            status.value = chatProvider.state == ChatState.idle
                ? 'stop'
                : chatProvider.state.toString().split('.').last;

            return Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/voice-chat-bg.png'),
                      fit: BoxFit.fill)),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          const Spacer(),
                          Container(
                            width: 130,
                            height: 48,
                            decoration: BoxDecoration(
                                color: Color(0xff979797).withOpacity(0.24),
                                borderRadius: BorderRadius.circular(32)),
                            child: Row(
                              children: [
                                const SizedBox(width: 10),
                                Image.asset(
                                    'assets/images/ball-with-gradient-bg.png',
                                    width: 36),
                                const SizedBox(width: 10),
                                Text(
                                  formatTime(remainingSeconds),
                                  style: const TextStyle(
                                      fontSize: 32,
                                      color: Colors.white,
                                      fontFamily: 'SFDigital'),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 30),
                          Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Image.asset(
                                'assets/images/muscle-time-icon.png',
                                width: 28),
                          ),
                          const SizedBox(width: 16),
                          Image.asset(
                              'assets/images/fa_question-circle-icon.png',
                              width: 24),
                        ],
                      ),
                      const SizedBox(height: 40),
                      SizedBox(
                        height: height * 0.53,
                        child: rive.RiveAnimation.asset(
                          'assets/animations/robot.riv',
                          onInit: _onRiveInit,
                          fit: BoxFit.cover,
                          stateMachines: const ['State Machine 1'],
                        ),
                      ),
                      const SizedBox(height: 30),
                      CustomRow(status: status),
                      const Spacer(),
                      GestureDetector(
                          onTap: () {
                            if (status.value == 'stop') {
                              chatProvider.startConversation();
                            } else if (status.value == 'speaking') {
                              chatProvider.interruptAndListen();
                            } else {
                              chatProvider.cancelConversation();
                            }
                          },
                          child: Obx(() => Image.asset(
                              status.value.toLowerCase() == 'stop'
                                  ? 'assets/images/shoot-icon-with-bg.png'
                                  : 'assets/images/stop-icon-with-bg.png',
                              width: 105))),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class CustomRow extends StatelessWidget {
  const CustomRow({super.key, required this.status});

  final RxString status;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
                status.value == 'listening'
                    ? 'assets/images/ear-icon.png'
                    : status.value == 'processing'
                        ? 'assets/images/processing-icon.png'
                        : status.value == 'speaking'
                            ? 'assets/images/speaking-icon.png'
                            : 'assets/images/ball.png',
                width: 22),
            const SizedBox(width: 6),
            Text(
                status.value == 'listening'
                    ? 'LISTENING...'
                    : status.value == 'processing'
                        ? 'PROCESSING...'
                        : status.value == 'speaking'
                            ? 'SPEAKING...'
                            : 'TAP SHOOT TO TALK',
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'SFCompactRounded'))
          ],
        ));
  }
}
