import 'package:flutter/material.dart';

import '../../../widgets/gradient_cricular_progress.dart';
import '../../../widgets/gradient_text.dart';

class IndividualItemWidget extends StatelessWidget {
  const IndividualItemWidget(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.iconPath,
      this.iconSize,
      required this.gradientClrs,
      required this.borderClr,
      required this.percentage,
      this.titleClr});

  final List<Color> gradientClrs;
  final Color borderClr;
  final String title;
  final String subtitle;
  final String iconPath;
  final double percentage;
  final double? iconSize;
  final Color? titleClr;

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
                  )),
              child: Column(
                children: [
                  SizedBox(height: height*0.09),
                  GradientText(
                      textWidget: Text(title.toUpperCase(),
                          style: TextStyle(
                              fontFamily: 'LuckiestGuy',
                              fontSize: width*0.085,
                              color: Colors.white)),
                      gradientColors: titleClr != null
                          ? [titleClr!, titleClr!]
                          : gradientClrs),
                  GradientCircularProgress(percentage: percentage),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(subtitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'SFCompactRounded',
                            fontSize: width*0.04166,
                            color: Colors.white,
                            fontWeight: FontWeight.w300)),
                  ),
                  const Spacer(),
                  Text('© Rizz Report',
                      style: TextStyle(
                          fontFamily: 'ShareTechMono',
                          color: Colors.white,
                          fontSize: width* 0.0333)),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: height*0.0345,
          child: Container(
            width: width*0.2916,
            height: width*0.2916,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: borderClr, width: 3),
                gradient: LinearGradient(
                    colors: gradientClrs,
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    stops: [0, 0.7])),
            child:
                Center(child: Image.asset(iconPath, width: iconSize ?? width*0.1666)),
          ),
        )
      ],
    );
  }
}
