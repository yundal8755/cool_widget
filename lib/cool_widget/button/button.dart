import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'button_style.dart'; // AbstractButtonStyle, DefaultButtonStyle 등

/// 버튼의 공통 로직을 담당하는 베이스 위젯.
class CoolBaseButton extends StatelessWidget {
  final String? text;
  final Widget? icon;
  final VoidCallback? onPressed;
  final AbstractButtonStyle style;
  final bool isEnabled;
  final ButtonWidth? width;
  final ButtonHeight? height;

  /// 새로 추가한 프로퍼티들
  final bool bounceable; // default: false
  final bool useHapticFeedback; // default: false
  final bool useLongPress; // default: false
  final VoidCallback? onLongPress; // default: null

  const CoolBaseButton({
    super.key,
    required this.style,
    this.text,
    this.icon,
    this.onPressed,
    this.isEnabled = true,
    this.width,
    this.height,

    // 새로 추가한 프로퍼티들 (기본값)
    this.bounceable = false,
    this.useHapticFeedback = false,
    this.useLongPress = false,
    this.onLongPress,
  });

  ButtonState get buttonState =>
      isEnabled ? ButtonState.enabled : ButtonState.disabled;

  @override
  Widget build(BuildContext context) {
    // 1) 현재 버튼 상태(enabled/disabled)에 맞춰 최종 스타일 계산
    final resolvedStyle = style.resolve(buttonState);

    // 2) width, height 최종 결정
    final buttonWidth = width ?? resolvedStyle.width;
    final buttonHeight = height ?? resolvedStyle.height;

    // 3) enum→px
    final double containerWidth = resolvedStyle.mapWidthPx(buttonWidth);
    final double containerHeight = resolvedStyle.mapHeightPx(buttonHeight);

    // 4) 모양
    final ShapeBorder shapeBorder = (resolvedStyle.shape == ButtonShape.circle)
        ? const CircleBorder()
        : RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(resolvedStyle.cornerRadius),
          );

    // 5) 실제 보여줄 child (Container + Row + Icon + Text)
    final containerChild = Container(
      width: containerWidth,
      height: containerHeight,
      padding: resolvedStyle.contentPadding,
      decoration: ShapeDecoration(
        color: resolvedStyle.backgroundColor ?? Colors.transparent,
        shape: shapeBorder,
        shadows: resolvedStyle.boxShadow,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: _buildContent(resolvedStyle),
      ),
    );

    // 6) Gesture 처리( bounceable or GestureDetector )
    if (bounceable) {
      return Bounceable(
        onTap: isEnabled ? _handleTap : null,
        onLongPress: useLongPress && isEnabled ? onLongPress : null,
        child: containerChild,
      );
    } else {
      return GestureDetector(
        onTap: isEnabled ? _handleTap : null,
        onLongPress: useLongPress && isEnabled ? onLongPress : null,
        child: containerChild,
      );
    }
  }

  /// 실제 탭했을 때 로직
  void _handleTap() {
    // haptic 피드백
    if (useHapticFeedback) {
      HapticFeedback.lightImpact();
    }
    onPressed?.call();
  }

  /// 아이콘 + 텍스트가 모두 있으면 가운데에 Spacer() 추가
  List<Widget> _buildContent(AbstractButtonStyle style) {
    final List<Widget> widgets = [];

    if (icon != null) {
      widgets.add(
        IconTheme(
          data: IconThemeData(
            color: style.textStyle.color,
            size: style.iconSize,
          ),
          child: icon!,
        ),
      );
    }

    // 아이콘 + 텍스트 둘 다 있다면 가운데에 Spacer
    if (icon != null && text != null) {
      widgets.add(const Spacer());
    }

    if (text != null) {
      widgets.add(
        Text(
          text!,
          style: style.textStyle,
          textAlign: style.textAlign, // 만약 textAlign도 추가했다면
          overflow: style.textOverflow, // overflow 처리도 가능
          maxLines: style.maxLines, // 줄수 제한
        ),
      );
    }

    return widgets;
  }
}

/// 메인 버튼
class CoolButton extends StatelessWidget {
  final String? text;
  final Widget? icon;
  final VoidCallback? onPressed;

  final bool isEnabled;
  final DefaultButtonStyle? style;
  final ButtonWidth? width;
  final ButtonHeight? height;

  // 새 프로퍼티들
  final bool bounceable;
  final bool useHapticFeedback;
  final bool useLongPress;
  final VoidCallback? onLongPress;

  const CoolButton({
    super.key,
    this.text,
    this.icon,
    this.onPressed,
    this.isEnabled = true,
    this.style,
    this.width,
    this.height,
    this.bounceable = true,
    this.useHapticFeedback = false,
    this.useLongPress = false,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    // style이 null이면 기본 스타일
    final usedStyle = style ?? CoolButtonStyle.primary;

    return CoolBaseButton(
      style: usedStyle,
      text: text,
      icon: icon,
      onPressed: onPressed,
      isEnabled: isEnabled,
      width: width,
      height: height,

      // 새 프로퍼티 전달
      bounceable: bounceable,
      useHapticFeedback: useHapticFeedback,
      useLongPress: useLongPress,
      onLongPress: onLongPress,
    );
  }
}
