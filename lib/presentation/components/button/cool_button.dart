import 'package:bounce_tapper/bounce_tapper.dart';
import 'package:cool_widget/presentation/components/button/cool_button_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CoolButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final ButtonStyle? style;
  final bool useHaptic;
  final bool useBounce;
  final bool useRippleEffect;
  final double? width;
  final double? height;

  const CoolButton({
    super.key,
    required this.child,
    this.onPressed,
    this.onLongPress,
    this.style,
    this.useHaptic = false,
    this.useBounce = true,
    this.useRippleEffect = true,
    this.width,
    this.height,
  });

  @override
  State<CoolButton> createState() => _CoolButtonState();
}

class _CoolButtonState extends State<CoolButton> {
  Future<void> _handleTap() async {
    if (widget.useHaptic && widget.onPressed != null) {
      HapticFeedback.mediumImpact();
    }
    widget.onPressed?.call();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = widget.onPressed == null;

    // 비활성화 상태 - 바운스/진동/리플 모두 적용 x
    if (isDisabled) {
      return _buildFilledButton(null, isRipple: false);
    }

    // 활성화 상태 - useBounce가 true면 BounceTapper로 감싸기
    if (widget.useBounce) {
      return BounceTapper(
        // onTap: _handleTap, // 제거: 탭 로직은 FilledButton이 담당
        child: _buildFilledButton(_handleTap, isRipple: widget.useRippleEffect),
      );
    } else {
      return _buildFilledButton(_handleTap, isRipple: widget.useRippleEffect);
    }
  }

  ///
  /// FilledButton 빌드
  ///
  Widget _buildFilledButton(
    VoidCallback? effectiveOnTap, {
    required bool isRipple,
  }) {
    // 우선 사용자가 지정한 style 혹은 기본 mainStyle 가져옴
    final baseStyle = widget.style ?? CoolButtonStyle.main;

    // 만약 리플 효과가 false라면 overlayColor와 splashFactory를 재설정해서 리플 제거
    final updatedStyle = !isRipple
        ? baseStyle.copyWith(
            overlayColor: WidgetStateProperty.all(Colors.transparent),
            splashFactory: NoSplash.splashFactory,
          )
        : baseStyle;

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: FilledButton(
        onPressed: effectiveOnTap,
        onLongPress: widget.onLongPress,
        style: updatedStyle,
        child: widget.child,
      ),
    );
  }
}
