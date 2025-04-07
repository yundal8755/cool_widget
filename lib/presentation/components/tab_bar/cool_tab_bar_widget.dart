import 'package:flutter/material.dart';

class CustomAnimatedTabBar extends StatefulWidget {
  final TabController controller;
  final List<String> tabs;
  final Color indicatorColor;
  final Color selectedTextColor;
  final Color unselectedTextColor;
  final double indicatorHeight;
  final double indicatorCurveHeight;
  final Duration duration;

  const CustomAnimatedTabBar({
    super.key,
    required this.controller,
    required this.tabs,
    this.indicatorColor = Colors.blue,
    this.selectedTextColor = Colors.blue,
    this.unselectedTextColor = Colors.grey,
    this.indicatorHeight = 4.0,
    this.indicatorCurveHeight = 8.0, // 인디케이터 곡선 높이(커스텀 예시)
    this.duration = const Duration(milliseconds: 300),
  });

  @override
  State<CustomAnimatedTabBar> createState() => _CustomAnimatedTabBarState();
}

class _CustomAnimatedTabBarState extends State<CustomAnimatedTabBar> {
  // 여분의 AnimationController를 굳이 만들 필요 없이,
  // TabController의 animation을 통해도 인디케이터 위치/상태를 추적할 수 있음.
  // 필요하다면 별도의 AnimationController를 사용해도 됨.

  @override
  void initState() {
    super.initState();
    // Tab 변경 시 setState로 재랜더링하여 텍스트 색 변경 반영
    widget.controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    widget.controller.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 전체 탭 화면의 너비
    final tabCount = widget.tabs.length;

    return LayoutBuilder(
      builder: (context, constraints) {
        final tabWidth = constraints.maxWidth / tabCount;

        return Stack(
          children: [
            // 1) 탭 항목 (텍스트 등)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(tabCount, (index) {
                final bool isSelected = (index == widget.controller.index);
                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      widget.controller.animateTo(index,
                          duration: widget.duration, curve: Curves.easeInOut);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      alignment: Alignment.center,
                      child: AnimatedDefaultTextStyle(
                        duration: widget.duration,
                        style: TextStyle(
                          fontSize: isSelected ? 16 : 14,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected
                              ? widget.selectedTextColor
                              : widget.unselectedTextColor,
                        ),
                        child: Text(widget.tabs[index]),
                      ),
                    ),
                  ),
                );
              }),
            ),
            // 2) 애니메이션 인디케이터
            // TabController.animation.value를 사용하면
            // 현재 페이지(인덱스) 사이 위치를 0~(탭수-1) 범위로 실시간 얻을 수 있음.
            AnimatedBuilder(
              animation: widget.controller.animation ?? widget.controller,
              builder: (context, child) {
                // animation.value는 예: 0.0 (0번 탭), 0.5 (0번과 1번 사이), 1.0 (1번 탭) ...
                final animationValue = widget.controller.animation!.value;
                // 인디케이터의 시작 위치(왼쪽)
                final indicatorLeft = animationValue * tabWidth;

                return Positioned(
                  bottom: 0,
                  left: indicatorLeft,
                  width: tabWidth,
                  child: CustomPaint(
                    painter: _IndicatorPainter(
                      color: widget.indicatorColor,
                      height: widget.indicatorHeight,
                      curveHeight: widget.indicatorCurveHeight,
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

/// 커스텀 인디케이터를 그려주는 페인터
class _IndicatorPainter extends CustomPainter {
  final Color color;
  final double height;
  final double curveHeight;

  _IndicatorPainter({
    required this.color,
    required this.height,
    required this.curveHeight,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 인디케이터의 너비: size.width
    // 인디케이터의 높이: height (단순한 직선이 아니라 곡선 모양으로 표현하는 예시)
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // 간단히 직선+곡선을 섞어 그려볼 예시
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, -curveHeight);
    path.quadraticBezierTo(
        size.width / 1, -curveHeight * 1, size.width, -curveHeight);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, height);
    path.lineTo(0, height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_IndicatorPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.height != height ||
        oldDelegate.curveHeight != curveHeight;
  }
}
