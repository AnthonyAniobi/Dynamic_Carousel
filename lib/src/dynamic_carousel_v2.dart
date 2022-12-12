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
  bool updateStack = false;
  List<CarouselData>? cache;

  List<CarouselData> get stackData => cache!;
  set stackData(List<CarouselData> data) {
    cache = data;
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
  void initState() {
    super.initState();
    updateListOnly();
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
    // List<CarouselData> currentItemList = updateListOnly();

    return cache!.mapIndexed((index, item) {
      PagePos currentPos = item.currentPos;
      Widget currentItem = item.item;

      return CarouselItemWidget(
        currentPos: currentPos,
        bigItemWidth: bigItemWidth!,
        bigItemHeight: bigItemHeight!,
        smallItemWidth: smallItemWidth!,
        smallItemHeight: smallItemHeight!,
        onEnd: () {},
        child: currentItem,
      );
    }).toList();
  }

  void updateListOnly() {
    final result = carouselItems.mapIndexed((index, item) {
      PagePos pos;
      if (index < activePage - 1) {
        pos = PagePos.farBefore;
      } else if (index == activePage - 1) {
        pos = PagePos.before;
      } else if (index == activePage) {
        pos = PagePos.current;
      } else if (index == activePage + 1) {
        pos = PagePos.after;
      } else {
        pos = PagePos.farAfter;
      }
      return CarouselData(item, pos, pos);
    }).toList();
    cache = result; // cache data;
    // return result;
  }

  void _rightSwipe() {
    setState(() {
      if (activePage < carouselItems.length - 1) {
        activePage += 1;
        updateListOnly();
      }
    });
  }

  void _leftSwipe() async {
    setState(() {
      if (activePage > 0) {
        activePage -= 1;
        updateListOnly();
      }
    });
  }
}
