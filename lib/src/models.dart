import 'package:dynamic_carousel/src/enums.dart';
import 'package:flutter/material.dart';

class Data {}

class CarouselData {
  final Widget item;
  PagePos currentPos;

  CarouselData(this.item, this.currentPos);

  void setCurrent(PagePos pos) {
    currentPos = pos;
  }
}

class TrackBarProperties {
  final Color trackbarColor;
  final Color sliderColor;
  final double sliderHeight;
  final double trackbarLength;
  final double topSpacing;

  TrackBarProperties({
    required this.trackbarColor,
    required this.sliderColor,
    this.sliderHeight = 8,
    this.trackbarLength = 100,
    required this.topSpacing,
  });
}
