import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/material.dart';

/// CoolLine
///
/// - [orientation]: 가로(Axis.horizontal) / 세로(Axis.vertical)
/// - [thickness]: 선 굵기
/// - [length]: 선 길이 (null이면 남는 공간에 맞춰 확장)
/// - [color]: 일반 단색 (gradient가 null일 때 사용)
/// - [gradient]: 그라데이션 (있다면 color 대신 gradient가 적용됨)
/// - [dashed]: 점선 여부
/// - [dashWidth], [dashGap]: 점선의 선/간격 길이
/// - [boxShadow]: 선 자체(컨테이너)에 적용할 그림자
/// - [border]: 선 전체 컨테이너에 적용할 테두리
/// - [radius]: 모서리 둥글기
///
/// 내부 로직:
/// 1) Container로 border, shadow, radius 등을 설정
/// 2) child에 CustomPaint -> Painter가 (가로/세로) 선을 그림
/// 3) 점선(dashed) / 그라데이션(gradient) / 단색(color) 반영
///
class CoolLine extends StatelessWidget {
  final Axis orientation;
  final double thickness;
  final double? length;

  /// 단색
  final Color color;

  /// 그라데이션(gradient가 있으면 color 대신 사용)
  final Gradient? gradient;

  /// 점선 여부
  final bool dashed;

  /// 점선의 선 길이
  final double dashWidth;

  /// 점선의 간격 길이
  final double dashGap;

  /// 컨테이너에 적용할 그림자 리스트
  final List<BoxShadow>? boxShadow;

  /// 컨테이너 테두리
  final BoxBorder? border;

  /// 컨테이너 모서리 둥글기
  final BorderRadius? radius;

  const CoolLine({
    Key? key,
    this.orientation = Axis.horizontal,
    this.thickness = 1.0,
    this.length,
    this.color = Colors.black12,
    this.gradient,
    this.dashed = false,
    this.dashWidth = 5.0,
    this.dashGap = 3.0,
    this.boxShadow,
    this.border,
    this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 컨테이너의 너비/높이 결정 (orientation에 따라)
    final double containerWidth = (orientation == Axis.horizontal)
        ? (length ?? double.infinity)
        : thickness;
    final double containerHeight = (orientation == Axis.vertical)
        ? (length ?? double.infinity)
        : thickness;

    return Container(
      width: containerWidth,
      height: containerHeight,
      decoration: BoxDecoration(
        border: border,
        borderRadius: radius,
        boxShadow: boxShadow,
      ),
      child: CustomPaint(
        painter: _LinePainter(
          orientation: orientation,
          color: color,
          gradient: gradient,
          dashed: dashed,
          dashWidth: dashWidth,
          dashGap: dashGap,
          thickness: thickness,
        ),
      ),
    );
  }
}

/// _LinePainter
/// 실제로 선을 그리는 CustomPainter
class _LinePainter extends CustomPainter {
  final Axis orientation;
  final Color color;
  final Gradient? gradient;
  final bool dashed;
  final double dashWidth;
  final double dashGap;
  final double thickness;

  _LinePainter({
    required this.orientation,
    required this.color,
    required this.gradient,
    required this.dashed,
    required this.dashWidth,
    required this.dashGap,
    required this.thickness,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 페인트 설정
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = thickness;

    // gradient가 있다면 Shader 할당
    if (gradient != null) {
      Rect rect = Offset.zero & size; // (0, 0, width, height)
      paint.shader = gradient!.createShader(rect);
    } else {
      paint.color = color;
    }

    // 선을 그릴 경로 (가로/세로 위치 계산)
    final Path path = Path();
    if (orientation == Axis.horizontal) {
      final double centerY = size.height / 2;
      path.moveTo(0, centerY);
      path.lineTo(size.width, centerY);
    } else {
      final double centerX = size.width / 2;
      path.moveTo(centerX, 0);
      path.lineTo(centerX, size.height);
    }

    if (!dashed) {
      // 점선이 아니라면 그냥 path 전체를 그림
      canvas.drawPath(path, paint);
    } else {
      // ─────────────────────────────
      // 점선(Dashed) 로직
      // ─────────────────────────────
      // path 길이를 구해서 dashWidth, dashGap 반복
      final PathMetrics pathMetrics = path.computeMetrics();
      for (final PathMetric metric in pathMetrics) {
        double distance = 0.0;
        while (distance < metric.length) {
          final double next = math.min(distance + dashWidth, metric.length);
          canvas.drawPath(
            metric.extractPath(distance, next),
            paint,
          );
          distance += dashWidth + dashGap;
        }
      }
    }
  }

  @override
  bool shouldRepaint(_LinePainter oldDelegate) {
    return orientation != oldDelegate.orientation ||
        color != oldDelegate.color ||
        gradient != oldDelegate.gradient ||
        dashed != oldDelegate.dashed ||
        dashWidth != oldDelegate.dashWidth ||
        dashGap != oldDelegate.dashGap ||
        thickness != oldDelegate.thickness;
  }
}
