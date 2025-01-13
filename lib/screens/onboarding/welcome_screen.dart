import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sysbotv2/screens/onboarding/referral_code_screen.dart';
import 'package:sysbotv2/utils/functions/open_url.dart';

import '../../widgets/custom_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xff0A0A0A),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          Image.asset('assets/images/logo.png', width: width),
          const Spacer(),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomButton(
                onTap: () => Get.offAll(ReferralCodeScreen()),
                title: 'Continue',
                iconPath: 'assets/images/smiling-face-emoji.png'),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36),
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
                        openUrl(
                            androidUrl: 'http://shootyourshot.ai/terms',
                            iosUrl: 'http://shootyourshot.ai/terms');
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
                        openUrl(
                            androidUrl: 'http://shootyourshot.ai/privacy',
                            iosUrl: 'http://shootyourshot.ai/privacy');
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
    );
  }
}
