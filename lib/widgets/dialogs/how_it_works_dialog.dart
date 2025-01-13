import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../custom_button.dart';

class HowItWorksDialog extends StatelessWidget {
  const HowItWorksDialog({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      alignment: Alignment.center,
      backgroundColor: Colors.transparent,
      content: SizedBox(
        height: 596,
        width: MediaQuery.of(context).size.width*0.9,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 536,
                decoration: BoxDecoration(
                    color: const Color(0xff1B1B1B),
                    borderRadius: BorderRadius.circular(30)),
                child: Column(
                  children: [
                    const SizedBox(height: 65),
                    Text('How It Works'.toUpperCase(),
                        style: TextStyle(
                            fontFamily: 'LuckiestGuy',
                            fontSize: 30,
                            color: const Color(0xffC1CCFF))),
                    const SizedBox(height: 20),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: RichText(
                          text: TextSpan(
                            text: '• Tap ',
                            style: TextStyle(
                              fontFamily: 'SFCompactRounded',
                              fontSize: 15,
                              color: const Color(0xffD2D2D2),
                              fontWeight: FontWeight.w300,
                            ),
                            children: [
                              TextSpan(
                                text: 'Shoot ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                text: 'to talk and ',
                              ),
                              TextSpan(
                                text: 'Stop ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                text: 'to pause the timer.\n\n• You have ',
                              ),
                              TextSpan(
                                text: '30 minutes ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                text: 'of coach therapy ',
                              ),
                              TextSpan(
                                text: 'per week\n\n',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                text: '• To ',
                              ),
                              TextSpan(
                                text: 'earn credit ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                text: 'for talking time and ',
                              ),
                              TextSpan(
                                text: 'leveling up ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                text: 'in Rizz Games you must ensure you see a ',
                              ),
                              WidgetSpan(
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 1.5),
                                    child: Image.asset('assets/images/clock-icon.png', width: 13, height: 13),
                                  )
                              ),
                              TextSpan(
                                text: ' timer along with one of the 5 categories below which will display to the left of the question mark icon ',
                              ),
                              WidgetSpan(
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 2),
                                    child: Image.asset('assets/images/fa_question-circle-icon.png', width: 12, height: 12),
                                  )
                              ),
                              TextSpan(
                                text: '  you just tapped on. ',
                              ),
                              TextSpan(
                                text: 'Ex:  ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              WidgetSpan(
                                  child: Image.asset('assets/images/flexed-biceps-icon-timer.png', width: 15, height: 15)
                              ),
                              WidgetSpan(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 2, right: 2),
                                    child: Image.asset('assets/images/ball-timer.png', width: 15, height: 15),
                                  )
                              ),
                              WidgetSpan(
                                  child: Image.asset('assets/images/water-drop-timer.png', width: 15, height: 15)
                              ),
                              WidgetSpan(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 2, right: 2),
                                    child: Image.asset('assets/images/juice-box-timer.png', width: 15, height: 15),
                                  )
                              ),
                              WidgetSpan(
                                  child: Image.asset('assets/images/trophy-timer.png', width: 15, height: 15)
                              ),
                              TextSpan(
                                text: '\n\n',
                              ),
                              TextSpan(
                                text: '• Credit ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: 'does not ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text: 'apply to the ”',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              WidgetSpan(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 2, right: 2),
                                    child: Image.asset('assets/images/robot-icon.png', width: 15, height: 15),
                                  )
                              ),
                              TextSpan(
                                text: '  Ask me anything” category as it’s intended for casual use.',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        )),
                    const SizedBox(height: 30),
                    CustomButton(
                        onTap: () => Get.back(), title: 'Got It', width: 190)
                  ],
                ),
              ),
            ),
            Positioned(
                left: 0,
                right: 0,
                top: 0,
                child: SizedBox(
                    height: 380,
                    child: Align(
                        alignment: Alignment.topCenter,
                        child: Image.asset('assets/images/fa_question-circle-icon.png',
                            height: 110))))
          ],
        ),
      ),
    );
  }
}
