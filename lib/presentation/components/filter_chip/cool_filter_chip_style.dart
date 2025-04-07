import 'package:cool_widget/app/style/app_color.dart';
import 'package:cool_widget/app/style/app_text_style.dart';
import 'package:flutter/material.dart';

class CoolFilterChipStyle {
  final Color selectedColor;
  final Color unselectedColor;
  final Color checkmarkColor;
  final TextStyle labelStyle;
  final Color selectedTextColor;   // 선택되었을 때 텍스트 색상
  final Color unselectedTextColor; // 선택되지 않았을 때 텍스트 색상
  final EdgeInsetsGeometry padding;
  final OutlinedBorder shape;
  final double elevation;
  final Color selectedBorderColor;   // 선택되었을 때 테두리 색상
  final Color unselectedBorderColor; // 선택되지 않았을 때 테두리 색상

  const CoolFilterChipStyle({
    required this.selectedColor,
    required this.unselectedColor,
    required this.checkmarkColor,
    required this.labelStyle,
    required this.selectedTextColor,
    required this.unselectedTextColor,
    required this.padding,
    required this.shape,
    required this.elevation,
    required this.selectedBorderColor,
    required this.unselectedBorderColor,
  });

  CoolFilterChipStyle copyWith({
    Color? selectedColor,
    Color? unselectedColor,
    Color? checkmarkColor,
    TextStyle? labelStyle,
    Color? selectedTextColor,
    Color? unselectedTextColor,
    EdgeInsetsGeometry? padding,
    OutlinedBorder? shape,
    double? elevation,
    Color? selectedBorderColor,
    Color? unselectedBorderColor,
  }) {
    return CoolFilterChipStyle(
      selectedColor: selectedColor ?? this.selectedColor,
      unselectedColor: unselectedColor ?? this.unselectedColor,
      checkmarkColor: checkmarkColor ?? this.checkmarkColor,
      labelStyle: labelStyle ?? this.labelStyle,
      selectedTextColor: selectedTextColor ?? this.selectedTextColor,
      unselectedTextColor: unselectedTextColor ?? this.unselectedTextColor,
      padding: padding ?? this.padding,
      shape: shape ?? this.shape,
      elevation: elevation ?? this.elevation,
      selectedBorderColor: selectedBorderColor ?? this.selectedBorderColor,
      unselectedBorderColor: unselectedBorderColor ?? this.unselectedBorderColor,
    );
  }

  /// 기본 스타일 (Main)
  static CoolFilterChipStyle main() {
    return CoolFilterChipStyle(
      selectedColor: AppColor.green,          // 선택되었을 때 배경색
      unselectedColor: AppColor.gray030,        // 선택되지 않았을 때 배경색
      checkmarkColor: AppColor.white,
      labelStyle: AppTextStyle.body1,
      selectedTextColor: AppColor.white,        // 선택된 상태의 텍스트 색상
      unselectedTextColor: AppColor.black,      // 선택되지 않은 상태의 텍스트 색상
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 0,
      selectedBorderColor: AppColor.white,      // 선택된 상태의 테두리 색상
      unselectedBorderColor: AppColor.gray070,    // 선택되지 않은 상태의 테두리 색상
    );
  }

  /// Secondary 스타일 예시
  static CoolFilterChipStyle secondary() {
    return CoolFilterChipStyle(
      selectedColor: Colors.blue.shade300,
      unselectedColor: Colors.grey.shade300,
      checkmarkColor: Colors.white,
      labelStyle: AppTextStyle.h3,
      selectedTextColor: Colors.white,
      unselectedTextColor: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 1,
      selectedBorderColor: Colors.white,
      unselectedBorderColor: Colors.blue.shade700,
    );
  }

  /// Danger 스타일 예시
  static CoolFilterChipStyle danger() {
    return CoolFilterChipStyle(
      selectedColor: Colors.red,
      unselectedColor: Colors.grey.shade200,
      checkmarkColor: Colors.white,
      labelStyle: AppTextStyle.h3,
      selectedTextColor: Colors.white,
      unselectedTextColor: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 0,
      selectedBorderColor: Colors.white,
      unselectedBorderColor: Colors.redAccent,
    );
  }
}
