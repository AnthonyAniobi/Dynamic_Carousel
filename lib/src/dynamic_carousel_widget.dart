import 'package:dynamic_carousel/src/carousel_item.dart';
import 'package:dynamic_carousel/src/carousel_slider.dart';
import 'package:dynamic_carousel/src/enums.dart';
import 'package:dynamic_carousel/src/models.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class DynamicCarousel extends StatefulWidget {
  DynamicCarousel({
    super.key,
    this.width = double.maxFinite,
    this.height = 200,
    this.bigItemHeight = 200,
    this.bigItemWidth = 200,
    this.smallItemWidth = 100,
    this.smallItemHeight = 100,
    this.trackBarProperties,
    this.animationDuration,
    required this.onDelete,
    required this.children,
  });

  final double width;
  final double height;
  final double bigItemHeight;
  final double bigItemWidth;
  final double smallItemWidth;
  final double smallItemHeight;
  final TrackBarProperties? trackBarProperties;
  final Duration? animationDuration;
  final Function(int) onDelete;
  List<Widget> children;

  @override
  State<DynamicCarousel> createState() => _DynamicCarouselState();
}

class _DynamicCarouselState extends State<DynamicCarousel>
    with SingleTickerProviderStateMixin {
  int activePage = 1;
  int previousPage = 0;
  Duration animationDuration = const Duration(milliseconds: 700);
  late AnimationController controller;
  TrackBarProperties trackProperties = TrackBarProperties(
      trackbarColor: Colors.orange, sliderColor: Colors.grey, topSpacing: 20);

  @override
  void initState() {
    super.initState();

    // check if trackbar properties is null
    if (widget.trackBarProperties != null) {
      trackProperties = widget.trackBarProperties!;
    }
    if (widget.animationDuration != null) {
      animationDuration = widget.animationDuration!;
    }

    // intitialize the animation
    controller = AnimationController(vsync: this, duration: animationDuration);
    controller.addListener(() {
      setState(() {});
    });
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reset();
      }
    });
  }

  @override
  void didUpdateWidget(covariant DynamicCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);
    activePage = widget.children.length - 1;
    previousPage = activePage - 1;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onHorizontalDragEnd: ((details) {
            if (details.velocity.pixelsPerSecond.dx > 0) {
              _leftSwipe();
            } else {
              _rightSwipe();
            }
          }),
          child: SizedBox(
            width: double.maxFinite,
            height: widget.height,
            child: Stack(
              children: widget.children.isNotEmpty ? stackItems() : [],
            ),
          ),
        ),
        if (widget.children.length > 1)
          Padding(
            padding: EdgeInsets.only(top: trackProperties.topSpacing),
            child: CarouselSlider(
              position: activePage,
              amount: widget.children.length,
              properties: trackProperties,
            ),
          )
      ],
    );
  }

  List<Widget> stackItems() {
    List<CarouselData> beforeActive = widget.children
        .sublist(0, activePage)
        .map((e) => CarouselData(e, PagePos.farBefore))
        .toList();
    List<CarouselData> afterActive = widget.children
        .sublist(activePage + 1, widget.children.length)
        .reversed
        .map((e) => CarouselData(e, PagePos.farAfter))
        .toList();
    CarouselData currentPage =
        CarouselData(widget.children[activePage], PagePos.current);

    if (afterActive.isNotEmpty) {
      afterActive.last.setCurrent(PagePos.after);
    }

    if (beforeActive.isNotEmpty) {
      beforeActive.last.setCurrent(PagePos.before);
    }

    List<CarouselData> currentItemList = [
      ...beforeActive,
      ...afterActive,
      currentPage,
    ];
    return currentItemList.mapIndexed((index, item) {
      return CarouselItem(
          bigItemWidth: widget.bigItemWidth,
          bigItemHeight: widget.bigItemHeight,
          smallItemWidth: widget.smallItemWidth,
          smallItemHeight: widget.smallItemHeight,
          animation: 1 - controller.value,
          forward: activePage > previousPage,
          startAnimating: controller.isAnimating,
          onDelete: () {
            setState(() {
              widget.onDelete(activePage);
              if (activePage >= widget.children.length - 1) {
                activePage = widget.children.length - 1;
              }
            });
          },
          data: item);
    }).toList();
  }

  void _rightSwipe() {
    setState(() {
      if (activePage < widget.children.length - 1) {
        previousPage = activePage;
        activePage += 1;
        controller.forward();
      }
    });
  }

  void _leftSwipe() {
    setState(() {
      if (activePage > 0) {
        previousPage = activePage;
        activePage -= 1;
        controller.forward();
      }
    });
  }
}
