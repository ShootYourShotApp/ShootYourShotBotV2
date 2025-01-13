import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/gradient_text.dart';
import '../../../widgets/rizz_report_option_widget.dart';

class UpgradeCarouselItem2 extends StatelessWidget {
  const UpgradeCarouselItem2({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                  onTap: () => Get.back(),
                  child: Icon(Icons.close,
                      color: const Color(0xff979797), size: width*0.0555))),
        ),
        Center(
            child:
                Image.asset('assets/images/chart-decreasing.png', width: width*0.1388)),
        const SizedBox(height: 8),
        GradientText(
            textWidget: Text('Rizz Reports'.toUpperCase(),
                style: TextStyle(
                    fontFamily: 'LuckiestGuy',
                    color: Colors.white,
                    fontSize: width*0.0888))),
        const SizedBox(height: 10),
        Expanded(
          child: Stack(
            children: [
              Positioned(
                top: height*0.05319,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: width * 0.85,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0xff582AFF)
                                  .withValues(alpha: 0.7),
                              spreadRadius: 0,
                              blurRadius: 65,
                              offset: const Offset(0, 2)),
                        ],
                        gradient: LinearGradient(
                          colors: [
                            Color(0xff2f2f2f),
                            Color(0xff101010),
                            Color(0xff000000)
                          ],
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                        )),
                    child: Column(
                      children: [
                        SizedBox(height: height*0.08776),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            OptionsWidget(
                                label: 'Overall',
                                iconPath: 'assets/images/100-emoji.png',
                                percentage: 100,
                                hidePercentage: true,
                                progressWidth: width*0.3055,
                                fontSize: width*0.031944,
                                iconSize: width*0.0375,
                            ),
                            OptionsWidget(
                                label: 'Juice Level',
                                iconPath: 'assets/images/juice-box-icon.png',
                                percentage: 100,
                                hidePercentage: true,
                              progressWidth: width*0.3055,
                              fontSize: width*0.031944,
                              iconSize: width*0.0375),
                          ],
                        ),
                        SizedBox(height: height*0.03191),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            OptionsWidget(
                                progressWidth: width*0.3055,
                                fontSize: width*0.031944,
                                iconSize: width*0.0375,
                                hidePercentage: true,
                                label: 'Flex Factor',
                                iconPath:
                                    'assets/images/flexed-biceps-icon.png',
                                percentage: 100),
                            OptionsWidget(
                                progressWidth: width*0.3055,
                                fontSize: width*0.031944,
                                iconSize: width*0.0375,
                                hidePercentage: true,
                                label: 'Pickup Game',
                                iconPath: 'assets/images/ball.png',
                                percentage: 100),
                          ],
                        ),
                        SizedBox(height: height*0.03191),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            OptionsWidget(
                                progressWidth: width*0.3055,
                                fontSize: width*0.031944,
                                iconSize: width*0.0375,
                                hidePercentage: true,
                                label: 'Drip Check',
                                iconPath: 'assets/images/water-drop-icon.png',
                                percentage: 100),
                            OptionsWidget(
                                progressWidth: width*0.3055,
                                fontSize: width*0.031944,
                                iconSize: width*0.0375,
                                hidePercentage: true,
                                label: 'Goal Digger',
                                iconPath: 'assets/images/trophy-icon.png',
                                percentage: 100),
                          ],
                        ),
                        SizedBox(height: height*0.02925),
                        Text('Get Multiple Ratings',
                            style: TextStyle(
                                fontFamily: 'SFProRound',
                                color: Colors.white,
                                fontSize: width*0.0444,
                                fontWeight: FontWeight.w900)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                              'Psychology-backed questions & answers to keep track of where you are vs. your potential',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'SFProRound',
                                  color: Colors.white,
                                  fontSize: width*0.03888,
                                  fontWeight: FontWeight.w300)),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                child: Center(
                    child: Image.asset('assets/images/bot-head-with-bg.png',
                        width: 100)),
              )
            ],
          ),
        ),
      ],
    );
  }
}
