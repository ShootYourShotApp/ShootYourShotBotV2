import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sysbotv2/provider/chatProvider.dart';
import 'package:sysbotv2/screens/bottom_nav_bar.dart';
import 'package:sysbotv2/screens/help_us_grow.dart';
import 'package:sysbotv2/screens/main/lets_voice_chat.dart';
import 'package:sysbotv2/screens/main/level_up_screen.dart';
import 'package:sysbotv2/screens/onboarding/referral_code_screen.dart';
import 'package:sysbotv2/screens/onboarding/see_my_results.dart';
import 'package:sysbotv2/screens/onboarding/welcome_screen.dart';
import 'package:sysbotv2/screens/onboarding/questions_screen.dart';
import 'package:sysbotv2/screens/onboarding/rizz_quiz_screen.dart';
import 'package:sysbotv2/screens/upgrade/upgrade_screen.dart';
import 'package:flutter/services.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChatProvider()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SYS Bot',
        home: WelcomeScreen(),
      ),
    );
  }
}
