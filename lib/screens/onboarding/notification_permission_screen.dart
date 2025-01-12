import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sysbotv2/screens/onboarding/rizz_quiz_screen.dart';
import 'package:sysbotv2/widgets/custom_button.dart';

import '../../utils/functions/request_notification_permission_ios.dart';

class NotificationPermissionScreen extends StatelessWidget {
  const NotificationPermissionScreen({super.key});

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
              Text('Enable Push Notifications',
                  style: TextStyle(
                      fontFamily: 'SFProRound',
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      fontSize: 32)),
              const Spacer(flex: 2),
              Image.asset('assets/images/notification-permission-icon.png',
                  width: 112),
              const Spacer(flex: 1),
              Text('Be in the know\nMake progress on a daily basis',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'SFProRound',
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff979797),
                      fontSize: 16)),
              const Spacer(flex: 3),
              GestureDetector(
                  onTap: () {
                    if (Platform.isIOS) {
                      askNotificationPermission();
                    }
                    Get.offAll(RizzQuizScreen());
                  },
                  child: CustomButton(title: 'Continue')),
              const SizedBox(height: 36)
            ],
          ),
        ),
      ),
    );
  }
}
