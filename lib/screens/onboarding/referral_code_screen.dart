import 'package:flutter/material.dart';
import 'package:sysbotv2/widgets/custom_button.dart';

class ReferralCodeScreen extends StatelessWidget {
  const ReferralCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xff0A0A0A),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const Spacer(flex: 2),
              Text('Do you have a referral code?', style: TextStyle(fontFamily: 'SFProRound', fontWeight: FontWeight.w900, color: Colors.white, fontSize: width*0.0777)),
              const Spacer(flex: 3),
              TextFormField(
                cursorColor: const Color(0xff979797),
                style: TextStyle(fontFamily: 'SFProRound', fontWeight: FontWeight.w600, color: const Color(0xff979797), fontSize: 16),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(20),
                  filled: true,
                  fillColor: const Color(0xff414141),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15)
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15)
              ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15)
              )
                ),
              ),
              const SizedBox(height: 12),
              Text('Enter your code here  or skip', style: TextStyle(fontFamily: 'SFProRound', fontWeight: FontWeight.w600, color: const Color(0xff979797), fontSize: 16)),
              const Spacer(flex: 4),
              CustomButton(title: 'Continue'),
              const SizedBox(height: 36)
            ],
          ),
        ),
      ),
    );
  }
}
