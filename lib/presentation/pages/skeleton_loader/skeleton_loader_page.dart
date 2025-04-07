import 'dart:async';
import 'package:flutter/material.dart';

// Skeleton Loader 위젯 정의 (shimmer 효과)
class SkeletonLoaderPage extends StatefulWidget {
  final double width;
  final double height;
  final BorderRadius? borderRadius;

  // 기본 너비, 높이, 모서리 둥글기를 받아서 표시합니다.
  const SkeletonLoaderPage({
    super.key,
    this.width = double.infinity,
    this.height = 16.0,
    this.borderRadius,
  });

  @override
  SkeletonLoaderPageState createState() => SkeletonLoaderPageState();
}

class SkeletonLoaderPageState extends State<SkeletonLoaderPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // 1초 간격의 애니메이션을 반복하여 shimmer 효과를 줍니다.
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(4),
            gradient: LinearGradient(
              colors: [
                Colors.grey.shade300,
                Colors.grey.shade100,
                Colors.grey.shade300,
              ],
              stops: const [0.1, 0.3, 0.4],
              // begin 값을 변경하여 왼쪽에서 오른쪽으로 흐르도록 함
              begin: Alignment(-1 + _controller.value * 2, 0),
              end: Alignment(1 + _controller.value * 2, 0),
            ),
          ),
        );
      },
    );
  }
}

// DelayedContentCard 위젯: 일정 시간 후 실제 콘텐츠를 보여줍니다.
class DelayedContentCard extends StatefulWidget {
  final double delaySeconds; // 로딩 대기 시간 (초)
  final double skeletonHeight; // Skeleton Loader 높이
  final BorderRadius borderRadius; // 모서리 둥글기
  final Widget content; // 실제 보여줄 콘텐츠

  const DelayedContentCard({
    super.key,
    required this.delaySeconds,
    required this.skeletonHeight,
    required this.borderRadius,
    required this.content,
  });

  @override
  _DelayedContentCardState createState() => _DelayedContentCardState();
}

class _DelayedContentCardState extends State<DelayedContentCard> {
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    // 지정한 시간(delaySeconds) 후에 콘텐츠를 보여주도록 설정
    Future.delayed(Duration(seconds: widget.delaySeconds.toInt()), () {
      setState(() {
        isLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoaded
        ? widget.content
        : SkeletonLoaderPage(
            height: widget.skeletonHeight,
            borderRadius: widget.borderRadius,
          );
  }
}

// 상단, 중앙, 하단에 각각 다른 시간으로 로딩 후 콘텐츠를 보여주는 화면
class SkeletonCardScreen extends StatelessWidget {
  const SkeletonCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delayed Content Card Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        // Column을 이용해 세로로 3개의 Card를 배치합니다.
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 상단 Card: 1초 후 텍스트 콘텐츠 로드 (Skeleton Loader 높이: 80px)
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: DelayedContentCard(
                  delaySeconds: 1,
                  skeletonHeight: 80.0,
                  borderRadius: BorderRadius.circular(8),
                  content: const Text(
                    '상단 콘텐츠: 1초 후 로드됨',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // 중앙 Card: 2초 후 Row 형태 콘텐츠 로드 (Skeleton Loader 높이: 150px)
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: DelayedContentCard(
                  delaySeconds: 5.5,
                  skeletonHeight: 150.0,
                  borderRadius: BorderRadius.circular(8),
                  content: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.access_alarm, size: 30),
                      SizedBox(width: 8),
                      Text(
                        '중앙 콘텐츠: 2초 후 로드됨',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // 하단 Card: 3초 후 텍스트 콘텐츠 로드 (Skeleton Loader 높이: 60px)
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: DelayedContentCard(
                  delaySeconds: 2.5,
                  skeletonHeight: 60.0,
                  borderRadius: BorderRadius.circular(8),
                  content: const Text(
                    '하단 콘텐츠: 3초 후 로드됨',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
