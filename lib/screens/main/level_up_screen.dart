import 'package:flutter/material.dart';
import 'package:outlined_text/outlined_text.dart';

import '../../widgets/dialogs/level_up_dialog.dart';

class LevelUpScreen extends StatelessWidget {
  const LevelUpScreen({super.key});

  final double flexFactorMinutes = 15;
  final double dripCheckMinutes = 5;
  final double juiceLevelMinutes = 0;
  final double pickupGameMinutes = 20;
  final double goalDiggerMinutes = 10;

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
                  const SizedBox(height: 16),
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
                                        'Earn 1 point for every 30\nmin talk session with Shoot\nYour Shot Bot to level up in\n');
                              },
                            );
                          },
                          child: Image.asset('assets/images/hint-icon.png',
                              width: 33, color: const Color(0xff5B5B5B))),
                    ),
                  ),
                  Text('Level Up',
                      style: TextStyle(
                          fontFamily: 'SFProRound',
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w900)),
                  const SizedBox(height: 16),
                  Container(
                    width: width,
                    height: 155,
                    decoration: BoxDecoration(
                        color: const Color(0xff0A0A0A),
                        border: Border.all(
                            color: const Color(0xff582AFF), width: 1),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0xff582AFF),
                              spreadRadius: 2,
                              blurRadius: 18,
                              offset: const Offset(0, 4))
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              OutlinedText(
                                text: Text('Rizz Games',
                                    style: TextStyle(
                                        color: const Color(0xff440FFF),
                                        fontSize: 24,
                                        fontWeight: FontWeight.w900,
                                        fontFamily: 'SFProRound')),
                                strokes: [
                                  OutlinedTextStroke(
                                      color: const Color(0xffEFEFEF), width: 3),
                                ],
                              ),
                              Container(
                                width: width * 0.38,
                                height: 44,
                                decoration: BoxDecoration(
                                    color: Color(0xff582AFF),
                                    borderRadius: BorderRadius.circular(50)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                        'assets/images/progress-arrow-icon.png',
                                        height: 11),
                                    const SizedBox(width: 5),
                                    Text('Leaderboard',
                                        style: TextStyle(
                                            fontFamily: 'LuckiestGuy',
                                            color: Colors.white,
                                            fontSize: 12))
                                  ],
                                ),
                              )
                            ],
                          ),
                          const Spacer(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/crown-icon.png',
                                  width: 45),
                              const SizedBox(height: 5),
                              Text('Your Position',
                                  style: TextStyle(
                                      fontFamily: 'SFCompactRounded',
                                      fontSize: 10,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white)),
                              Text('4th',
                                  style: TextStyle(
                                      fontFamily: 'SFProRound',
                                      fontSize: 24,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white)),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text('Earn Points',
                      style: TextStyle(
                          fontFamily: 'SFProRound',
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w900)),
                  Text('Chat with Bot for 30 minutes to earn 1 point',
                      style: TextStyle(
                          fontFamily: 'SFCompactRounded',
                          color: Color(0xff979797),
                          fontSize: 14,
                          fontWeight: FontWeight.w400)),
                  const SizedBox(height: 12),
                  CustomWidget(
                      iconPath: 'assets/images/flexed-biceps-icon.png',
                      minutes: flexFactorMinutes,
                      text: 'Flex Factor'),
                  CustomWidget(
                      iconPath: 'assets/images/water-drop-icon.png',
                      minutes: dripCheckMinutes,
                      text: 'Drip Check'),
                  CustomWidget(
                      iconPath: 'assets/images/juice-box-icon.png',
                      minutes: juiceLevelMinutes,
                      text: 'Juice Level'),
                  CustomWidget(
                      iconPath: 'assets/images/ball.png',
                      minutes: pickupGameMinutes,
                      text: 'Pickup Games'),
                  CustomWidget(
                      iconPath: 'assets/images/trophy-icon.png',
                      minutes: goalDiggerMinutes,
                      text: 'Goal Digger'),
                ],
              ),
            ),
          ),
        ));
  }
}

class CustomWidget extends StatelessWidget {
  const CustomWidget(
      {super.key,
      required this.iconPath,
      required this.text,
      required this.minutes,
      this.iconSize});

  final String iconPath;
  final double? iconSize;
  final String text;
  final double minutes;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Stack(
        children: [
          SizedBox(
            height: 60,
            width: width,
            child: LinearProgressIndicator(
              value: minutes / 30,
              minHeight: 60,
              borderRadius: BorderRadius.circular(11),
              backgroundColor: const Color(0xff262626),
              color: const Color(0xff582AFF),
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            child: SizedBox(
              width: width - 40,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 20),
                  Image.asset(iconPath, width: iconSize ?? 20),
                  const SizedBox(width: 10),
                  Text(text,
                      style: TextStyle(
                          fontFamily: 'SFCompactRounded',
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                          color: Colors.white)),
                  const Spacer(),
                  Text(minutes.toInt().toString(),
                      style: TextStyle(
                          fontFamily: 'SFCompactRounded',
                          fontWeight: FontWeight.w900,
                          fontSize: 12,
                          color: Colors.white)),
                  Text('/30',
                      style: TextStyle(
                          fontFamily: 'SFCompactRounded',
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Colors.white)),
                  const SizedBox(width: 20),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
