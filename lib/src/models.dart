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
  /// color of trackbar background
  ///
  /// default color is transparent
  final Color trackbarColor;

  /// The color of the slider
  ///
  /// this is required
  final Color sliderColor;

  /// Set the vertical height of the carousel slider
  ///
  /// the default height is 8pixels
  final double sliderHeight;

  /// set the horizontal length of the carousel slider
  ///
  /// the default lenght is 100 pixels
  final double trackbarLength;

  /// the spacing between the carousel and the slider
  final double topSpacing;

  TrackBarProperties({
    this.trackbarColor = Colors.transparent,
    required this.sliderColor,
    this.sliderHeight = 8,
    this.trackbarLength = 100,
    required this.topSpacing,
  });
}
