import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sysbotv2/provider/chatProvider.dart';
import 'package:sysbotv2/screens/main/voice_chat_screen.dart';

import '../../widgets/dialogs/level_up_dialog.dart';

class LetsVoiceChat extends StatelessWidget {
  const LetsVoiceChat({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xff0A0A0A),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return LevelUpDialog(
                                  text:
                                      'Be sure to select a category\nto get credit for your\ntalking time and level up in\n');
                            },
                          );
                        },
                        child: Image.asset('assets/images/hint-icon.png',
                            width: 33, color: const Color(0xff5B5B5B))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text("Let's Voice Chat",
                      style: TextStyle(
                          fontFamily: 'SFProRound',
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 24)),
                ),
                const SizedBox(height: 50),
                GestureDetector(
                  onTap: () async {
                    await precacheImage(
                        AssetImage('assets/images/voice-chat-bg.png'), context);
                    final chatProvider =
                        Provider.of<ChatProvider>(context, listen: false);
                    chatProvider.setCategory('');
                    Get.to(VoiceChatScreen(iconPath: 'assets/images/robot-icon.png'));
                  },
                  child: Stack(
                    children: [
                      Container(
                        width: width,
                        height: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            gradient: LinearGradient(
                                colors: [Color(0xff434343), Color(0xff000000)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight)),
                      ),
                      Container(
                        width: width,
                        height: 70,
                        decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(24)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Image.asset('assets/images/robot-icon.png',
                                  width: 33, height: 33),
                              const SizedBox(width: 12),
                              Text('Ask me anything',
                                  style: TextStyle(
                                      fontFamily: 'SFCompactRounded',
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w900))
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 36),
                Text("Learn how to..",
                    style: TextStyle(
                        fontFamily: 'SFProRound',
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 20)),
                const SizedBox(height: 24),
                CustomContainer(
                    onTap: () async {
                      await precacheImage(
                          AssetImage('assets/images/voice-chat-bg.png'),
                          context);
                      final chatProvider =
                          Provider.of<ChatProvider>(context, listen: false);
                      chatProvider.setCategory('Shoot Your Shot');
                      Get.to(VoiceChatScreen(iconPath: 'assets/images/ball-timer.png'));
                    },
                    title: 'Shoot Your Shot',
                    subtitle: 'Pickup lines & tips to heat things up',
                    trailing: 'Pickup Game',
                    iconPath: 'assets/images/ball.png',
                    gradientClr: [Color(0xffF6D365), Color(0xffFDA085)]),
                const SizedBox(height: 10),
                CustomContainer(
                    onTap: () async {
                      await precacheImage(
                          AssetImage('assets/images/voice-chat-bg.png'),
                          context);
                      final chatProvider =
                          Provider.of<ChatProvider>(context, listen: false);
                      chatProvider.setCategory(
                          'Build Confidence'); // Set the category before navigation
                      Get.to(VoiceChatScreen(iconPath: 'assets/images/flexed-biceps-icon-timer.png'));
                    },
                    title: 'Build Confidence',
                    subtitle: 'Exercises to strengthen your self assurance',
                    trailing: 'Flex Factor',
                    iconPath: 'assets/images/flexed-biceps-icon.png',
                    gradientClr: [Color(0xffFFFF00), Color(0xffEACDA3)]),
                const SizedBox(height: 10),
                CustomContainer(
                    onTap: () async {
                      await precacheImage(
                          AssetImage('assets/images/voice-chat-bg.png'),
                          context);
                      final chatProvider =
                          Provider.of<ChatProvider>(context, listen: false);
                      chatProvider.setCategory(
                          'Look Good Dress Well'); // Set the category before navigation
                      Get.to(VoiceChatScreen(iconPath: 'assets/images/water-drop-timer.png'));
                    },
                    title: 'Look Good Dress Well',
                    subtitle: 'Let’s level up your style and grooming',
                    trailing: 'Drip Check',
                    iconPath: 'assets/images/water-drop-icon.png',
                    gradientClr: [Color(0xff4FACFE), Color(0xff00F2FE)]),
                const SizedBox(height: 10),
                CustomContainer(
                    onTap: () async {
                      await precacheImage(
                          AssetImage('assets/images/voice-chat-bg.png'),
                          context);
                      final chatProvider =
                          Provider.of<ChatProvider>(context, listen: false);
                      chatProvider.setCategory('Up Your Influence');
                      Get.to(VoiceChatScreen(iconPath: 'assets/images/juice-box-timer.png'));
                    },
                    title: 'Up Your Influence',
                    subtitle: 'Learn how to take lead and captivate',
                    trailing: 'Juice Level',
                    iconPath: 'assets/images/juice-box-icon.png',
                    gradientClr: [Color(0xff43E97B), Color(0xff38F9D7)]),
                const SizedBox(height: 10),
                CustomContainer(
                    onTap: () async {
                      await precacheImage(
                          AssetImage('assets/images/voice-chat-bg.png'),
                          context);
                      final chatProvider =
                          Provider.of<ChatProvider>(context, listen: false);
                      chatProvider.setCategory('Escape The Matrix');
                      Get.to(VoiceChatScreen(iconPath: 'assets/images/trophy-timer.png'));
                    },
                    title: 'Escape The Matrix',
                    subtitle: 'Crush your goals and stay ambitious',
                    trailing: 'Goal Digger',
                    iconPath: 'assets/images/trophy-icon.png',
                    gradientClr: [Color(0xffF89418), Color(0xffEACDA3)]),
                const SizedBox(height: 30)
              ],
            ),
          ),
        ),
      ),
      extendBody: true,
      bottomNavigationBar: SizedBox(
        height: 76,
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          currentIndex: 2,
          selectedItemColor: Colors.white,
          unselectedItemColor: Color(0xff979797),
          selectedLabelStyle: TextStyle(
              fontFamily: 'Avenir', fontWeight: FontWeight.w500, fontSize: 13),
          unselectedLabelStyle: TextStyle(
              fontFamily: 'Avenir', fontWeight: FontWeight.w500, fontSize: 13),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child:
                    Image.asset('assets/images/score-card-icon.png', width: 24),
              ),
              label: 'score card',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child:
                    Image.asset('assets/images/level-up-icon.png', width: 23),
              ),
              label: 'level up',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Image.asset('assets/images/coach-icon.png', width: 20),
              ),
              label: 'coach',
            ),
          ],
        ),
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  const CustomContainer(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.iconPath,
      required this.trailing,
      required this.gradientClr,
      this.onTap});

  final String title;
  final String subtitle;
  final String iconPath;
  final String trailing;
  final List<Color> gradientClr;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: 72,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
                colors: gradientClr,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight)),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 10),
          child: Stack(
            children: [
              Positioned(
                  right: 8,
                  top: 10,
                  child: Text(trailing.toUpperCase(),
                      style: TextStyle(
                          fontFamily: 'SFDigital',
                          color: Colors.black,
                          fontSize: 15))),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Image.asset(iconPath, width: 33),
                title: Text(title,
                    style: TextStyle(
                        fontFamily: 'SFCompactRounded',
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w900)),
                subtitle: Text(subtitle,
                    style: TextStyle(
                        fontFamily: 'SFCompactRounded',
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
