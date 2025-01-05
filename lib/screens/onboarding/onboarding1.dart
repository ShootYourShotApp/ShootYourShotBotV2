import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../widgets/custom_button.dart';

class Onboarding1 extends StatelessWidget {
  const Onboarding1({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xff0A0A0A),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Image.asset('assets/images/logo.png', width: width),
            const Spacer(),
            const Spacer(),
            CustomButton(title: 'Continue', iconPath: 'assets/images/smiling-face-emoji.png'),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontFamily: 'SFUIText',
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    fontSize: 11,
                  ),
                  children: [
                    TextSpan(
                      text: 'By tapping Continue, you agree to our ',
                    ),
                    TextSpan(
                      text: 'Terms of Service',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Handle Terms of Service click
                          print('Terms of Service clicked');
                        },
                    ),
                    TextSpan(
                      text: ' and ',
                    ),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Handle Privacy Policy click
                          print('Privacy Policy clicked');
                        },
                    ),
                    TextSpan(
                      text: '.',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
