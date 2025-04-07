import 'package:flutter/material.dart';
import 'cool_filter_chip_style.dart';

class CoolFilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback? onSelected;
  final bool showCheckmark;
  final CoolFilterChipStyle style;

  CoolFilterChip({
    super.key,
    required this.label,
    required this.isSelected,
    this.showCheckmark = false,
    this.onSelected,
    CoolFilterChipStyle? style,
  }) : style = style ?? CoolFilterChipStyle.main();

  @override
  Widget build(BuildContext context) {
    // isSelected에 따라 텍스트 색상 결정
    final effectiveTextColor =
        isSelected ? style.selectedTextColor : style.unselectedTextColor;

    // isSelected에 따라 테두리 색상 선택
    final effectiveBorderColor =
        isSelected ? style.selectedBorderColor : style.unselectedBorderColor;

    // shape가 RoundedRectangleBorder인 경우, side에 effectiveBorderColor 적용
    OutlinedBorder effectiveShape;
    if (style.shape is RoundedRectangleBorder) {
      final rounded = style.shape as RoundedRectangleBorder;
      effectiveShape = RoundedRectangleBorder(
        borderRadius: rounded.borderRadius,
        side: BorderSide(color: effectiveBorderColor),
      );
    } else {
      effectiveShape = style.shape;
    }

    return FilterChip(
      label: Text(
        label,
        style: style.labelStyle.copyWith(color: effectiveTextColor),
      ),
      showCheckmark: showCheckmark,
      selected: isSelected,
      onSelected: (_) => onSelected?.call(),
      selectedColor: style.selectedColor,
      backgroundColor: style.unselectedColor,
      checkmarkColor: style.checkmarkColor,
      padding: style.padding,
      shape: effectiveShape,
      elevation: style.elevation,
    );
  }
}
