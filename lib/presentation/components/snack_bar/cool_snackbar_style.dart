import 'package:flutter/material.dart';

class CoolSnackbarStyle {
  final Color backgroundColor;
  final Color textColor;
  final IconData? icon;
  final double fontSize;
  final BorderRadius borderRadius;
  final EdgeInsets padding;

  const CoolSnackbarStyle({
    required this.backgroundColor,
    required this.textColor,
    this.icon,
    this.fontSize = 16,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
  });

  // 기본 프리셋 스타일들
  factory CoolSnackbarStyle.success() => CoolSnackbarStyle(
        backgroundColor: Colors.green[600]!,
        textColor: Colors.white,
        icon: Icons.check_circle,
      );

  factory CoolSnackbarStyle.error() => CoolSnackbarStyle(
        backgroundColor: Colors.red[600]!,
        textColor: Colors.white,
        icon: Icons.error,
      );

  factory CoolSnackbarStyle.warning() => CoolSnackbarStyle(
        backgroundColor: Colors.orange[600]!,
        textColor: Colors.white,
        icon: Icons.warning,
      );
}
