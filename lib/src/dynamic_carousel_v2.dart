import 'package:dynamic_carousel/src/carousel_item_widget.dart';
import 'package:dynamic_carousel/src/enums.dart';
import 'package:dynamic_carousel/src/models.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class DynamicCarousel extends StatefulWidget {
  const DynamicCarousel({
    super.key,
    this.width = 500,
    this.height = 200,
    this.bigItemHeight = 200,
    this.bigItemWidth = 200,
    this.smallItemHeight = 100,
    this.smallItemWidth = 100,
    this.verticalAlignment = 0.7,
    this.afterOffset = 32,
    required this.children,
  });

  /// total width of the carousel
  final double width;

  /// overall height of the carousel
  final double height;

  /// height of the expanded carousel item
  final double bigItemHeight;

  /// width of the expanded carousel item
  final double bigItemWidth;

  /// height of the small carousel item
  final double smallItemHeight;

  /// width of the small carousel item
  final double smallItemWidth;

  /// vertical alignment of the small carousel items
  final double verticalAlignment;

  /// after offset [remove this later]
  final double afterOffset;

  /// list of widgets for the widget
  final List<Widget> children;

  @override
  State<DynamicCarousel> createState() => _DynamicCarouselState();
}

class _DynamicCarouselState extends State<DynamicCarousel>
    with SingleTickerProviderStateMixin {
  int activePage = 0;
  bool updateStack = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: ((details) {
        if (details.velocity.pixelsPerSecond.dx > 0) {
          _leftSwipe();
        } else {
          _rightSwipe();
        }
      }),
      child: Container(
        width: widget.width,
        height: widget.height,
        color: Colors.grey,
        child: Stack(
          children: stackItems(),
        ),
      ),
    );
  }

  List<Widget> stackItems() {
    // List<CarouselData> currentItemList = updateListOnly();
    final result = widget.children.mapIndexed((index, item) {
      PagePos pos;
      if (index < activePage - 1) {
        pos = PagePos.farBefore;
      } else if (index == activePage - 1) {
        pos = PagePos.before;
      } else if (index == activePage) {
        pos = PagePos.current;
      } else if (index == activePage + 1) {
        pos = PagePos.after;
      } else if (index == activePage + 2) {
        pos = PagePos.farAfter;
      } else {
        pos = PagePos.farFarAfter;
      }
      return CarouselData(item, pos, pos);
    }).toList();

    return result.mapIndexed((index, item) {
      PagePos currentPos = item.currentPos;
      Widget currentItem = item.item;

      return CarouselItemWidget(
        currentPos: currentPos,
        stackWidth: widget.width,
        bigItemWidth: widget.bigItemWidth,
        bigItemHeight: widget.bigItemHeight,
        smallItemWidth: widget.smallItemWidth,
        smallItemHeight: widget.smallItemHeight,
        afterOffset: widget.afterOffset,
        verticalOffset: widget.verticalAlignment,
        child: currentItem,
      );
    }).toList();
  }

  void _rightSwipe() {
    setState(() {
      if (activePage < widget.children.length - 1) {
        activePage += 1;
      }
    });
  }

  void _leftSwipe() async {
    setState(() {
      if (activePage > 0) {
        activePage -= 1;
      }
    });
  }
}
