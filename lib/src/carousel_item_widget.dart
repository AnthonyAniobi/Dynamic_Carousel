import 'package:dynamic_carousel/src/enums.dart';
import 'package:flutter/material.dart';

class CarouselItemWidget extends StatelessWidget {
  final PagePos currentPos;
  final Widget child;
  final double stackWidth;
  final double bigItemWidth;
  final double bigItemHeight;
  final double smallItemWidth;
  final double smallItemHeight;
  final Function onEnd;

  const CarouselItemWidget({
    super.key,
    required this.currentPos,
    required this.child,
    required this.stackWidth,
    required this.bigItemWidth,
    required this.bigItemHeight,
    required this.smallItemWidth,
    required this.smallItemHeight,
    required this.onEnd,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedAlign(
      duration: const Duration(milliseconds: 200),
      onEnd: () {
        onEnd();
      },
      alignment: _alignment(),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: currentPos.isAfter
            ? EdgeInsets.only(left: hAShift())
            : currentPos.isFarAfter
                ? EdgeInsets.only(left: hFAShift())
                : null,
        width: _width(),
        height: _height(),
        child: child,
      ),
    );
  }

  double hAShift() {
    double width = stackWidth / 2;
    width = width * 0.73;
    width = width - bigItemWidth / 2;
    width = width - smallItemWidth / 2;
    return width;

    // double width = stackWidth - bigItemWidth;
    // width = width * 0.125;
    // width = smallItemWidth + bigItemWidth / 2 + width;
    // stackWidth =
    // print(width);
    // width = bigItemWidth / 2 + smallItemWidth + width;
    // width = stackWidth / 2 - width;
    return 2;
  }

  double hFAShift() {
    double width = stackWidth - bigItemWidth;
    width = width * 0.125;
    width = smallItemHeight - width;
    return width;
  }

  Alignment _alignment() {
    if (currentPos.isFarBefore) {
      return const Alignment(-1, 0);
    } else if (currentPos.isBefore) {
      return const Alignment(-0.75, 0);
    } else if (currentPos.isCurrent) {
      return const Alignment(0, 0);
    } else if (currentPos.isAfter) {
      return const Alignment(0.75, 0);
    } else {
      return const Alignment(1, 0);
    }
  }

  // Alignment _alignment() {
  //   if (currentPos.isFarBefore) {
  //     return noChange
  //         ? const Alignment(-1, 0)
  //         : Alignment(-0.75 - (0.25 * animation), 0);
  //   } else if (currentPos.isBefore) {
  //     return noChange
  //         ? const Alignment(-0.75, 0)
  //         : previousPos.isFarBefore
  //             ? Alignment(-0.75 * -(0.25 * animation), 0)
  //             : Alignment(-0.75 * animation, 0);
  //   } else if (currentPos.isCurrent) {
  //     return noChange
  //         ? const Alignment(0, 0)
  //         : previousPos.isBefore
  //             ? Alignment(0.75 * animation, 0)
  //             : Alignment(0.75 * (1 - animation), 0);
  //   } else if (currentPos.isAfter) {
  //     return noChange
  //         ? const Alignment(0.75, 0)
  //         : previousPos.isCurrent? Alignment(0.75*animation, 0):Alignment(1-(0.25*animation), );
  //   } else {
  //     return previousPos.isAfter
  //         ? Alignment(0.75 + (0.25 * animation), 0)
  //         : const Alignment(1, 0);
  //   }
  // }

  double _height() {
    if (currentPos.isCurrent) {
      return bigItemHeight;
    } else if (currentPos.isFar) {
      return smallItemHeight - 15;
    } else {
      return smallItemHeight;
    }
  }

  double _width() {
    if (currentPos.isCurrent) {
      return bigItemWidth;
    } else if (currentPos.isFar) {
      return smallItemWidth;
    } else {
      return smallItemWidth;
    }
  }
}
