import 'package:flutter/material.dart';

enum BadgeShape { circle, rectangle }

///
/// [Badge] 스타일을 결정하는 추상 클래스
///
abstract class CoolBadgeStyle {
  final BadgeShape? shape;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final EdgeInsets? contentPadding;
  final List<BoxShadow>? shadow;

  final double? radius;

  final double? width;
  final double? height;
  final double? cornerRadius;

  const CoolBadgeStyle._({
    required this.shape,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.contentPadding,
    this.shadow,
    this.radius,
    this.width,
    this.height,
    this.cornerRadius,
  });
}

///
/// [Circle] 전용 스타일
///
class CircleBadgeStyle extends CoolBadgeStyle {
  CircleBadgeStyle({
    BadgeShape super.shape = BadgeShape.circle,
    super.backgroundColor,
    super.borderColor,
    super.borderWidth,
    super.contentPadding,
    super.shadow,
    super.radius,
  }) : super._();

  /// 기본값
  static CircleBadgeStyle circleDefault = CircleBadgeStyle(
      shape: BadgeShape.circle,
      backgroundColor: Colors.grey,
      borderColor: Colors.blue,
      borderWidth: 0.5,
      contentPadding: const EdgeInsets.all(1),
      radius: 80.0,
      shadow: [
        const BoxShadow(
          color: Colors.black12,
          blurRadius: 4,
          offset: Offset(0, 2),
        )
      ]);
}

///
/// [Rectangle] 전용 스타일
///
class RectangleBadgeStyle extends CoolBadgeStyle {
  RectangleBadgeStyle({
    BadgeShape super.shape = BadgeShape.rectangle,
    super.backgroundColor,
    super.borderColor,
    super.borderWidth,
    super.contentPadding,
    super.shadow,
    super.width,
    super.height,
    super.cornerRadius,
  }) : super._();

  /// 기본값
  static RectangleBadgeStyle ractangleDefault = RectangleBadgeStyle(
      shape: BadgeShape.rectangle,
      backgroundColor: Colors.grey,
      borderColor: Colors.blue,
      borderWidth: 0.5,
      contentPadding: const EdgeInsets.all(1),
      width: 72,
      height: 24,
      cornerRadius: 12,
      shadow: [
        const BoxShadow(
          color: Colors.black12,
          blurRadius: 4,
          offset: Offset(0, 2),
        )
      ]);
}
