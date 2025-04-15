import 'package:flutter/material.dart';

class CoolAccordionStyle {
  /// 아코디언 전체 컨테이너의 배경색
  final Color backgroundColor;

  /// 경계선 둥글림 정도
  final double borderRadius;

  /// 펼침/접힘 애니메이션 지속 시간
  final Duration animationDuration;

  /// 그림자(Shadow) 리스트
  final List<BoxShadow> boxShadows;

  /// 따로 BoxDecoration을 완전히 지정하고 싶다면
  /// decoration을 추가할 수도 있음
  final Decoration? decoration;

  const CoolAccordionStyle({
    this.backgroundColor = Colors.white,
    this.borderRadius = 0.0,
    this.animationDuration = const Duration(milliseconds: 200),
    this.boxShadows = const [],
    this.decoration,
  });

  /// 텍스트 + 아이콘만 간단히 보여주는 아코디언 스타일을 위한 팩토리 생성자
  factory CoolAccordionStyle.onlyTextAndIcon({
    Color backgroundColor = Colors.transparent,
    Duration animationDuration = const Duration(milliseconds: 200),
  }) {
    return CoolAccordionStyle(
      backgroundColor: backgroundColor,
      borderRadius: 0.0, // 모서리 둥글림 없음
      animationDuration: animationDuration,
      boxShadows: const [], // 그림자 없음
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.blue))
      )
    );
  }

  CoolAccordionStyle copyWith({
    Color? backgroundColor,
    double? borderRadius,
    Duration? animationDuration,
    List<BoxShadow>? boxShadows,
    Decoration? decoration,
  }) {
    return CoolAccordionStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderRadius: borderRadius ?? this.borderRadius,
      animationDuration: animationDuration ?? this.animationDuration,
      boxShadows: boxShadows ?? this.boxShadows,
      decoration: decoration ?? this.decoration,
    );
  }
}
