import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sysbotv2/provider/chatProvider.dart';
import 'package:sysbotv2/screens/lets_voice_chat.dart';
import 'package:sysbotv2/screens/onboarding/questions_screen.dart';

void main() {
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
        home: LetsVoiceChat(),
      ),
    );
  }
}