import 'package:flutter/material.dart';
import 'package:sysbotv2/widgets/custom_button.dart';
import 'package:sysbotv2/widgets/gradient_text.dart';

class RizzQuizScreen extends StatelessWidget {
  const RizzQuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0A0A0A),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 36),
            Center(
                child: Image.asset('assets/images/brain-icon.png', width: 46)),
            const SizedBox(height: 4),
            GradientText(
                textWidget: Text('Rizz Quiz',
                    style: TextStyle(
                        fontFamily: 'LuckiestGuy',
                        color: Colors.white,
                        fontSize: 32))),
            const SizedBox(height: 20),
            Container(
              width: 259,
              height: 370,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                        color: const Color(0xff582AFF),
                        spreadRadius: 4,
                        blurRadius: 130,
                        offset: const Offset(0, 2))
                  ],
                  image: DecorationImage(
                      image:
                          AssetImage('assets/images/rizz-quiz-container.png'),
                      fit: BoxFit.fill)),
              child: Column(
                children: [
                  const SizedBox(height: 120),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OptionsWidget(label: 'Overall', iconPath: 'assets/images/100-emoji.png'),
                      const SizedBox(width: 20),
                      OptionsWidget(label: 'Juice Level', iconPath: 'assets/images/juice-box-icon.png'),
                    ],
                  ),
                  const SizedBox(height: 28),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OptionsWidget(label: 'Flex Factor', iconPath: 'assets/images/flexed-biceps-icon.png'),
                      const SizedBox(width: 20),
                      OptionsWidget(label: 'Pickup Game', iconPath: 'assets/images/ball.png'),
                    ],
                  ),
                  const SizedBox(height: 28),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OptionsWidget(label: 'Drip Check', iconPath: 'assets/images/water-drop-icon.png'),
                      const SizedBox(width: 20),
                      OptionsWidget(label: 'Goal Digger', iconPath: 'assets/images/trophy-icon.png'),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text('© Rizz Report', style: TextStyle(fontFamily: 'ShareTechMono', color: Colors.white, fontSize: 12))
                ],
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontFamily: 'SFProRound',
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                  children: [
                    TextSpan(
                      text: 'Answer 5 of our ',
                    ),
                    TextSpan(
                      text: 'Psychology-backed questions',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextSpan(
                      text: '. We’ll analyze your rizz & work on hitting your full potential.',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomButton(title: 'Get My Rizz Report', iconPath: 'assets/images/flexed-biceps-icon.png'),
            )
          ],
        ),
      ),
    );
  }
}


class OptionsWidget extends StatelessWidget {
  const OptionsWidget({super.key, required this.iconPath, required this.label});
  final String label;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              WidgetSpan(
                child: Image.asset(
                  iconPath,
                  width: 15,
                  height: 15,
                ),
              ),
              TextSpan(
                text: ' $label',
                style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w900, fontFamily: 'SFProRound'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text('100%', style: TextStyle(fontFamily: 'SFCompactRounded', color: Colors.white, fontWeight: FontWeight.w500, fontSize: 10)),
        const SizedBox(height: 6),
        Container(
          height: 7,
          width: 90,
          decoration: BoxDecoration(
              color: const Color(0xff582AFF),
              borderRadius: BorderRadius.circular(8)
          ),
        )
      ],
    );
  }
}
