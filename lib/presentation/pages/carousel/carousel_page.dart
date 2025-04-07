import 'package:cool_widget/presentation/components/carousel/cool_carousel_style.dart';
import 'package:cool_widget/presentation/components/carousel/cool_carousel_widget.dart';
import 'package:flutter/material.dart';

class CarouselPage extends StatelessWidget {
  const CarouselPage({super.key});

  @override
  Widget build(BuildContext context) {
    final slides = [
      Container(
          color: Colors.red,
          child: const Center(
              child: Text("Slide 1",
                  style: TextStyle(fontSize: 24, color: Colors.white)))),
      Container(
          color: Colors.green,
          child: const Center(
              child: Text("Slide 2",
                  style: TextStyle(fontSize: 24, color: Colors.white)))),
      Container(
          color: Colors.blue,
          child: const Center(
              child: Text("Slide 3",
                  style: TextStyle(fontSize: 24, color: Colors.white)))),
    ];

    const style = CoolCarouselStyle(
      height: 250,
      viewportFraction: 0.8,
      autoPlay: true,
      autoPlayInterval: Duration(seconds: 5),
      infiniteScroll: true,
      usePageTransformer: true,
      loop: true,
      showIndicator: true,
      indicatorAlignment: Alignment.bottomCenter,
      indicatorActiveColor: Colors.orange,
      indicatorInactiveColor: Colors.grey,
      indicatorSize: 10,
      indicatorSpacing: 6,
      indicatorShape: BoxShape.rectangle, // 사각형 인디케이터
      pageSnapping: true, // 스와이프 시 스무스하게 이동 가능 (no snap)
    );

    return Scaffold(
      appBar: AppBar(title: const Text("Carousel")),
      body: Center(
        child: CoolCarousel(
          slides: slides,
          style: style,
          onSlideTap: (index) {
            debugPrint("Tapped slide: $index");
          },
        ),
      ),
    );
  }
}
