import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sysbotv2/screens/onboarding/referral_code_bottom_sheet.dart';
import 'package:sysbotv2/widgets/custom_button.dart';
import 'package:sysbotv2/widgets/gradient_text.dart';

class SeeMyResult extends StatelessWidget {
  SeeMyResult({super.key});

  final RxBool isLoading = false.obs;
  final RxBool showNoMoreInvitesTxt = false.obs;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xff0A0A0A),
      body: SafeArea(
        child: SizedBox(
          width: width,
          height: height,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.close,
                            size: 20, color: const Color(0xff979797)),
                        Padding(
                          padding: const EdgeInsets.only(top: 6, bottom: 4),
                          child: Image.asset('assets/images/eyes-icon.png',
                              width: 46),
                        ),
                        const SizedBox(width: 24)
                      ],
                    ),
                  ),
                  GradientText(
                      gradientColors: [Color(0xffD9AFD9), Color(0xff97D9E1)],
                      textWidget: Text('See My Results'.toUpperCase(),
                          style: TextStyle(
                              fontFamily: 'LuckiestGuy',
                              color: Colors.white,
                              fontSize: 32))),
                  const Spacer(flex: 2),
                  Container(
                    width: 245,
                    height: 350,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0xff582AFF),
                              spreadRadius: 1,
                              blurRadius: 70,
                              offset: const Offset(0, 2))
                        ],
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/images/rizz-quiz-container.png'),
                            fit: BoxFit.fill)),
                    child: Column(
                      children: [
                        const SizedBox(height: 110),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            OptionsWidget(
                                label: 'Overall',
                                iconPath: 'assets/images/100-emoji.png'),
                            const SizedBox(width: 20),
                            OptionsWidget(
                                label: 'Juice Level',
                                iconPath: 'assets/images/juice-box-icon.png'),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            OptionsWidget(
                                label: 'Flex Factor',
                                iconPath:
                                    'assets/images/flexed-biceps-icon.png'),
                            const SizedBox(width: 20),
                            OptionsWidget(
                                label: 'Pickup Game',
                                iconPath: 'assets/images/ball.png'),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            OptionsWidget(
                                label: 'Drip Check',
                                iconPath: 'assets/images/water-drop-icon.png'),
                            const SizedBox(width: 20),
                            OptionsWidget(
                                label: 'Goal Digger',
                                iconPath: 'assets/images/trophy-icon.png'),
                          ],
                        ),
                        const SizedBox(height: 22),
                        Text('© Rizz Report',
                            style: TextStyle(
                                fontFamily: 'ShareTechMono',
                                color: Colors.white,
                                fontSize: 12))
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text('1,000,000 reports completed',
                        style: TextStyle(
                            fontFamily: 'SFProRound',
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w400)),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: CustomButton(
                        title: 'Get Shot Bot Pro',
                        iconPath: 'assets/images/raising-hands-emoji.png',
                        iconSize: 22),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: CustomButton(
                        onTap: () {
                          openReferralCodeBottomSheet(
                              context: context,
                              isLoading: isLoading,
                              showNoMoreInvitesTxt: showNoMoreInvitesTxt);
                        },
                        title: 'Invite 3 Friends',
                        bgClr: Colors.transparent,
                        borderWidth: 3),
                  ),
                  const Spacer(),
                ],
              ),
              Obx(() => Visibility(
                    visible: isLoading.value,
                    child: Container(
                      height: height,
                      width: width,
                      color: Colors.black.withValues(alpha: 0.7),
                      child: showNoMoreInvitesTxt.value == false
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Checking Referrals...',
                                    style: TextStyle(
                                        fontFamily: 'SFProRound',
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 20)),
                                const SizedBox(height: 5),
                                LoadingAnimationWidget.progressiveDots(
                                  color: Colors.white,
                                  size: 36,
                                )
                              ],
                            )
                          : Center(
                              child: Text('Need more invites',
                                  style: TextStyle(
                                      fontFamily: 'SFProRound',
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 20))),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class OptionsWidget extends StatelessWidget {
  const OptionsWidget({super.key, required this.iconPath, required this.label});

  final String label;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              WidgetSpan(
                child: Image.asset(
                  iconPath,
                  width: 15,
                  height: 15,
                ),
              ),
              TextSpan(
                text: ' $label',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'SFProRound'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
                width: 40,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
                child: Text('100%',
                    style: TextStyle(
                        fontFamily: 'SFCompactRounded',
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 10)))),
        const SizedBox(height: 6),
        Container(
          height: 7,
          width: 85,
          decoration: BoxDecoration(
              color: const Color(0xff582AFF),
              borderRadius: BorderRadius.circular(8)),
        )
      ],
    );
  }
}
