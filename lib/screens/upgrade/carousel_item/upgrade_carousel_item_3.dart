import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/gradient_text.dart';

class UpgradeCarouselItem3 extends StatelessWidget {
  const UpgradeCarouselItem3({super.key});

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
            child: Image.asset('assets/images/game-controller-icon.png',
                width: width*0.1333)),
        const SizedBox(height: 8),
        GradientText(
            textWidget: Text('Rizz Games'.toUpperCase(),
                style: TextStyle(
                    fontFamily: 'LuckiestGuy',
                    color: Colors.white,
                    fontSize: width*0.0888))),
        const SizedBox(height: 12),
        Expanded(
          child: Stack(
            children: [
              Positioned(
                top: height*0.0505,
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
                                  .withValues(alpha: 0.6),
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
                        SizedBox(height: height*0.29255),
                        Text('Level Up Gamification',
                            style: TextStyle(
                                fontFamily: 'SFProRound',
                                color: Colors.white,
                                fontSize: width*0.0444,
                                fontWeight: FontWeight.w900)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                              'Earn points for every 30 minute session and compete with other rizzlers worldwide',
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
                    child: Image.asset('assets/images/upgrade3-img.png',
                        height: height*0.3404)),
              )
            ],
          ),
        ),
      ],
    );
  }
}
