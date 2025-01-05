import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sysbotv2/screens/onboarding/flex_factor_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SYS Bot',
      home: FlexFactorScreen(),
    );
  }
}
