[![pub package version](https://img.shields.io/pub/v/dynamic_carousel)](https://pub.dev/packages/dynamic_carousel)
[![license](https://img.shields.io/github/license/AnthonyAniobi/Date_Format_Field)](https://github.com/AnthonyAniobi/Dynamic_Carousel)
[![issues](https://img.shields.io/github/issues/AnthonyAniobi/Date_Format_Field)](https://github.com/AnthonyAniobi/Dynamic_Carousel)

Dynamic carousel widget is a carousel with zoom animation with ability to add and remove elements dynamicaly

## Preview

<img src='https://raw.githubusercontent.com/AnthonyAniobi/Dynamic_Carousel/main/screenshots/dynamic_carousel_preview.gif' width='400' height='300'>

## Features

The Features of this dynamic carousel are:

### Zoom animation

- zoom animation for expanding carousel item on focus
- zoom animation from widgets next to focus to former widgets

### Scrollbar Carousel

- Automatic adjustable scrollbar for carousel
- Customizable scrollbar
- Scrollbar widget shows when carousel item is above two

### Delete Items

- delete items from the carousel and have them change in realtime

## Getting started

Add the package to the `yaml` file.

```yaml
dynamic_carousel: latestversion
```

Import the package to your widget tree before using it

```dart
import 'package:dynamic_carousel/dynamic_carousel.dart';
```

```dart
List<Widget> carouselItems = [
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
];


DynamicCarousel(
    animationDuration: Duration(milliseconds: 250),
    onDelete: (index) {
        carouselItems.removeAt(index);
    },
    children: carouselItems,
),
```

The code above loads the carousel with default properties

## Usage

```dart
// set properties of the slider for the carousel
final properties = TrackBarProperties(
    trackbarColor: Colors.grey, // set the background color of the slider
    sliderColor: Colors.orange, // set the color of the thumb of the slider
    sliderHeight: 10, // set the height of the slider
    trackbarLength: 150, // set the horizontal length of the slider
    topSpacing: 40, // set the spacing between the slider and the carousel
  );

// list of widgets for carousel
List<Widget> carouselItems = [
    Container(
      width: double.maxFinite,
      height: double.maxFinite,
      color: Colors.green,
    ),
    Container(
      width: double.maxFinite,
      height: double.maxFinite,
      color: Colors.red,
    ),
    Container(
      width: double.maxFinite,
      height: double.maxFinite,
      color: Colors.blue,
    ),
    Container(
      width: double.maxFinite,
      height: double.maxFinite,
      color: Colors.yellow,
    ),
];

Widget build(BuildContext context){
    return DynamicCarousel(
        height: 400,
        bigItemHeight: 400,
        bigItemWidth: 400,
        smallItemWidth: 200,
        smallItemHeight: 200,
        trackBarProperties: properties,
        animationDuration: Duration(milliseconds: 100),
        onDeleteWidget: IconButton(onPressed: (){}, icon: Icon(Icons.remove)), // customized delete icon
        onDelete: (int index){},
        children: carouselItems,
  });
}

```

## Support the package

Have a feature you would like to see? why not lend the developers a hand 🤝

<a href="https://www.buymeacoffee.com/aniobi"><img src="screenshots/bmc_logo.png" height="70px"></a>

Contribute to the widget on [Github](https://github.com/AnthonyAniobi/Dynamic_Carousel).
