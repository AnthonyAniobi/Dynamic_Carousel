import 'package:dynamic_carousel/src/carousel_item_widget.dart';
import 'package:dynamic_carousel/src/enums.dart';
import 'package:dynamic_carousel/src/models.dart';
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
  int activePage = 0;
  Duration animationDuration = const Duration(milliseconds: 250);

  //late initializations
  late AnimationController controller;
  late Animation<int> intAnimation;
  late Animation<double> containerHeight;
  late Animation<double> containerWidth;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: animationDuration)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {});
    intAnimation = IntTween(begin: 0, end: 1).animate(controller);
    containerHeight =
        Tween(begin: bigItemHeight, end: smallItemHeight).animate(controller);
    containerWidth =
        Tween(begin: smallItemWidth, end: smallItemWidth).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
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
    ),
    Container(
      width: double.maxFinite,
      height: double.maxFinite,
      color: Colors.red,
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
    List<CarouselData> currentItemList = updateList();
    return currentItemList.mapIndexed((index, item) {
      PagePos currentPos = item.currentPos;
      PagePos prevPos = item.previousPos;
      Widget currentItem = item.item;

      return CarouselItemWidget(
        currentPos: currentPos,
        previousPos: prevPos,
        bigItemWidth: bigItemWidth!,
        bigItemHeight: bigItemHeight!,
        smallItemWidth: smallItemWidth!,
        smallItemHeight: smallItemHeight!,
        child: currentItem,
      );
    }).toList();
  }

  List<CarouselData> updateList() {
    List<CarouselData> farBeforeActive;
    List<CarouselData> farAfterActive;
    CarouselData currentPage;
    farBeforeActive = carouselItems
        .sublist(0, activePage)
        .map((e) => CarouselData(e, PagePos.farBefore, PagePos.farBefore))
        .toList();
    farAfterActive = carouselItems
        .sublist(activePage + 1, carouselItems.length)
        .map((e) => CarouselData(e, PagePos.farBefore, PagePos.farBefore))
        .toList();
    if (farAfterActive.isNotEmpty) {
      farAfterActive.first.setCurrent(PagePos.before);
      farAfterActive.first.setPrev(PagePos.current);
    }
    if (farBeforeActive.isNotEmpty) {
      farBeforeActive.last.setCurrent(PagePos.after);
      farBeforeActive.last.setPrev(PagePos.current);
    }
    currentPage = CarouselData(carouselItems[activePage], PagePos.current,
        PagePos.before); // {PagePos.current: carouselItems[activePage]};

    return [
      ...farBeforeActive,
      ...farAfterActive.reversed,
      currentPage,
    ];
  }

  void _rightSwipe() {
    setState(() {
      if (activePage < carouselItems.length - 1) {
        activePage += 1;
        print('right');
      }
    });
  }

  void _leftSwipe() {
    setState(() {
      if (activePage > 0) {
        activePage -= 1;
        print('left');
      }
    });
  }
}
