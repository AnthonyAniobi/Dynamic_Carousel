import 'package:dynamic_carousel/src/enums.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class DynamicCarousel extends StatefulWidget {
  const DynamicCarousel({super.key});

  @override
  State<DynamicCarousel> createState() => _DynamicCarouselState();
}

class _DynamicCarouselState extends State<DynamicCarousel>
    with SingleTickerProviderStateMixin {
  double? width = 500;
  double? height = 200;
  double? bigItemHeight = 200;
  double? bigItemWidth = 200;
  double? smallItemHeight = 100;
  double? smallItemWidth = 100;
  int activePage = 1;
  Duration animationDuration = const Duration(milliseconds: 250);

  //late initializations
  late AnimationController controller;
  late Animation<int> intAnimation;
  late Animation<double> containerHeight;
  late Animation<double> containerWidth;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: animationDuration);
    intAnimation = IntTween(begin: 0, end: 1).animate(controller);
    containerHeight =
        Tween(begin: bigItemHeight, end: smallItemHeight).animate(controller);
    containerWidth =
        Tween(begin: smallItemWidth, end: smallItemWidth).animate(controller);
    controller.addListener(() {
      if (controller.value > 0.5) setState(() {});
    });
  }

  List<Widget> carouselItems = [
    Container(
      width: double.maxFinite,
      height: double.maxFinite,
      color: Colors.yellow,
    ),
    Container(
      width: double.maxFinite,
      height: double.maxFinite,
      color: Colors.green,
    ),
    Container(
      width: double.maxFinite,
      height: double.maxFinite,
      color: Colors.blue,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: ((details) {
        if (details.velocity.pixelsPerSecond.dx > 0) {
          _rightSwipe();
        } else {
          _leftSwipe();
        }
      }),
      child: Container(
        width: width,
        height: height,
        color: Colors.grey,
        child: Stack(
          children: stackItems(),
        ),
      ),
    );
  }

  List<Widget> stackItems() {
    List<Map<PagePos, Widget>> beforeActive = carouselItems
        .sublist(0, activePage)
        .map((e) => {PagePos.before: e})
        .toList();
    List<Map<PagePos, Widget>> afterActive = carouselItems
        .sublist(activePage + 1, carouselItems.length)
        .map((e) => {PagePos.after: e})
        .toList();
    Map<PagePos, Widget> currentPage = {
      PagePos.current: carouselItems[activePage]
    };
    // List<Map<PagePos, Widget>> currentItemList = [
    //   ...beforeActive,
    //   ...afterActive,
    //   currentPage,
    // ];
    List<Map<PagePos, Widget>> currentItemList =
        carouselItems.mapIndexed((index, element) {
      PagePos pagePos;
      if (index < activePage - 1) {
        pagePos = PagePos.farBefore;
      } else if (index == activePage - 1) {
        pagePos = PagePos.before;
      } else if (index == activePage) {
        pagePos = PagePos.current;
      } else if (index == activePage + 1) {
        pagePos = PagePos.after;
      } else {
        pagePos = PagePos.farAfter;
      }
      return {pagePos: element};
    }).toList();
    return currentItemList.mapIndexed((index, item) {
      PagePos currentPos = item.keys.first;
      Widget currentItem = item.values.first;
      return AnimatedAlign(
        duration: animationDuration,
        alignment: currentPos.isBefore
            ? Alignment(0.75, 0)
            : currentPos.isCurrent
                ? Alignment(0, 0)
                : currentPos.isAfter
                    ? Alignment(-0.75, 0)
                    : currentPos.isFarBefore
                        ? Alignment(1, 0)
                        : Alignment(-1, 0),
        child: AnimatedContainer(
          duration: animationDuration,
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
              child: currentItem),
        ),
      );
    }).toList();
  }

  void _rightSwipe() {
    setState(() {
      if (activePage < carouselItems.length - 1) {
        activePage += 1;
      }
    });
  }

  void _leftSwipe() {
    setState(() {
      if (activePage > 0) {
        activePage -= 1;
        print(width);
      }
    });
  }
}
