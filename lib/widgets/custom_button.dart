import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.title, this.iconPath, this.width, this.height, this.fontSize});
  final double? width;
  final double? height;
  final double? fontSize;
  final String title;
  final String? iconPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? MediaQuery.of(context).size.width,
      height: height ?? 60,
      decoration: BoxDecoration(
        color: const Color(0xff582AFF),
        borderRadius: BorderRadius.circular(50)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: TextStyle(fontFamily: 'SFProRound', fontWeight: FontWeight.w800, color: Colors.white, fontSize: fontSize ?? 20)),
          Visibility(
            visible: iconPath != null,
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Image.asset(iconPath ?? '', width: 19),
            ),
          )
        ],
      ),
    );
  }
}
