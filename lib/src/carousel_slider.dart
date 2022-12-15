import 'package:dynamic_carousel/src/models.dart';
import 'package:flutter/material.dart';

class CarouselSlider extends StatelessWidget {
  final int amount;
  final int position;
  final TrackBarProperties properties;

  late double sliderLength;
  CarouselSlider(
      {Key? key,
      required this.position,
      required this.amount,
      required this.properties})
      : super(key: key) {
    sliderLength = properties.trackbarLength / amount;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: properties.trackbarLength,
      height: 8,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            top: 0,
            bottom: 0,
            left: position * sliderLength,
            child: Container(
              width: sliderLength,
              height: 8,
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
    // double freeLength = trackLength - sliderLength;
    // if (freeLength <= 1) {
    //   return 0;
    // }
    // freeLength = (freeLength * position) / freeLength;
    // return -0.9 + (2 * freeLength);
    return 2;
  }
}
