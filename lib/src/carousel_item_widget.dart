import 'package:dynamic_carousel/src/enums.dart';
import 'package:flutter/material.dart';

class CarouselItemWidget extends StatelessWidget {
  final PagePos currentPos;
  final Widget child;
  final double bigItemWidth;
  final double bigItemHeight;
  final double smallItemWidth;
  final double smallItemHeight;
  final Function onEnd;

  const CarouselItemWidget({
    super.key,
    required this.currentPos,
    required this.child,
    required this.bigItemWidth,
    required this.bigItemHeight,
    required this.smallItemWidth,
    required this.smallItemHeight,
    required this.onEnd,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedAlign(
      duration: const Duration(milliseconds: 250),
      onEnd: () {
        onEnd();
      },
      alignment: _alignment(),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: currentPos.isAfter
            ? EdgeInsets.only(left: hAShift(context))
            : currentPos.isFarAfter
                ? EdgeInsets.only(left: hFAShift(context))
                : null,
        width: _width(),
        height: _height(),
        child: Stack(
          children: [
            child,
          ],
        ),
      ),
    );
  }

  double hAShift(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double sideOffset = width * 0.1;
    return ((bigItemWidth / 2) + smallItemWidth + sideOffset) - (width / 2);
  }

  double hFAShift(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double sideOffset = width * 0.13;
    return ((bigItemWidth / 2) + smallItemWidth + sideOffset) - (width / 2);
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
      return smallItemWidth - 15;
    } else {
      return smallItemWidth;
    }
  }
}
