import 'package:flutter/material.dart';
import 'cool_badge_style.dart';

class CoolBadge extends StatelessWidget {
  final Widget child;
  final CoolBadgeStyle style;

  CoolBadge.circle({
    super.key,
    Widget? child,
    CircleBadgeStyle? style,
  })  : style = style ?? CircleBadgeStyle.circleDefault,
        child = child ?? const SizedBox.shrink();

  CoolBadge.rectangle({
    super.key,
    Widget? child,
    RectangleBadgeStyle? style,
  })  : style = style ?? RectangleBadgeStyle.ractangleDefault,
        child = child ?? const SizedBox.shrink();

  @override
  Widget build(BuildContext context) {
    switch (style.shape) {
      case BadgeShape.circle:
        return _circleBadge();

      case BadgeShape.rectangle:
        return _rectangleBadge();

      case null:
        return const SizedBox.shrink();
    }
  }

  /// CoolBadge.circle
  Widget _circleBadge() {
    return Container(
      width: style.radius,
      height: style.radius,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: style.backgroundColor,
        shape: BoxShape.circle,
        boxShadow: style.shadow,
        border: Border.all(
            color: style.borderColor ?? Colors.transparent,
            width: style.borderWidth ?? 0),
      ),
      child: child,
    );
  }

  /// CoolBadge.rectangle
  Widget _rectangleBadge() {
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
