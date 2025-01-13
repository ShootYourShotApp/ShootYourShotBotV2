import 'package:flutter/material.dart';

class OptionsWidget extends StatelessWidget {
  const OptionsWidget(
      {super.key,
      required this.iconPath,
      required this.label,
      required this.percentage,
      this.hidePercentage,
      this.progressWidth,
        this.iconSize,
        this.fontSize,
        this.percentageSize
      });

  final String label;
  final String iconPath;
  final double percentage;
  final bool? hidePercentage;
  final double? progressWidth;
  final double? iconSize;
  final double? fontSize;
  final double? percentageSize;

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
                  width: iconSize ?? 15,
                  height: iconSize ?? 15,
                ),
              ),
              TextSpan(
                text: ' $label',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: fontSize ?? 12,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'SFProRound'),
              ),
            ],
          ),
        ),
        Visibility(
            visible: hidePercentage != true,
            child: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text("${percentage.toInt()}%",
                  style: TextStyle(
                      fontFamily: 'SFCompactRounded',
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: percentageSize ?? 10)),
            )),
        const SizedBox(height: 6),
        SizedBox(
          height: 7,
          width: progressWidth ?? 90,
          child: LinearProgressIndicator(
            value: percentage / 100,
            minHeight: 7,
            borderRadius: BorderRadius.circular(8),
            backgroundColor: const Color(0xff434343),
            color: const Color(0xff582AFF),
          ),
        ),
      ],
    );
  }
}
