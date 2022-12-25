import 'package:dynamic_carousel/src/carousel_item.dart';
import 'package:dynamic_carousel/src/carousel_slider.dart';
import 'package:dynamic_carousel/src/enums.dart';
import 'package:dynamic_carousel/src/models.dart';
import 'package:flutter/material.dart';

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
    this.onDeleteWidget,
    required this.onDelete,
    required this.children,
  });

  /// [width] of the entire carousel. If no value is provided, the carousel
  /// assumes the maximum width of the parent widget
  final double width;

  /// [height] of the entire carousel (including height of slider). The
  /// default height of the carousel is 200 pixels
  final double height;

  /// [bigItemHeight] defines the height of the item of the carousel in focus.
  /// The default value is 200 pixels
  final double bigItemHeight;

  /// [bigItemWidth] defines the widht of the item of the carousel in focus.
  /// The default value is 200 pixels
  final double bigItemWidth;

  /// [smallItemWidth] defines the width of the shrinked carousel item.
  /// The default value is 100 pixels
  final double smallItemWidth;

  /// [smallItemHeight] defines the height of the shrinked carousel item.
  /// The default value is 100 pixels
  final double smallItemHeight;

  /// [TrackBarProperties] defines the properties of the slider. The slider is
  /// only visible when the carousel contains two or more items. The
  /// [TrackBarProperties] specifies the [width], [height] and [color] of the
  /// slider and background trackbar.
  final TrackBarProperties? trackBarProperties;

  /// [animationDuration] specifies the [Duration] of the carousel slider
  final Duration? animationDuration;

  /// [onDelete] is a callback triggered when the delete icon is clicked on
  /// an item on the carousel.
  ///
  /// [onDelete] recieves an integer ([int]) which is the index of the deleted
  /// carousel item.
  final Function(int) onDelete;

  /// [onDeleteWidget] defines a new widget to replace the default delete icon
  ///  on the carousel item.
  ///
  /// **Note:** overriding this method means the overriding the [onDelete]
  /// callback.
  final Widget? onDeleteWidget;

  /// [children] is a list of widgets which are displayed in the carousel
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

    // set the active page
    activePage = widget.children.length - 1;
    previousPage = activePage - 1;

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
    return currentItemList.map((item) {
      return CarouselItem(
          bigItemWidth: widget.bigItemWidth,
          bigItemHeight: widget.bigItemHeight,
          smallItemWidth: widget.smallItemWidth,
          smallItemHeight: widget.smallItemHeight,
          animation: 1 - controller.value,
          forward: activePage > previousPage,
          startAnimating: controller.isAnimating,
          onDeleteWidget: widget.onDeleteWidget,
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
