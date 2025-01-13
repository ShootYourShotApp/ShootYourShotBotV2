import 'package:flutter/material.dart';
import 'package:sysbotv2/widgets/custom_button.dart';
import 'package:get/get.dart';
import 'package:in_app_review/in_app_review.dart';


class HelpUsGrow extends StatelessWidget {
  HelpUsGrow({super.key});

  final InAppReview inAppReview = InAppReview.instance;

  void showInAppReview() async {
    if (await inAppReview.isAvailable()) {
      inAppReview.requestReview();
    } else {
      inAppReview.openStoreListing(
        appStoreId: '6615074058',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0A0A0A),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                      onTap: () => Get.back(),
                      child: Icon(Icons.close, color: const Color(0xff979797), size: 24))),
              const Spacer(flex: 3),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Help us grow', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 32, fontFamily: 'SFProRound', color: Colors.white))),
              const SizedBox(height: 30),
              Image.asset('assets/images/bot-head-bg.png', width: 160),
              const SizedBox(height: 24),
              SizedBox(
                height: 30,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Image.asset('assets/images/star.png', width: 27, height: 27),
                    );
                }),
              ),
              const SizedBox(height: 30),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 17,
                    fontFamily: 'SFProRound',
                    color: Colors.white,
                  ),
                  children: [
                    TextSpan(
                      text: 'We created this app to enable men and woman an ',
                    ),
                    TextSpan(
                      text: 'affordable way',
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                    TextSpan(
                      text:
                      ' to attain a dating coach while navigating through ',
                    ),
                    TextSpan(
                      text: 'a huge part of your life that we call dating',
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                    TextSpan(
                      text: '. \n\nWe’d be extremely grateful for a positive review! ',
                    ),
                    WidgetSpan(
                        child: Icon(Icons.favorite, color: Color(0xff582AFF), size: 20))
                  ],
                ),
              ),
              const Spacer(flex: 2),
              CustomButton(
                  onTap: showInAppReview,
                  title: 'Continue'),
              const Spacer(flex: 2),
            ],
          ),
        ),
      )
    );
  }
}
