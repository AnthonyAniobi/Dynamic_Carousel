import 'package:flutter/material.dart';
import 'package:dynamic_carousel/dynamic_carousel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dynamic Carousel Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Dynamic Carousel Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 20),
          const Text(
            'Dynamic Carousel',
          ),
          const SizedBox(height: 20),
          DynamicCarousel(
            animationDuration: Duration(milliseconds: 250),
            onDelete: (index) {
              carouselItems.removeAt(index);
            },
            children: carouselItems,
          ),
          ElevatedButton(
            onPressed: () {
              carouselItems.add(Image.asset(
                'assets/image.png',
                height: double.maxFinite,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ));
              setState(() {});
            },
            child: const Text('add Item'),
          ),
        ],
      ),
    );
  }
}
