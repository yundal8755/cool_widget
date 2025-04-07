import 'dart:math' as math;
import 'package:flutter/material.dart';

class CoolLoadingIndicator extends StatefulWidget {
  final double radius;
  final Color? color;
  final bool isMaterial;

  /// 애니메이션 재생 여부
  final bool animating;

  const CoolLoadingIndicator({
    super.key,
    this.radius = 16.0,
    this.color,
    this.isMaterial = false,
    this.animating = true,
  });

  @override
  State<CoolLoadingIndicator> createState() => _CoolLoadingIndicatorState();
}

class _CoolLoadingIndicatorState extends State<CoolLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    /// 1초를 주기로 애니메이션 진행
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    /// animating이 true면 무한 반복, false면 초기 상태(정지)
    if (widget.animating) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(CoolLoadingIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);

    /// animating 값이 바뀔 때마다 컨트롤러 동작 제어
    if (widget.animating != oldWidget.animating) {
      if (widget.animating) {
        _controller.repeat();
      } else {
        _controller.stop();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Cupertino 스타일과 Material 스타일을 분기
  @override
  Widget build(BuildContext context) {
    if (widget.isMaterial) {
      // Material 디자인(CircularProgressIndicator)
      return Center(
        child: SizedBox(
          width: widget.radius * 2,
          height: widget.radius * 2,
          child: CircularProgressIndicator(
            strokeWidth: 2.0,
            valueColor: AlwaysStoppedAnimation<Color>(
              widget.color ?? Theme.of(context).primaryColor,
            ),
          ),
        ),
      );
    } else {
      // Cupertino 스타일 (CustomPaint)
      return Center(
        child: SizedBox(
          width: widget.radius * 2,
          height: widget.radius * 2,
          child: RepaintBoundary(
            /// 이 위젯에 대한 RepaintBoundary를 적용 (오버플로우 제한 및 성능 최적화)
            child: CustomPaint(
              painter: _CupertinoActivityIndicatorPainter(
                position: _controller,
                activeColor: widget.color ?? const Color(0xFF3C3C44),
                radius: widget.radius,
              ),
            ),
          ),
        ),
      );
    }
  }
}

/// _CupertinoActivityIndicatorPainter
///
/// Cupertino 스타일의 로딩 인디케이터를 CustomPainter로 구현.
/// [position]: AnimationController (0.0 ~ 1.0)
/// [activeColor]: 로딩 인디케이터의 기본 색상
/// [radius]: 로딩 바 크기
class _CupertinoActivityIndicatorPainter extends CustomPainter {
  static const int _tickCount = 12; // 바(틱)의 개수
  static const List<int> _alphaValues = [
    147,
    131,
    114,
    97,
    81,
    64,
    47,
    47,
    47,
    47,
    47,
    47
  ]; // 불투명도 단계

  final Animation<double> position;
  final Color activeColor;
  final double radius;

  // 각 틱의 모양을 정의하기 위한 기본 RRect
  late final RRect tickFundamentalRRect;

  _CupertinoActivityIndicatorPainter({
    required this.position,
    required this.activeColor,
    required this.radius,
  }) : super(repaint: position) {
    /// 한 개의 틱(tick)을 그리기 위한 영역
    /// (가로: 반지름/2, 세로: 반지름 크기의 직사각형 + 라운드 처리)
    tickFundamentalRRect = RRect.fromLTRBXY(
      -radius,
      radius / 10,
      -radius / 2.0,
      -radius / 10,
      radius / 10,
      radius / 10,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    // 가운데 기준점으로 평행이동
    canvas.translate(size.width / 2, size.height / 2);

    final Paint paint = Paint();
    const double rotationStep = (2 * math.pi) / _tickCount; // 한 틱 당 회전 각도
    final int activeTick = (position.value * _tickCount).floor();

    for (int i = 0; i < _tickCount; i++) {
      /// alphaValues를 기반으로 색상 투명도 조절
      final int t = (i + activeTick) % _tickCount;
      paint.color = activeColor.withAlpha(_alphaValues[t]);

      // 틱(RRect) 그리기
      canvas.drawRRect(tickFundamentalRRect, paint);

      // 각 틱마다 -rotationStep만큼 회전
      canvas.rotate(-rotationStep);
    }
  }

  @override
  bool shouldRepaint(_CupertinoActivityIndicatorPainter oldDelegate) {
    return oldDelegate.position != position ||
        oldDelegate.activeColor != activeColor ||
        oldDelegate.radius != radius;
  }
}
