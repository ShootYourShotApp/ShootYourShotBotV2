import 'package:flutter/material.dart';
import 'package:sysbotv2/screens/onboarding/questions_screen.dart';
import 'package:sysbotv2/widgets/custom_button.dart';
import 'package:sysbotv2/widgets/gradient_text.dart';
import 'package:get/get.dart';

import '../../widgets/rizz_report_option_widget.dart';

class RizzQuizScreen extends StatelessWidget {
  const RizzQuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xff0A0A0A),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: height*0.03),
            Center(
                child: Image.asset('assets/images/brain-icon.png', width: width*0.1388)),
            const SizedBox(height: 4),
            GradientText(
                textWidget: Text('Rizz Quiz',
                    style: TextStyle(
                        fontFamily: 'LuckiestGuy',
                        color: Colors.white,
                        fontSize: width*0.1))),
            const SizedBox(height: 20),
            Container(
              width: height*0.492 * (259/370),
              height: height*0.492,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                        color: const Color(0xff582AFF).withValues(alpha: 0.8),
                        spreadRadius: 2,
                        blurRadius: 90,
                        offset: const Offset(0, 2))
                  ],
                  image: DecorationImage(
                      image:
                          AssetImage('assets/images/rizz-quiz-container.png'),
                      fit: BoxFit.fill)),
              child: Column(
                children: [
                  SizedBox(height: height*0.1595),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OptionsWidget(
                          progressWidth: width*0.25,
                          iconSize: width*0.04166,
                          fontSize: width*0.0333,
                          percentageSize: width*0.02777,
                          label: 'Overall',
                          iconPath: 'assets/images/100-emoji.png',
                          percentage: 100),
                      const SizedBox(width: 20),
                      OptionsWidget(
                          progressWidth: width*0.25,
                          iconSize: width*0.04166,
                          fontSize: width*0.0333,
                          percentageSize: width*0.02777,
                          label: 'Juice Level',
                          iconPath: 'assets/images/juice-box-icon.png',
                          percentage: 100),
                    ],
                  ),
                  SizedBox(height: height*0.0372),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OptionsWidget(
                          progressWidth: width*0.25,
                          iconSize: width*0.04166,
                          fontSize: width*0.0333,
                          percentageSize: width*0.02777,
                          label: 'Flex Factor',
                          iconPath: 'assets/images/flexed-biceps-icon.png',
                          percentage: 100),
                      const SizedBox(width: 20),
                      OptionsWidget(
                          progressWidth: width*0.25,
                          iconSize: width*0.04166,
                          fontSize: width*0.0333,
                          percentageSize: width*0.02777,
                          label: 'Pickup Game',
                          iconPath: 'assets/images/ball.png',
                          percentage: 100),
                    ],
                  ),
                  SizedBox(height: height*0.0372),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OptionsWidget(
                          progressWidth: width*0.25,
                          iconSize: width*0.04166,
                          fontSize: width*0.0333,
                          percentageSize: width*0.02777,
                          label: 'Drip Check',
                          iconPath: 'assets/images/water-drop-icon.png',
                          percentage: 100),
                      const SizedBox(width: 20),
                      OptionsWidget(
                          progressWidth: width*0.25,
                          iconSize: width*0.04166,
                          fontSize: width*0.0333,
                          percentageSize: width*0.02777,
                          label: 'Goal Digger',
                          iconPath: 'assets/images/trophy-icon.png',
                          percentage: 100),
                    ],
                  ),
                  SizedBox(height: height*0.0319),
                  Text('© Rizz Report',
                      style: TextStyle(
                          fontFamily: 'ShareTechMono',
                          color: Colors.white,
                          fontSize: width*0.0333))
                ],
              ),
            ),
            const Spacer(),
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
                      text:
                          '. We’ll analyze your rizz & work on hitting your full potential.',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomButton(
                  onTap: () => Get.offAll(QuestionsScreen()),
                  title: 'Get My Rizz Report',
                  iconPath: 'assets/images/flexed-biceps-icon.png'),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
