import 'package:flutter/material.dart';

class GradientText extends StatelessWidget {
  const GradientText(
      {super.key, required this.textWidget, this.gradientColors});

  final Widget textWidget;
  final List<Color>? gradientColors;

  //Use the text Color white of Text Widget to make the Gradient Work

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          colors:
              gradientColors ?? const [Color(0xffD9AFD9), Color(0xff97D9E1)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ).createShader(bounds);
      },
      child: textWidget,
    );
  }
}
