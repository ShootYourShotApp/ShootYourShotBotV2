import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VoiceChatScreen extends StatefulWidget {
  const VoiceChatScreen({super.key});

  @override
  State<VoiceChatScreen> createState() => _VoiceChatScreenState();
}

class _VoiceChatScreenState extends State<VoiceChatScreen> {
  late Timer _timer;
  int remainingSeconds = 30 * 60; // 30 minutes in seconds
  RxString status = 'stop'.obs;

  @override
  void initState() {
    super.initState();
    startTimer();
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
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
                    GestureDetector(
                        onTap: () => Get.back(),
                        child: Image.asset('assets/images/arrow-back-icon.png',
                            width: 18)),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Image.asset('assets/images/muscle-time-icon.png',
                          width: 28),
                    ),
                    const SizedBox(width: 16),
                    Image.asset('assets/images/fa_question-circle-icon.png',
                        width: 24),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  width: 130,
                  height: 48,
                  decoration: BoxDecoration(
                      color: Color(0xff979797).withValues(alpha: 0.24),
                      borderRadius: BorderRadius.circular(32)),
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      Image.asset('assets/images/ball-with-gradient-bg.png',
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
                const SizedBox(height: 40),
                Image.asset('assets/images/bot-img.png', height: height * 0.38),
                const SizedBox(height: 30),
                CustomRow(status: status),
                const Spacer(),
                GestureDetector(
                    onTap: () {
                      if (status.value == 'stop') {
                        status.value = 'listening';
                      } else {
                        status.value = 'stop';
                      }
                    },
                    child: Obx(() => Image.asset(
                        status.value.toLowerCase() == 'stop'
                            ? 'assets/images/shoot-icon-with-bg.png'
                            : 'assets/images/stop-icon-with-bg.png',
                        width: 96))),
                const Spacer(),
              ],
            ),
          ),
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
