import 'package:dynamic_carousel/src/enums.dart';
import 'package:flutter/material.dart';

class CarouselItemWidget extends StatelessWidget {
  final PagePos currentPos;
  final PagePos previousPos;
  final Widget child;
  final double bigItemWidth;
  final double bigItemHeight;
  final double smallItemWidth;
  final double smallItemHeight;

  const CarouselItemWidget({
    super.key,
    required this.currentPos,
    required this.previousPos,
    required this.child,
    required this.bigItemWidth,
    required this.bigItemHeight,
    required this.smallItemWidth,
    required this.smallItemHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: currentPos.isBefore
          ? Alignment(0.75, 0)
          : currentPos.isCurrent
              ? Alignment(0, 0)
              : currentPos.isAfter
                  ? Alignment(-0.75, 0)
                  : currentPos.isFarBefore
                      ? Alignment(1, 0)
                      : Alignment(-1, 0),
      child: Container(
        width: currentPos.isCurrent
            ? bigItemWidth
            : currentPos.isFar
                ? smallItemHeight! - 15
                : smallItemWidth,
        height: currentPos.isCurrent
            ? bigItemHeight
            : currentPos.isFar
                ? smallItemWidth! - 15
                : smallItemHeight,
        child: SizedBox(
            width: currentPos.isCurrent ? null : smallItemWidth,
            height: currentPos.isCurrent ? null : smallItemHeight,
            child: child),
      ),
    );
  }
}
