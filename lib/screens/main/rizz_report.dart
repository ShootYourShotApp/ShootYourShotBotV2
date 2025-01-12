import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sysbotv2/screens/main/rizz_report_carousel_items/individual_item_widget.dart';
import 'package:sysbotv2/screens/main/rizz_report_carousel_items/rizz_report_widget.dart';
import 'package:sysbotv2/widgets/custom_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'menu_bottom_sheet.dart';

class RizzReport extends StatefulWidget {
  const RizzReport({super.key});

  @override
  State<RizzReport> createState() => _RizzReportState();
}

class _RizzReportState extends State<RizzReport> {
  final carouselController = PageController();
  int currentIndex = 0;
  double overallScore = 100;
  double juiceLevelScore = 50;
  double flexFactorScore = 75;
  double pickupGameScore = 80;
  double dripCheckScore = 25;
  double goalDiggerScore = 85;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0A0A0A),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 28),
              Padding(
                padding: const EdgeInsets.only(right: 30),
                child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                        onTap: () {
                          openMenuBottomSheet(context);
                        },
                        child: Image.asset('assets/images/menu-icon.png',
                            width: 30))),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Rizz Report',
                        style: TextStyle(
                            fontFamily: 'SFProRound',
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 24))),
              ),
              Stack(
                children: [
                  SizedBox(
                    height: 520,
                    child: PageView(
                      dragStartBehavior: DragStartBehavior.down,
                      controller: carouselController,
                      onPageChanged: (index) {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                      children: [
                        RizzReportWidget(
                            overallScore: overallScore,
                            juiceLevelScore: juiceLevelScore,
                            dripCheckScore: dripCheckScore,
                            flexFactorScore: flexFactorScore,
                            goalDiggerScore: goalDiggerScore,
                            pickupGameScore: pickupGameScore),
                        IndividualItemWidget(
                            title: 'Flex Factor',
                            subtitle:
                                'Measures your ability to stay poised and self-assured in social settings, projecting confidence without arrogance.',
                            iconPath: 'assets/images/flexed-biceps-icon.png',
                            borderClr: Color(0xffF6D13F),
                            gradientClrs: [Color(0xffFFFF00), Color(0xffEACDA3)],
                            percentage: flexFactorScore),
                        IndividualItemWidget(
                            title: 'Drip Check',
                            subtitle:
                                'Evaluates your style, grooming, and physical presence to ensure you’re making a strong first impression.',
                            iconPath: 'assets/images/water-drop-icon.png',
                            borderClr: Color(0xff8EC5FC),
                            gradientClrs: [Color(0xff4FACFE), Color(0xff00F2FE)],
                            percentage: dripCheckScore),
                        IndividualItemWidget(
                            title: 'Juice Level',
                            subtitle:
                                'Reflects your charisma and ability to connect, captivate, and stand out in group dynamics.',
                            iconPath: 'assets/images/juice-box-icon.png',
                            borderClr: Color(0xff04B115),
                            gradientClrs: [Color(0xff43E97B), Color(0xff38F9D7)],
                            percentage: juiceLevelScore),
                        IndividualItemWidget(
                            title: 'Pickup Game',
                            subtitle:
                                'Scores your creativity, humor, and ability to spark chemistry in flirty, engaging interactions.',
                            iconPath: 'assets/images/ball.png',
                            borderClr: Color(0xffFF9B2C),
                            gradientClrs: [Color(0xffF6D365), Color(0xffFDA085)],
                            percentage: pickupGameScore,
                            iconSize: 65),
                        IndividualItemWidget(
                            title: 'Goal Digger',
                            subtitle:
                                'Assesses your ambition and drive, showcasing how you pursue personal or professional growth.',
                            iconPath: 'assets/images/trophy-icon.png',
                            borderClr: Color(0xffFFAE00),
                            gradientClrs: [Color(0xffF89418), Color(0xffEACDA3)],
                            percentage: goalDiggerScore,
                            iconSize: 56),
                        IndividualItemWidget(
                            title: 'Overall',
                            subtitle:
                                'A snapshot of how well-rounded you are across all categories, highlighting strengths and improvement areas.',
                            iconPath: 'assets/images/100-emoji.png',
                            borderClr: Color(0xff000000),
                            gradientClrs: [Color(0xff1e1e1e), Color(0xff1e1e1e)],
                            percentage: overallScore,
                            titleClr: const Color(0xffFB2812),
                            iconSize: 52),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 34,
                    child: Center(
                      child: SmoothPageIndicator(
                        controller: carouselController,
                        count: 7,
                        effect: const SwapEffect(
                          activeDotColor: Color(0xFFFFFFFF),
                          dotColor: Color(0xff5B5B5B),
                          dotHeight: 8,
                          dotWidth: 8,
                          spacing: 8,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Expanded(
                        child: CustomButton(
                            height: 56,
                            title: 'Save',
                            iconPath: 'assets/images/download-icon.png',
                            iconSize: 17,
                            bgClr: const Color(0xffF8F8F8),
                            txtClr: Colors.black)),
                    SizedBox(width: 20),
                    Expanded(
                        child: CustomButton(
                            height: 56,
                            title: 'Share',
                            iconPath: 'assets/images/share-icon.png',
                            iconSize: 16,
                            bgClr: const Color(0xffF8F8F8),
                            txtClr: Colors.black))
                  ],
                ),
              ),
              const SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }
}
