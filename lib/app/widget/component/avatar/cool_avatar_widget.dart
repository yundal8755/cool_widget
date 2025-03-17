import 'package:flutter/material.dart';
import 'cool_avatar_style.dart';

class CoolAvatar extends StatelessWidget {
  final CoolAvatarStyle style;
  final Widget child;

  /// [Circle]
  CoolAvatar.circle({
    super.key,
    Widget? child,
    CoolAvatarStyle? style,
  })  : style = style ?? CircleAvatarStyle.circleDefault,
        child = child ?? const SizedBox.shrink();

  /// [Rectangle]
  CoolAvatar.rectangle({
    super.key,
    CoolAvatarStyle? style,
    Widget? child,
  })  : style = style ?? RectangleAvatarStyle.rectangleDefault,
        child = child ?? const SizedBox.shrink();

  @override
  Widget build(BuildContext context) {
    switch (style.shape) {
      case AvatarShape.circle:
        return _circleAvatar();

      case AvatarShape.rectangle:
        return _rectangleAvatar();

      case null:
        return const SizedBox.shrink();
    }
  }

  /// CoolAvatar.circle
  Widget _circleAvatar() {
    return Container(
      width: style.radius,
      height: style.radius,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: style.backgroundColor,
        shape: BoxShape.circle,
        boxShadow: style.shadow,
      ),
      child: child,
    );
  }

  /// CoolAvatar.rectangle
  Widget _rectangleAvatar() {
    return Container(
      width: style.width,
      height: style.height,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: style.backgroundColor,
        borderRadius: BorderRadius.circular(style.cornerRadius ?? 0),
        boxShadow: style.shadow,
      ),
      child: child,
    );
  }
}
