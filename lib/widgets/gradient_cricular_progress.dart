import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class GradientCircularProgress extends StatelessWidget {
  GradientCircularProgress({
    super.key,
    required this.percentage,
  });

  final double percentage; // Current value to display
  final List<Color> gradientColors = [Color(0xffF6D365), Color(0xffCCB7EE), Color(0xffFF6D6D), Color(0xffF6D365)];

  @override
  Widget build(BuildContext context) {
    // Calculate stops dynamically based on the number of gradient colors
    final List<double> stops = List.generate(
      gradientColors.length,
          (index) => index / (gradientColors.length - 1),
    );

    return SizedBox(
      height: 90,
      width: 90,
      child: SfRadialGauge(
        enableLoadingAnimation: true,
        axes: [
          RadialAxis(
            minimum: 0,
            maximum: 100,
            startAngle: 270,
            endAngle: 270,
            showLabels: false,
            showTicks: false,
            axisLineStyle: AxisLineStyle(
              thickness: 11,
              color: const Color(0xff434343), // Background track color
            ),
            pointers: [
              RangePointer(
                value: percentage,
                width: 11,
                gradient: SweepGradient(
                  colors: gradientColors,
                  stops: stops, // Explicitly define stops for multiple colors
                ),
                cornerStyle: CornerStyle.bothFlat, // Smooth rounded ends
              ),
            ],
            annotations: [
              GaugeAnnotation(
                widget: Text(
                  "${percentage.toInt()}",
                  style: const TextStyle(
                    fontFamily: 'SFCompactRounded',
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}