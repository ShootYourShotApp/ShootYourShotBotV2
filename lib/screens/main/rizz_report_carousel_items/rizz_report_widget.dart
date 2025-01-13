import 'package:flutter/material.dart';

import '../../../widgets/rizz_report_option_widget.dart';

class RizzReportWidget extends StatelessWidget {
  const RizzReportWidget(
      {super.key,
      required this.overallScore,
      required this.flexFactorScore,
      required this.dripCheckScore,
      required this.goalDiggerScore,
      required this.juiceLevelScore,
      required this.pickupGameScore});

  final double overallScore;
  final double juiceLevelScore;
  final double flexFactorScore;
  final double pickupGameScore;
  final double dripCheckScore;
  final double goalDiggerScore;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Positioned(
          top: height*0.106,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              width: height*0.45212 * (255 / 340),
              height: height*0.45212,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                      color: const Color(0xff582AFF).withValues(alpha: 0.6),
                      spreadRadius: 0,
                      blurRadius: 65,
                      offset: const Offset(0, 2))
                ],
                gradient: LinearGradient(
                  colors: [
                    Color(0xff2f2f2f),
                    Color(0xff101010),
                    Color(0xff000000)
                  ],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: height*0.101),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OptionsWidget(
                          iconSize: width*0.04166,
                          fontSize: width*0.0333,
                          percentageSize: width*0.02777,
                          progressWidth: width*0.25,
                          label: 'Overall',
                          iconPath: 'assets/images/100-emoji.png',
                          percentage: overallScore),
                      const SizedBox(width: 20),
                      OptionsWidget(
                          iconSize: width*0.04166,
                          fontSize: width*0.0333,
                          percentageSize: width*0.02777,
                          progressWidth: width*0.25,
                          label: 'Juice Level',
                          iconPath: 'assets/images/juice-box-icon.png',
                          percentage: juiceLevelScore),
                    ],
                  ),
                  SizedBox(height: height*0.04255),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OptionsWidget(
                          iconSize: width*0.04166,
                          fontSize: width*0.0333,
                          percentageSize: width*0.02777,
                          progressWidth: width*0.25,
                          label: 'Flex Factor',
                          iconPath: 'assets/images/flexed-biceps-icon.png',
                          percentage: flexFactorScore),
                      const SizedBox(width: 20),
                      OptionsWidget(
                          iconSize: width*0.04166,
                          fontSize: width*0.0333,
                          percentageSize: width*0.02777,
                          progressWidth: width*0.25,
                          label: 'Pickup Game',
                          iconPath: 'assets/images/ball.png',
                          percentage: pickupGameScore),
                    ],
                  ),
                  SizedBox(height: height*0.04255),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OptionsWidget(
                          iconSize: width*0.04166,
                          fontSize: width*0.0333,
                          percentageSize: width*0.02777,
                          progressWidth: width*0.25,
                          label: 'Drip Check',
                          iconPath: 'assets/images/water-drop-icon.png',
                          percentage: dripCheckScore),
                      const SizedBox(width: 20),
                      OptionsWidget(
                          iconSize: width*0.04166,
                          fontSize: width*0.0333,
                          percentageSize: width*0.02777,
                          progressWidth: width*0.25,
                          label: 'Goal Digger',
                          iconPath: 'assets/images/trophy-icon.png',
                          percentage: goalDiggerScore),
                    ],
                  ),
                  SizedBox(height: height*0.0345),
                  Text('© Rizz Report',
                      style: TextStyle(
                          fontFamily: 'ShareTechMono',
                          color: Colors.white,
                          fontSize: width*0.0333))
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: height*0.03457,
          child: Center(
              child: Image.asset('assets/images/bot-head-with-bg.png',
                  width: width*0.3222)),
        ),
        Positioned(
            top: height*0.1263,
            right: width*0.35,
            child: Image.asset('assets/images/edit-icon-with-gradient-bg.png',
                width: width*0.07222))
      ],
    );
  }
}
