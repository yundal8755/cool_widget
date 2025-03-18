import 'package:cool_widget/app/widget/component/button/cool_button_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

///
/// 공통 로직을 담당하는 베이스 위젯
///
class BaseButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;

  // 선택
  final VoidCallback? onLongPress;
  final String? title;
  final String? icon;
  final String? leadingIcon;
  final String? trailingIcon;
  final CoolButtonStyle? style;
  final bool isEnabled;
  final bool bounceable;
  final bool useHapticFeedback;
  final bool useLongPress;
  final double? width;
  final double? height;

  const BaseButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.onLongPress,
    this.title,
    this.icon,
    this.leadingIcon,
    this.trailingIcon,
    this.style,
    this.isEnabled = true,
    this.bounceable = true,
    this.useHapticFeedback = false,
    this.useLongPress = false,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    if (bounceable) {
      return Bounceable(
        onTap: isEnabled ? _handleTap : null,
        onLongPress: useLongPress && isEnabled ? onLongPress : null,
        child: child,
      );
    } else {
      return GestureDetector(
        onTap: isEnabled ? _handleTap : null,
        onLongPress: useLongPress && isEnabled ? onLongPress : null,
        child: child,
      );
    }
  }

  void _handleTap() {
    if (useHapticFeedback) {
      HapticFeedback.lightImpact();
    }
    onPressed.call();
  }
}
