import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, this.onTap, required this.title, this.iconPath, this.iconSize, this.width, this.height, this.fontSize, this.bgClr, this.txtClr, this.borderWidth});
  final double? width;
  final double? height;
  final double? fontSize;
  final String title;
  final String? iconPath;
  final double? iconSize;
  final Color? bgClr;
  final Color? txtClr;
  final VoidCallback? onTap;
  final double? borderWidth;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? MediaQuery.of(context).size.width,
        height: height ?? 60,
        decoration: BoxDecoration(
          color: bgClr ?? const Color(0xff582AFF),
          borderRadius: BorderRadius.circular(50),
          border: Border.all(width: borderWidth ?? 0, color: borderWidth != null ? const Color(0xff582AFF) : Colors.transparent)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: TextStyle(fontFamily: 'SFProRound', fontWeight: FontWeight.w800, color: txtClr ?? Colors.white, fontSize: fontSize ?? 20)),
            Visibility(
              visible: iconPath != null,
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Image.asset(iconPath ?? '', width: iconSize ?? 19),
              ),
            )
          ],
        ),
      ),
    );
  }
}
