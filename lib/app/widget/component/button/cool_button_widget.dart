import 'package:cool_widget/app/widget/component/button/base_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'cool_button_style.dart';

///
/// text, icon, icon+text
///
class CoolButton extends StatelessWidget {
  final ButtonType type;

  final String? title;
  final String? iconPath;
  final String? leadingIcon;
  final String? trailingIcon;
  final double? iconSize;
  final VoidCallback onPressed;
  final VoidCallback? onLongPress;

  final CoolButtonStyle? style;
  final bool isEnabled;
  final bool bounceable;
  final bool useHapticFeedback;
  final bool useLongPress;

  final double? width;
  final double? height;

  /// [TEXT]
  CoolButton.text({
    super.key,
    this.type = ButtonType.text,
    TextButtonStyle? style,
    required String this.title,
    required this.onPressed,
    this.onLongPress,
    this.isEnabled = true,
    this.bounceable = true,
    this.useHapticFeedback = false,
    this.useLongPress = false,
    this.width,
    this.height,
  })  : iconPath = null,
        leadingIcon = null,
        trailingIcon = null,
        iconSize = null,
        style = style ?? TextButtonStyle.textDefault;

  /// [ICON]
  CoolButton.icon({
    super.key,
    this.type = ButtonType.icon,
    IconButtonStyle? style,
    required this.iconPath,
    required this.iconSize,
    required this.onPressed,
    this.onLongPress,
    this.isEnabled = true,
    this.bounceable = true,
    this.useHapticFeedback = false,
    this.useLongPress = false,
    this.width,
    this.height,
  })  : title = null,
        leadingIcon = null,
        trailingIcon = null,
        style = style ?? IconButtonStyle.iconDefault;

  /// [ICONTEXT]
  CoolButton.iconText({
    super.key,
    this.type = ButtonType.iconText,
    IconTextButtonStyle? style,
    required this.title,
    required this.onPressed,
    required this.iconSize,
    this.leadingIcon,
    this.trailingIcon,
    this.onLongPress,
    this.isEnabled = true,
    this.bounceable = true,
    this.useHapticFeedback = false,
    this.useLongPress = false,
    this.width,
    this.height,
  })  : iconPath = null,
        style = style ?? IconTextButtonStyle.iconTextDefault;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case ButtonType.text:
        return BaseButton(
            onPressed: onPressed,
            onLongPress: onLongPress,
            trailingIcon: trailingIcon,
            style: style,
            title: title,
            isEnabled: isEnabled,
            bounceable: bounceable,
            useHapticFeedback: useHapticFeedback,
            useLongPress: useLongPress,
            width: width,
            height: height,
            child: _textButton());

      case ButtonType.icon:
        return BaseButton(
            icon: iconPath,
            onPressed: onPressed,
            style: style,
            isEnabled: isEnabled,
            bounceable: bounceable,
            useHapticFeedback: useHapticFeedback,
            useLongPress: useLongPress,
            width: width,
            height: height,
            child: _iconButton());

      case ButtonType.iconText:
        return BaseButton(
            icon: iconPath,
            onPressed: onPressed,
            style: style,
            isEnabled: isEnabled,
            bounceable: bounceable,
            useHapticFeedback: useHapticFeedback,
            useLongPress: useLongPress,
            width: width,
            height: height,
            child: _iconTextButton());
    }
  }

  /// CoolButton.text
  Widget _textButton() {
    return _buildContainer(
      Center(
        child: Text(
          title ?? '',
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  /// CoolButton.icon
  Widget _iconButton() {
    return _buildContainer(
      SvgPicture.asset(
        iconPath ?? '',
        width: iconSize,
      ),
    );
  }

  /// CoolButton.iconText
  Widget _iconTextButton() {
    return _buildContainer(
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            leadingIcon ?? '',
            width: iconSize,
          ),
          SizedBox(width: style?.padding),
          Text(title ?? '', style: const TextStyle(color: Colors.white)),
          SizedBox(width: style?.padding),
          SvgPicture.asset(
            trailingIcon ?? '',
            width: iconSize,
          ),
        ],
      ),
    );
  }

  /// 공통 컨테이너
  Widget _buildContainer(Widget child) {
    return Container(
      width: width ?? style?.width,
      height: height ?? style?.height,
      decoration: BoxDecoration(
        color: style?.backgroundColor,
        borderRadius: BorderRadius.circular(style?.cornerRadius ?? 0),
        border: style?.borderColor != null
            ? Border.all(
                color: style!.borderColor!,
                width: style!.borderWidth ?? 1.0,
              )
            : null,
        boxShadow: style?.shadow,
      ),
      padding: EdgeInsets.all(style?.padding ?? 8),
      child: child,
    );
  }
}
