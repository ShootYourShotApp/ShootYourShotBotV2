import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/gradient_text.dart';

class UpgradeCarouselItem1 extends StatelessWidget {
  const UpgradeCarouselItem1({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                  onTap: () => Get.back(),
                  child: Icon(Icons.close,
                      color: const Color(0xff979797), size: 20))),
        ),
        Center(
            child: Image.asset('assets/images/studio-mic-icon.png', width: 48)),
        const SizedBox(height: 8),
        GradientText(
            textWidget: Text('Live Voice Chat'.toUpperCase(),
                style: TextStyle(
                    fontFamily: 'LuckiestGuy',
                    color: Colors.white,
                    fontSize: 32))),
        Expanded(
          child: Stack(
            children: [
              Positioned(
                top: 85,
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
                        const SizedBox(height: 206),
                        Text('1-on-1 Coaching Sessions',
                            style: TextStyle(
                                fontFamily: 'SFProRound',
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w900)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                              'Up to 30 minutes/wk of your Human Trained. AI Powered Personal Dating Coach',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'SFProRound',
                                  color: Colors.white,
                                  fontSize: 14,
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
                    child: Image.asset('assets/images/bot-2.png', width: 190)),
              )
            ],
          ),
        ),
      ],
    );
  }
}