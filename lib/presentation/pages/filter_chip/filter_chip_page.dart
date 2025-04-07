import 'package:cool_widget/presentation/components/filter_chip/cool_filter_chip_style.dart';
import 'package:cool_widget/presentation/components/filter_chip/cool_filter_chip_widget.dart';
import 'package:cool_widget/presentation/pages/filter_chip/filter_chip_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterChipPage extends StatefulWidget {
  const FilterChipPage({super.key});

  @override
  State<FilterChipPage> createState() => _FilterChipPageState();
}

class _FilterChipPageState extends State<FilterChipPage> {
  late FilterChipViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = FilterChipViewModel(this);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FilterChipViewModel>.value(
      value: viewModel,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Filter Chip'),
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.transparent,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Consumer<FilterChipViewModel>(
            builder: (context, viewModel, child) {
              return Wrap(
                spacing: 12.0, // 칩 사이 간격
                runSpacing: 4.0,
                children: viewModel.categories.map((category) {
                  return CoolFilterChip(
                    label: category,
                    isSelected: viewModel.isSelected(category),
                    onSelected: () => viewModel.toggleCategory(category),
                    style: CoolFilterChipStyle.main(),
                  );
                }).toList(),
              );
            },
          ),
        ),
      ),
    );
  }
}
