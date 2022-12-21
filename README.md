<!-- [![pub package version](https://img.shields.io/pub/v/date_format_field)](https://pub.dev/packages/date_format_field) -->
[![license](https://img.shields.io/github/license/AnthonyAniobi/Date_Format_Field)](https://github.com/AnthonyAniobi/Dynamic_Carousel)
[![issues](https://img.shields.io/github/issues/AnthonyAniobi/Date_Format_Field)](https://github.com/AnthonyAniobi/Dynamic_Carousel)

Dynamic Carousel is a flutter package that implements a manual swiping carousel. The carousel allows deletion and adding images with a custom slider which displays and hides based on input.


## Preview
<img src='screenshots/aim.png' width='400' height='300'>

## Features
<img src='screenshots/screen_preview.gif' width='300' height='500'>


## Getting started

Add the package to the `yaml` file.
```yaml
dynamic_carousel: latestversion
```

Import the package to your widget tree before using it
```dart
import 'package:dynamic_carousel/dynamic_carousel.dart';
```

## Usage

**NB** this package is still in production and so is the documentation

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

## Additional information

Contribute to the widget on [Github](https://github.com/AnthonyAniobi/Dynamic_Carousel).
