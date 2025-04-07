import 'package:flutter/material.dart';

class CoolMultiSelectGroup<T> extends StatelessWidget {
  final List<T> items;
  final Set<T> selectedValues;
  final ValueChanged<Set<T>> onChanged;
  final Widget Function(T item, bool isSelected) itemBuilder;
  final Axis direction;

  const CoolMultiSelectGroup({
    super.key,
    required this.items,
    required this.selectedValues,
    required this.onChanged,
    required this.itemBuilder,
    this.direction = Axis.vertical,
  });

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: direction,
      mainAxisAlignment: MainAxisAlignment.center,
      children: items.map((item) {
        final bool isSelected = selectedValues.contains(item);

        return GestureDetector(
          onTap: () {
            // 다중 선택 토글 로직
            final newSelected = Set<T>.from(selectedValues);
            if (newSelected.contains(item)) {
              newSelected.remove(item);
            } else {
              newSelected.add(item);
            }
            onChanged(newSelected);
          },
          child: itemBuilder(item, isSelected),
        );
      }).toList(),
    );
  }
}
