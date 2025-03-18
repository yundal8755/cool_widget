import 'package:flutter/material.dart';

///
/// [SearchTextField] 스타일을 결정하는 추상 클래스
///
abstract class CoolTextFieldStyle {
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final double? borderRadius;
  final Color? focusedBorderColor;
  final double? focusedBorderWidth;
  final String? hintText;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final List<BoxShadow>? shadow;
  final double? height;

  /// CONSTRUCTOR
  const CoolTextFieldStyle._({
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.focusedBorderColor,
    this.focusedBorderWidth,
    this.hintText,
    this.hintStyle,
    this.textStyle,
    this.shadow,
    this.height,
  });
}

class TextFieldStyle extends CoolTextFieldStyle {
  const TextFieldStyle({
    super.backgroundColor,
    super.borderColor,
    super.borderWidth,
    super.borderRadius,
    super.focusedBorderColor,
    super.focusedBorderWidth,
    super.hintText,
    super.hintStyle,
    super.textStyle,
    super.shadow,
    super.height,
  }) : super._();

  static TextFieldStyle get rectangleDefault => const TextFieldStyle(
        backgroundColor: Colors.white,
        borderColor: Colors.grey,
        borderWidth: 0.5,
        borderRadius: 12,
        focusedBorderColor: Colors.green,
        focusedBorderWidth: 2,
        hintText: '검색어를 입력하세요.',
        hintStyle: TextStyle(color: Colors.grey),
        textStyle: TextStyle(color: Colors.black),
        shadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          )
        ],
        height: 48,
      );
}
