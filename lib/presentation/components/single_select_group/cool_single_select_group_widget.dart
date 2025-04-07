import 'package:flutter/material.dart';

class CoolSingleSelectGroup<T> extends StatelessWidget {
  final List<T> items;
  final T? selectedValue;
  final ValueChanged<T> onChanged;
  final Widget Function(T item, bool isSelected) itemBuilder;
  final Axis direction;

  const CoolSingleSelectGroup({
    super.key,
    required this.items,
    required this.onChanged,
    required this.itemBuilder,
    this.selectedValue,
    this.direction = Axis.vertical,
  });

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: direction,
      mainAxisAlignment: MainAxisAlignment.center,
      children: items.map((item) {
        final bool isSelected = item == selectedValue;

        /// ⚠️ itemBuilder 내부에서는 버튼 사용을 자제해주세요
        return GestureDetector(
          onTap: () => onChanged(item),
          child: itemBuilder(item, isSelected),
        );
      }).toList(),
    );
  }
}
