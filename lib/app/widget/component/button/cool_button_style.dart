// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

enum ButtonType { text, icon, iconText }

///
/// [Button] 스타일을 결정하는 추상 클래스
///
abstract class CoolButtonStyle {
  // 텍스트
  final String? title;
  final int? maxLines;
  final TextOverflow? textOverflow;
  final TextStyle? textStyle;

  // 아이콘
  final String? iconPath;
  final double? iconSize;

  // 아이콘 + 텍스트
  final String? leadingIcon;
  final double? leadingIconSize;
  final String? trailingIcon;
  final double? trailingIconSize;

  // 공통
  final ButtonType? type;
  final double? width;
  final double? height;
  final double? cornerRadius;
  final double? padding;
  final double? margin;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final List<BoxShadow>? shadow;

  /// CONSTRUCTOR
  CoolButtonStyle._({
    this.textStyle,
    this.maxLines,
    this.textOverflow,
    this.iconSize,
    this.title,
    this.iconPath,
    this.leadingIcon,
    this.trailingIcon,
    this.type,
    this.shadow,
    this.width,
    this.height,
    this.cornerRadius,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.leadingIconSize,
    this.trailingIconSize,
  });
}

///
/// [Text] 전용 스타일
///
class TextButtonStyle extends CoolButtonStyle {
  TextButtonStyle({
    required super.type,
    super.title,
    super.maxLines,
    super.textOverflow,
    super.textStyle,
    super.width,
    super.height,
    super.cornerRadius,
    super.padding,
    super.margin,
    super.backgroundColor,
    super.borderColor,
    super.borderWidth,
    super.shadow,
  }) : super._();

  /// Default
  static TextButtonStyle get textDefault => TextButtonStyle(
        type: ButtonType.icon,
        title: "Default Text",
        maxLines: 1,
        textOverflow: TextOverflow.ellipsis,
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
        width: 100,
        height: 40,
        cornerRadius: 8,
        padding: 8,
        backgroundColor: Colors.blue,
        borderColor: Colors.transparent,
        borderWidth: 0,
        shadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(2, 2),
          )
        ],
      );
}

///
/// [Icon] 전용 스타일
///
class IconButtonStyle extends CoolButtonStyle {
  IconButtonStyle({
    required super.type,
    super.iconPath,
    super.iconSize,
    super.width,
    super.height,
    super.cornerRadius,
    super.padding,
    super.margin,
    super.backgroundColor,
    super.borderColor,
    super.borderWidth,
    super.shadow,
  }) : super._();

  /// DEFAULT
  static IconButtonStyle get iconDefault => IconButtonStyle(
        type: ButtonType.icon,
        iconPath: "assets/images/default_icon.png",
        iconSize: 24,
        width: 48,
        height: 48,
        cornerRadius: 8,
        padding: 8,
        backgroundColor: Colors.green,
        borderColor: Colors.transparent,
        borderWidth: 0,
        shadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(2, 2),
          )
        ],
      );
}

///
/// [IconText] 전용 스타일
///
class IconTextButtonStyle extends CoolButtonStyle {
  IconTextButtonStyle({
    required super.type,
    super.title,
    super.maxLines,
    super.textOverflow,
    super.textStyle,
    super.iconPath,
    super.iconSize,
    super.leadingIcon,
    super.trailingIcon,
    super.width,
    super.height,
    super.cornerRadius,
    super.padding,
    super.margin,
    super.backgroundColor,
    super.borderColor,
    super.borderWidth,
    super.leadingIconSize,
    super.trailingIconSize,
    super.shadow,
  }) : super._();

  /// DEFAULT
  static IconTextButtonStyle get iconTextDefault => IconTextButtonStyle(
        type: ButtonType.iconText,
        maxLines: 1,
        textOverflow: TextOverflow.ellipsis,
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
        width: 150,
        height: 60,
        cornerRadius: 8,
        padding: 8,
        backgroundColor: Colors.orange,
        borderColor: Colors.transparent,
        borderWidth: 0,
        leadingIconSize: 20,
        trailingIconSize: 20,
        shadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(2, 2),
          )
        ],
      );
}
