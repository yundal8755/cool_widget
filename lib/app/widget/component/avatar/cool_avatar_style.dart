import 'package:flutter/material.dart';

enum AvatarShape { circle, rectangle }

///
/// [Avatar] 스타일을 결정하는 추상 클래스
///
abstract class CoolAvatarStyle {
  final AvatarShape? shape;
  final Color? backgroundColor;
  final List<BoxShadow>? shadow;
  final double? radius;
  final double? width;
  final double? height;
  final double? cornerRadius;

  const CoolAvatarStyle._({
    required this.shape,
    this.backgroundColor,
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
class CircleAvatarStyle extends CoolAvatarStyle {
  CircleAvatarStyle({
    AvatarShape super.shape = AvatarShape.circle,
    super.radius,
    super.backgroundColor,
    super.shadow,
  }) : super._();

  /// 기본값
  static CircleAvatarStyle circleDefault = CircleAvatarStyle(
      shape: AvatarShape.circle,
      radius: 80.0,
      backgroundColor: Colors.grey,
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
class RectangleAvatarStyle extends CoolAvatarStyle {
  const RectangleAvatarStyle({
    AvatarShape super.shape = AvatarShape.rectangle,
    super.width,
    super.height,
    super.cornerRadius = 12.0,
    super.backgroundColor,
    super.shadow,
  }) : super._();

  /// 기본값
  static RectangleAvatarStyle rectangleDefault = const RectangleAvatarStyle(
    shape: AvatarShape.rectangle,
    width: 100.0,
    height: 100.0,
    backgroundColor: Colors.lightBlueAccent,
    cornerRadius: 12.0,
    shadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 4,
        offset: Offset(0, 2),
      )
    ],
  );
}
