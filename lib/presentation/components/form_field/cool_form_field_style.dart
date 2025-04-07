import 'package:flutter/material.dart';
import 'package:cool_widget/app/style/app_color.dart';
import 'package:cool_widget/app/style/app_text_style.dart';

class CoolFormFieldStyle {
  static const Color activeColor = AppColor.green;
  static const Color borderInactiveColor = AppColor.gray060;
  static const Color hintColor = AppColor.gray060;
  static const double borderThickness = 0.5;
  static TextStyle hintStyle = AppTextStyle.h3.copyWith(color: hintColor);

  /// Underline Style
  static InputDecoration getUnderlineDecoration({
    required bool isFocused,
    required String? hintText,
    Widget? suffixIcon,
  }) {
    final borderColor = isFocused ? activeColor : borderInactiveColor;
    return InputDecoration(
      hintText: hintText,
      hintStyle: hintStyle,
      suffixIcon: suffixIcon,
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

  /// Outline Style
  static InputDecoration getOutlineDecoration({
    required bool isFocused,
    required String? hintText,
    Widget? suffixIcon,
  }) {
    final borderColor = isFocused ? activeColor : borderInactiveColor;

    return InputDecoration(
      hintText: hintText,
      hintStyle: hintStyle,
      suffixIcon: suffixIcon,

      // 테두리(Radius 등)를 OutlineInputBorder에서 지정
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: borderColor, width: borderThickness),
        borderRadius: BorderRadius.circular(12), // <-- 원하는 Radius
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: borderColor, width: borderThickness),
        borderRadius: BorderRadius.circular(12), // <-- 원하는 Radius
      ),

      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
        borderRadius: BorderRadius.all(Radius.circular(12)), // 같이 조정 가능
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      errorText: null,
    );
  }
}
