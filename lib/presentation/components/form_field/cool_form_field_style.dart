import 'package:flutter/material.dart';

class CoolFormFieldStyle {

  /// Outline Border
  static InputDecoration outlineStyle({
    String? label,
    String? hint,
    EdgeInsets? contentPadding,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      border: const OutlineInputBorder(),
      contentPadding: contentPadding ?? const EdgeInsets.all(12),
    );
  }

  /// Underline Border
  static InputDecoration underlineStyle({
    String? label,
    String? hint,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      border: const UnderlineInputBorder(),
    );
  }

  /// boxDecoration을 감싸는 경우
  static BoxDecoration boxShadowDecoration({
    Color color = Colors.white,
    double radius = 8,
  }) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(radius),
      boxShadow: const [
        BoxShadow(
          color: Colors.black26,
          offset: Offset(0, 3),
          blurRadius: 6,
        ),
      ],
    );
  }
}
