import 'package:flutter/material.dart';
import 'package:cool_widget/app/style/app_color.dart';
import 'package:cool_widget/app/style/app_text_style.dart';

class CoolSearchBarStyle {
  static const Color activeColor = AppColor.green; // 포커스 상태일 때
  static const Color inactiveColor = AppColor.gray060; // 비활성 상태

  // 원하는 힌트/라벨 스타일
  static TextStyle get hintStyle =>
      AppTextStyle.h3.copyWith(color: AppColor.gray060);

  // 테두리 두께
  static const double borderThickness = 1.0;

  /// Underline 모드
  static InputDecoration getUnderlineDecoration({
    required bool isFocused,
    required String? hintText,
    Widget? suffixIcon,
    Widget? prefixIcon,
  }) {
    final borderColor = isFocused ? activeColor : inactiveColor;

    return InputDecoration(
      hintText: hintText,
      hintStyle: hintStyle,
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: borderColor, width: borderThickness),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: borderColor, width: borderThickness),
      ),
      errorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
      ),
      errorText: null,
    );
  }

  /// Outline 모드
  static InputDecoration getOutlineDecoration({
    required bool isFocused,
    required String? hintText,
    Widget? suffixIcon,
    Widget? prefixIcon,
  }) {
    final borderColor = isFocused ? activeColor : inactiveColor;

    return InputDecoration(
      hintText: hintText,
      hintStyle: hintStyle,
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: borderColor, width: borderThickness),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: borderColor, width: borderThickness),
      ),
      errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide(color: Colors.red),
      ),
      errorText: null,
    );
  }
}
