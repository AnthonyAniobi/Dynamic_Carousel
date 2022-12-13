import 'package:flutter/material.dart';

class SliderWidget extends StatelessWidget {
  double position;
  final double trackLength = 100;
  final int amount;
  late double sliderLength;
  SliderWidget({
    Key? key,
    required this.position,
    required this.amount,
  }) : super(key: key) {
    sliderLength = trackLength / amount;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: trackLength,
      height: 8,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            duration: const Duration(milliseconds: 200),
            alignment: Alignment(xPos, 0),
            child: Container(
              // width: sliderLength,
              height: 8,
              padding: EdgeInsets.only(right: sliderLength),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ],
      ),
    );
  }

  double get xPos {
    if (position.isInfinite) {
      position = 0;
    }
    print(position);
    double freeLength =
        (amount == 1 ? trackLength : trackLength - sliderLength);
    freeLength = (freeLength * position) / freeLength;
    return -0.9 + (2 * freeLength);
    // return 2;
  }
}
