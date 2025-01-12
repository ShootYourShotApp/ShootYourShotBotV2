import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sysbotv2/screens/bottom_nav_bar.dart';
import 'package:sysbotv2/utils/functions/open_url.dart';
import 'package:sysbotv2/widgets/custom_button.dart';
import 'package:get/get.dart';

import 'carousel_item/upgrade_carousel_item1.dart';
import 'carousel_item/upgrade_carousel_item2.dart';
import 'carousel_item/upgrade_carousel_item_3.dart';

class UpgradeScreen extends StatefulWidget {
  const UpgradeScreen({super.key});

  @override
  State<UpgradeScreen> createState() => _UpgradeScreenState();
}

class _UpgradeScreenState extends State<UpgradeScreen> {
  final carouselController = PageController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0A0A0A),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: Stack(
                children: [
                  PageView(
                    dragStartBehavior: DragStartBehavior.down,
                    controller: carouselController,
                    onPageChanged: (index) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    children: [
                      UpgradeCarouselItem1(),
                      UpgradeCarouselItem2(),
                      UpgradeCarouselItem3()
                    ],
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 50,
                    child: Center(
                      child: SmoothPageIndicator(
                        controller: carouselController,
                        count: 3,
                        effect: const SwapEffect(
                          activeDotColor: Color(0xFFFFFFFF),
                          dotColor: Color(0xff979797),
                          dotHeight: 8,
                          dotWidth: 8,
                          spacing: 8,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 20,
                    child: Center(
                      child: Text('1,000,000 reports completed',
                          style: TextStyle(
                              fontFamily: 'SFProRound',
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w400)),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomButton(
                  onTap: () => Get.to(BottomNavBar()),
                  title: 'Unlock now',
                  iconPath: 'assets/images/raising-hands-emoji.png'),
            ),
            const SizedBox(height: 6),
            Text("\$9.99 per week",
                style: TextStyle(
                    fontFamily: 'SFProRound',
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    color: Colors.white)),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                    onTap: () {
                      openUrl(
                          androidUrl: 'http://shootyourshot.ai/privacy',
                          iosUrl: 'http://shootyourshot.ai/privacy');
                    },
                    child: Text("Privacy",
                        style: TextStyle(
                            fontFamily: 'Avenir',
                            fontSize: 13,
                            color: Color(0xff979797)))),
                GestureDetector(
                    onTap: () {
                      openUrl(
                          androidUrl: 'http://shootyourshot.ai/terms',
                          iosUrl: 'http://shootyourshot.ai/terms');
                    },
                    child: Text("Terms",
                        style: TextStyle(
                            fontFamily: 'Avenir',
                            fontSize: 13,
                            color: Color(0xff979797)))),
                Text("Restore",
                    style: TextStyle(
                        fontFamily: 'Avenir',
                        fontSize: 13,
                        color: Color(0xff979797))),
              ],
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
