import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sysbotv2/screens/lets_voice_chat.dart';
import 'package:sysbotv2/screens/main/level_up_screen.dart';
import 'package:sysbotv2/screens/main/rizz_report.dart';
import 'package:sysbotv2/screens/onboarding/questions_screen.dart';
import 'package:sysbotv2/screens/onboarding/notification_permission_screen.dart';
import 'package:sysbotv2/screens/onboarding/onboarding1.dart';
import 'package:sysbotv2/screens/onboarding/referral_code_screen.dart';
import 'package:sysbotv2/screens/onboarding/rizz_quiz_screen.dart';
import 'package:sysbotv2/screens/onboarding/see_my_results.dart';
import 'package:sysbotv2/screens/voice_chat_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SYS Bot',
      home: LevelUpScreen(),
    );
  }
}