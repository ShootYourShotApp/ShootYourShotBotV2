import 'package:flutter/material.dart';

class OptionsWidget extends StatelessWidget {
  const OptionsWidget(
      {super.key,
      required this.iconPath,
      required this.label,
      required this.percentage,
      this.hidePercentage,
      this.progressWidth});

  final String label;
  final String iconPath;
  final double percentage;
  final bool? hidePercentage;
  final double? progressWidth;

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
        Visibility(
            visible: hidePercentage != true,
            child: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text("${percentage.toInt()}%",
                  style: TextStyle(
                      fontFamily: 'SFCompactRounded',
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 10)),
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
