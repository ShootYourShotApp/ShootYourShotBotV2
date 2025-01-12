import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sysbotv2/widgets/custom_button.dart';

import 'notification_permission_screen.dart';

class ReferralCodeScreen extends StatelessWidget {
  ReferralCodeScreen({super.key});

  final String refCode = 'U4Q58R'; // dummy referral code
  final refCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0A0A0A),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const Spacer(flex: 2),
              Text('Do you have a referral code?',
                  style: TextStyle(
                      fontFamily: 'SFProRound',
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      fontSize: 28)),
              const Spacer(flex: 3),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: TextFormField(
                  controller: refCodeController,
                  cursorColor: const Color(0xffffffff),
                  style: TextStyle(
                      fontFamily: 'SFProRound',
                      fontWeight: FontWeight.w600,
                      color: const Color(0xffffffff),
                      fontSize: 16),
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      filled: true,
                      fillColor: const Color(0xff414141),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
              ),
              const SizedBox(height: 12),
              Text('Enter your code here or skip',
                  style: TextStyle(
                      fontFamily: 'SFProRound',
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff979797),
                      fontSize: 16)),
              const Spacer(flex: 4),
              CustomButton(
                  onTap: () {
                    if (refCodeController.text.trim() == refCode) {
                      // referral code is valid
                    } else if(refCodeController.text.trim().isEmpty){
                      //No Referral Code enter
                      Get.to(NotificationPermissionScreen());
                    }
                    else {
                      Get.snackbar('', '',
                          titleText: Text('Invalid Code',
                              style: TextStyle(
                                  fontFamily: 'Mont',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.white)),
                          messageText: SizedBox(),
                          colorText: Colors.white,
                          icon:
                              Icon(Icons.close, size: 20, color: Colors.white),
                          borderRadius: 12,
                          backgroundColor: const Color(0xffFF3B30),
                          shouldIconPulse: false,
                          padding:
                              EdgeInsets.only(left: 20, top: 12, bottom: 12));
                    }
                  },
                  title: 'Continue'),
              const SizedBox(height: 36)
            ],
          ),
        ),
      ),
    );
  }
}
