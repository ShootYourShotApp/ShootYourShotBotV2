import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../custom_button.dart';

class LevelUpDialog extends StatelessWidget {
  const LevelUpDialog({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      alignment: Alignment.center,
      backgroundColor: Colors.transparent,
      content: SizedBox(
        height: 382,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 324,
                decoration: BoxDecoration(
                    color: const Color(0xff1B1B1B),
                    borderRadius: BorderRadius.circular(30)),
                child: Column(
                  children: [
                    const SizedBox(height: 65),
                    Text('Level Up'.toUpperCase(),
                        style: TextStyle(
                            fontFamily: 'LuckiestGuy',
                            fontSize: 40,
                            color: const Color(0xffC1CCFF))),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: text,
                            style: TextStyle(
                              fontFamily: 'SFCompactRounded',
                              fontSize: 17.5,
                              color: const Color(0xffD2D2D2),
                              fontWeight: FontWeight.w300,
                            ),
                            children: [
                              TextSpan(
                                text: 'Rizz Games',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
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
                        child: Image.asset('assets/images/hint-icon.png',
                            height: 114))))
          ],
        ),
      ),
    );
  }
}
