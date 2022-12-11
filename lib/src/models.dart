import 'package:dynamic_carousel/src/enums.dart';
import 'package:flutter/material.dart';

class Data {}

class CarouselData {
  final Widget item;
  PagePos currentPos;
  PagePos previousPos;

  CarouselData(this.item, this.currentPos, this.previousPos);

  void setCurrent(PagePos pos) {
    currentPos = pos;
  }

  void setPrev(PagePos pos) {
    previousPos = pos;
  }
}
