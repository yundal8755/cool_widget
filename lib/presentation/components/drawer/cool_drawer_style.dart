import 'package:flutter/material.dart';

class CoolDrawerStyle {
  /// Drawer의 너비
  final double width;

  /// Drawer의 배경색
  final Color backgroundColor;

  /// 테두리 둥글림 정도 (0이면 둥글지 않음)
  final double borderRadius;

  /// BoxShadow 리스트. 일반적으로 그림자나 음영을 넣을 때 사용.
  final List<BoxShadow> boxShadows;

  /// 기타 DecorationImage 등 다른 효과를 넣으려면 decoration 자체를 커스텀 가능하도록.
  /// (단, decoration을 직접 쓰면 backgroundColor나 borderRadius 등 중복 설정에 유의)
  final Decoration? decoration;

  const CoolDrawerStyle({
    this.width = 250,
    this.backgroundColor = Colors.white,
    this.borderRadius = 0.0,
    this.boxShadows = const [],
    this.decoration,
  });

  /// style 복제를 위한 copyWith(필요에 따라)
  CoolDrawerStyle copyWith({
    double? width,
    Color? backgroundColor,
    double? borderRadius,
    List<BoxShadow>? boxShadows,
    Decoration? decoration,
  }) {
    return CoolDrawerStyle(
      width: width ?? this.width,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderRadius: borderRadius ?? this.borderRadius,
      boxShadows: boxShadows ?? this.boxShadows,
      decoration: decoration ?? this.decoration,
    );
  }
}
