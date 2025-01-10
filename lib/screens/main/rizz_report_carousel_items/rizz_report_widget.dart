import 'package:flutter/material.dart';

import '../../../widgets/rizz_report_option_widget.dart';

class RizzReportWidget extends StatelessWidget {
  const RizzReportWidget({super.key, required this.overallScore, required this.flexFactorScore, required this.dripCheckScore, required this.goalDiggerScore, required this.juiceLevelScore, required this.pickupGameScore});
  final double overallScore;
  final double juiceLevelScore;
  final double flexFactorScore;
  final double pickupGameScore;
  final double dripCheckScore;
  final double goalDiggerScore;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Stack(
        children: [
          Positioned(
            top: 80,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 270,
                height: 360,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                        color: const Color(0xff582AFF).withValues(alpha: 0.4),
                        spreadRadius: 0,
                        blurRadius: 65,
                        offset: const Offset(0, 2)
                    )
                  ],
                  gradient: LinearGradient(
                    colors: [Color(0xff2f2f2f), Color(0xff101010), Color(0xff000000)],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 80),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OptionsWidget(label: 'Overall', iconPath: 'assets/images/100-emoji.png', percentage: overallScore),
                        const SizedBox(width: 20),
                        OptionsWidget(label: 'Juice Level', iconPath: 'assets/images/juice-box-icon.png', percentage: juiceLevelScore),
                      ],
                    ),
                    const SizedBox(height: 36),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OptionsWidget(label: 'Flex Factor', iconPath: 'assets/images/flexed-biceps-icon.png', percentage: flexFactorScore),
                        const SizedBox(width: 20),
                        OptionsWidget(label: 'Pickup Game', iconPath: 'assets/images/ball.png', percentage: pickupGameScore),
                      ],
                    ),
                    const SizedBox(height: 36),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OptionsWidget(label: 'Drip Check', iconPath: 'assets/images/water-drop-icon.png', percentage: dripCheckScore),
                        const SizedBox(width: 20),
                        OptionsWidget(label: 'Goal Digger', iconPath: 'assets/images/trophy-icon.png', percentage: goalDiggerScore),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Text('© Rizz Report', style: TextStyle(fontFamily: 'ShareTechMono', color: Colors.white, fontSize: 12))
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 26,
            child: Center(child: Image.asset('assets/images/bot-head-with-bg.png', width: 116)),
          ),
          Positioned(
              top: 95,
              right: 126,
              child: Image.asset('assets/images/edit-icon-with-gradient-bg.png', width: 26))
        ],
      ),
    );
  }
}