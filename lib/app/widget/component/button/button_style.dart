import 'package:flutter/material.dart';

enum ButtonShape {
  rectangle,
  circle,
}

enum ButtonWidth {
  small,
  medium,
  large,
  infinity,
}

enum ButtonHeight {
  small,
  medium,
  large,
  extraLarge,
}

enum ButtonState {
  enabled,
  disabled,
}

///
/// 버튼 스타일을 결정하는 추상 클래스
///
abstract class AbstractButtonStyle {
  // 기존 필드
  Color? get backgroundColor;
  Color? get borderColor;
  double get borderWidth;
  ButtonShape get shape;
  TextStyle get textStyle;
  double get iconSize;
  EdgeInsets get contentPadding;
  ButtonWidth get width;
  ButtonHeight get height;
  double get cornerRadius;
  List<BoxShadow>? get boxShadow;
  TextAlign get textAlign;
  TextOverflow get textOverflow;
  int get maxLines;

  /// 스타일 입장에서, [width]라는 enum이 실제로 몇 px인지 결정하는 메서드
  double mapWidthPx(ButtonWidth width);

  /// 스타일 입장에서, [height]라는 enum이 실제로 몇 px인지 결정하는 메서드
  double mapHeightPx(ButtonHeight height);

  /// 현재 [ButtonState]에 맞춰 스타일을 최종 결정하여 반환한다.
  AbstractButtonStyle resolve(ButtonState state);
}

///
/// 스타일 구현체
///
class DefaultButtonStyle implements AbstractButtonStyle {
  @override
  final Color? backgroundColor;
  @override
  final Color? borderColor;
  @override
  final double borderWidth;
  @override
  final ButtonShape shape;
  @override
  final TextStyle textStyle;
  @override
  final double iconSize;
  @override
  final EdgeInsets contentPadding;
  @override
  final ButtonWidth width;
  @override
  final ButtonHeight height;
  @override
  final double cornerRadius;
  @override
  final List<BoxShadow>? boxShadow;
  @override
  final TextAlign textAlign;
  @override
  final TextOverflow textOverflow;
  @override
  final int maxLines;

  const DefaultButtonStyle({
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 0.0,
    this.shape = ButtonShape.rectangle,
    this.textStyle = const TextStyle(fontSize: 14, color: Colors.black),
    this.iconSize = 24.0,
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    this.width = ButtonWidth.medium,
    this.height = ButtonHeight.medium,

    // 새 필드에 대한 기본값
    this.cornerRadius = 8.0,
    this.boxShadow,
    this.textAlign = TextAlign.center,
    this.textOverflow = TextOverflow.ellipsis,
    this.maxLines = 1,
  });

  /// [ButtonState.disabled] 시 색상/투명도 등을 조절할 수 있도록 분기
  @override
  AbstractButtonStyle resolve(ButtonState state) {
    switch (state) {
      case ButtonState.disabled:
        return DefaultButtonStyle(
          backgroundColor: backgroundColor?.withOpacity(0.3),
          borderColor: borderColor?.withOpacity(0.3),
          borderWidth: borderWidth,
          shape: shape,
          textStyle: textStyle.copyWith(
            color: textStyle.color?.withOpacity(0.3),
          ),
          iconSize: iconSize,
          contentPadding: contentPadding,
          width: width,
          height: height,
          cornerRadius: cornerRadius,
          boxShadow: boxShadow,
          textAlign: textAlign,
          textOverflow: textOverflow,
          maxLines: maxLines,
        );
      case ButtonState.enabled:
      default:
        return this;
    }
  }

  @override
  double mapWidthPx(ButtonWidth w) {
    switch (w) {
      case ButtonWidth.small:
        return 100;
      case ButtonWidth.medium:
        return 150;
      case ButtonWidth.large:
        return 220;
      case ButtonWidth.infinity:
        return double.infinity;
    }
  }

  @override
  double mapHeightPx(ButtonHeight h) {
    switch (h) {
      case ButtonHeight.small:
        return 40;
      case ButtonHeight.medium:
        return 56;
      case ButtonHeight.large:
        return 72;
      case ButtonHeight.extraLarge:
        return 100;
    }
  }

  // copyWith에 새 필드들 추가
  DefaultButtonStyle copyWith({
    Color? backgroundColor,
    Color? borderColor,
    double? borderWidth,
    ButtonShape? shape,
    TextStyle? textStyle,
    double? iconSize,
    EdgeInsets? contentPadding,
    ButtonWidth? width,
    ButtonHeight? height,
    double? cornerRadius,
    List<BoxShadow>? boxShadow,
    TextAlign? textAlign,
    TextOverflow? textOverflow,
    int? maxLines,
  }) {
    return DefaultButtonStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      shape: shape ?? this.shape,
      textStyle: textStyle ?? this.textStyle,
      iconSize: iconSize ?? this.iconSize,
      contentPadding: contentPadding ?? this.contentPadding,
      width: width ?? this.width,
      height: height ?? this.height,
      cornerRadius: cornerRadius ?? this.cornerRadius,
      boxShadow: boxShadow ?? this.boxShadow,
      textAlign: textAlign ?? this.textAlign,
      textOverflow: textOverflow ?? this.textOverflow,
      maxLines: maxLines ?? this.maxLines,
    );
  }
}

///
/// 자주 사용하는 스타일
///
class CoolButtonStyle {
  ///
  /// [PrimaryButton]
  ///
  static const DefaultButtonStyle primary = DefaultButtonStyle(
    backgroundColor: Colors.blue,
    borderColor: Colors.blueAccent,
    borderWidth: 1.0,
    shape: ButtonShape.rectangle,
    textStyle: TextStyle(
      fontSize: 16,
      color: Colors.white,
    ),
    iconSize: 20,
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    width: ButtonWidth.medium,
    height: ButtonHeight.medium,
    cornerRadius: 12.0,
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 4,
        offset: Offset(0, 2),
      )
    ],
    textAlign: TextAlign.center,
    textOverflow: TextOverflow.ellipsis,
    maxLines: 1,
  );

  ///
  /// [SecondaryButton]
  ///
  static const DefaultButtonStyle secondary = DefaultButtonStyle(
    backgroundColor: Colors.grey,
    borderColor: Colors.grey,
    borderWidth: 1.0,
    shape: ButtonShape.rectangle,
    textStyle: TextStyle(
      fontSize: 16,
      color: Colors.black,
    ),
    iconSize: 20,
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    width: ButtonWidth.medium,
    height: ButtonHeight.medium,
  );

  ///
  /// [GhostButton]
  ///
  static const DefaultButtonStyle ghost = DefaultButtonStyle(
    backgroundColor: Colors.transparent,
    borderColor: null,
    borderWidth: 0,
    shape: ButtonShape.rectangle,
    textStyle: TextStyle(
      fontSize: 16,
      color: Colors.black87,
    ),
    iconSize: 20,
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    width: ButtonWidth.medium,
    height: ButtonHeight.medium,
  );

  ///
  /// [DestructiveButton]
  ///
  static const DefaultButtonStyle destructive = DefaultButtonStyle(
    backgroundColor: Colors.red,
    borderColor: Colors.redAccent,
    borderWidth: 1.0,
    shape: ButtonShape.rectangle,
    textStyle: TextStyle(
      fontSize: 16,
      color: Colors.white,
    ),
    iconSize: 20,
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    width: ButtonWidth.medium,
    height: ButtonHeight.medium,
  );
}
