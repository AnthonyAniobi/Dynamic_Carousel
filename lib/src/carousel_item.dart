import 'package:dynamic_carousel/src/enums.dart';
import 'package:dynamic_carousel/src/models.dart';
import 'package:flutter/material.dart';

class CarouselItem extends StatelessWidget {
  const CarouselItem({
    super.key,
    required this.bigItemWidth,
    required this.bigItemHeight,
    required this.smallItemWidth,
    required this.smallItemHeight,
    required this.startAnimating,
    required this.forward,
    required this.animation,
    required this.data,
    this.onDeleteWidget,
    this.smallestFraction = 0.9,
    required this.onDelete,
  });

  final double bigItemWidth;
  final double bigItemHeight;
  final double smallItemWidth;
  final double smallItemHeight;
  final bool startAnimating;
  final bool forward;
  final double animation;
  final CarouselData data;
  final double smallestFraction;
  final Function onDelete;
  final Widget? onDeleteWidget;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(xAlign(), 0),
      child: Container(
        height: height(),
        width: width(),
        decoration: data.currentPos.isCurrent
            ? BoxDecoration(boxShadow: [
                BoxShadow(
                    offset: const Offset(1, 5),
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 4)
              ])
            : null,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            children: [
              data.item,
              if (data.currentPos.isCurrent)
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: onDeleteWidget ??
                      SizedBox(
                        width: 35,
                        height: 35,
                        child: InkWell(
                          onTap: () {
                            onDelete();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.orange,
                            ),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                              size: 23,
                            ),
                          ),
                        ),
                      ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  double get smallestHeight => smallItemHeight * smallestFraction;
  double get smallestWidth => smallItemWidth * smallestFraction;
  double get smallWidthDiff => smallItemWidth * (1 - smallestFraction);
  double get smallHeightDiff => smallItemHeight * (1 - smallestFraction);
  double get bigWidthDiff => bigItemWidth - smallItemWidth;
  double get bigHeightDiff => bigItemHeight - smallItemHeight;

  double height() {
    return startAnimating ? _animatedHeight() : _itemHeight();
  }

  double width() {
    return startAnimating ? _animatedWidth() : _itemWidth();
  }

  double xAlign() {
    return startAnimating ? _animatedXAlign() : _xAlign();
  }

  double _animatedXAlign() {
    switch (data.currentPos) {
      case PagePos.current:
        return forward ? 0.75 * animation : -0.75 * animation;
      case PagePos.before:
        return forward
            ? -0.75 + (0.75 * animation)
            : -0.75 - (0.25 * animation);
      case PagePos.farBefore:
        return forward ? -1 + (0.25 * animation) : -1;
      case PagePos.after:
        return forward ? 0.75 + (0.25 * animation) : 0.75 - (0.75 * animation);
      case PagePos.farAfter:
        return forward ? 1 : 1 - (0.25 * animation);
      default:
        throw Exception('custom error');
    }
  }

  double _animatedHeight() {
    switch (data.currentPos) {
      case PagePos.current:
        return forward
            ? bigItemHeight - (animation * bigHeightDiff)
            : bigItemHeight - (animation * bigHeightDiff);
      case PagePos.before:
        return forward
            ? smallItemHeight + (animation * bigHeightDiff)
            : smallItemHeight - (animation * smallHeightDiff);
      case PagePos.farBefore:
        return forward
            ? smallestHeight + (animation * smallHeightDiff)
            : smallestHeight;
      case PagePos.after:
        return forward
            ? smallItemHeight - (animation * smallHeightDiff)
            : smallItemHeight + (animation * bigHeightDiff);
      case PagePos.farAfter:
        return forward
            ? smallestHeight
            : smallestHeight + (animation * smallHeightDiff);
      default:
        throw Exception('custom error position not available');
    }
  }

  double _animatedWidth() {
    switch (data.currentPos) {
      case PagePos.current:
        return forward
            ? bigItemWidth - (animation * bigWidthDiff)
            : bigItemWidth - (animation * bigWidthDiff);
      case PagePos.before:
        return forward
            ? smallItemWidth + (animation * bigWidthDiff)
            : smallItemWidth - (animation * smallWidthDiff);
      case PagePos.farBefore:
        return forward
            ? smallestWidth + (animation * smallWidthDiff)
            : smallestWidth;
      case PagePos.after:
        return forward
            ? smallItemWidth - (animation * smallWidthDiff)
            : smallItemWidth + (animation * bigWidthDiff);
      case PagePos.farAfter:
        return forward
            ? smallestWidth
            : smallestWidth + (animation * smallWidthDiff);
      default:
        throw Exception('custom error position not available');
    }
  }

  double _itemHeight() {
    if (data.currentPos.isCurrent) {
      return bigItemHeight;
    } else if (data.currentPos.isFar) {
      return smallestHeight;
    } else {
      return smallItemHeight;
    }
  }

  double _itemWidth() {
    if (data.currentPos.isCurrent) {
      return bigItemWidth;
    } else {
      return smallItemWidth;
    }
  }

  double _xAlign() {
    switch (data.currentPos) {
      case PagePos.farBefore:
        return -1;
      case PagePos.before:
        return -0.75;
      case PagePos.current:
        return 0;
      case PagePos.after:
        return 0.75;
      case PagePos.farAfter:
        return 1;
      default:
        throw Exception('custom exception position not available');
    }
  }
}
