/// cool_date_time_spinner_style.dart
import 'package:flutter/material.dart';

/// DateSpinner / TimeSpinner에서 활용할 공통 스타일
class CoolDateTimeSpinnerStyle {
  /// Picker(스피너) 영역 높이
  final double pickerHeight;

  /// 스피너 1행(item) 높이
  final double itemExtent;

  /// 각 스피너에 표시되는 텍스트 스타일 (년/월/일, 시/분)
  final TextStyle itemTextStyle;

  /// 상단 타이틀 텍스트 스타일
  final TextStyle titleTextStyle;

  /// 상단 영역 높이
  final double topBarHeight;

  /// 위젯 전체 패딩
  final EdgeInsetsGeometry contentPadding;

  /// 닫기(취소) 아이콘
  final Widget closeIcon;

  /// 위젯 전체 백그라운드 데코 (색상, radius 등)
  final BoxDecoration? backgroundDecoration;

  /// 완료 버튼 스타일 (ElevatedButton/TextButton 등 자유롭게)
  /// 여기서는 간단히 색/폰트만 명시, 더 세밀하게 하려면 별도 위젯으로 분리하거나 파라미터 늘려도 됨
  final ButtonStyle? confirmButtonStyle;
  final TextStyle confirmButtonTextStyle;

  /// 생성자
  const CoolDateTimeSpinnerStyle({
    this.pickerHeight = 200,
    this.itemExtent = 40,
    this.itemTextStyle = const TextStyle(fontSize: 14),
    this.titleTextStyle = const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    this.topBarHeight = 48,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    this.closeIcon = const Icon(Icons.close),
    this.backgroundDecoration,
    this.confirmButtonStyle,
    this.confirmButtonTextStyle = const TextStyle(fontSize: 14),
  });
}
