import 'package:cool_widget/app/widget/component/snack_bar/cool_snackbar_style.dart';
import 'package:flutter/material.dart';

enum SnackbarPosition {
  top,
  bottom,
}

class CoolSnackbar {
  static OverlayEntry? _currentSnackbar;

  static void show({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(milliseconds: 1500),
    CoolSnackbarStyle? style,
    SnackbarPosition position = SnackbarPosition.bottom,
  }) {
    if (_currentSnackbar != null) return;

    final overlay = Overlay.of(context);
    final animationController = AnimationController(
      vsync: Navigator.of(context),
      duration: const Duration(milliseconds: 300),
    );

    final slideAnimation = Tween<Offset>(
      begin: position == SnackbarPosition.top
          ? const Offset(0, -1)
          : const Offset(0, 1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeOut),
    );

    final opacityAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeIn));

    style ??= CoolSnackbarStyle.success(); // 기본 스타일 지정

    final entry = OverlayEntry(
      builder: (context) => Positioned(
        top: position == SnackbarPosition.top
            ? MediaQuery.of(context).padding.top + 16
            : null,
        bottom: position == SnackbarPosition.bottom
            ? MediaQuery.of(context).padding.bottom + 16
            : null,
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: SlideTransition(
            position: slideAnimation,
            child: FadeTransition(
              opacity: opacityAnimation,
              child: _buildSnackbarContent(message, style!),
            ),
          ),
        ),
      ),
    );

    _currentSnackbar = entry;
    overlay.insert(entry);
    animationController.forward();

    Future.delayed(duration, () async {
      await animationController.reverse();
      entry.remove();
      _currentSnackbar = null;
    });
  }

  static Widget _buildSnackbarContent(String message, CoolSnackbarStyle style) {
    return Container(
      padding: style.padding,
      decoration: BoxDecoration(
        color: style.backgroundColor,
        borderRadius: style.borderRadius,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (style.icon != null) ...[
            Icon(style.icon, color: style.textColor),
            const SizedBox(width: 10),
          ],
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: style.textColor,
                fontSize: style.fontSize,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}
