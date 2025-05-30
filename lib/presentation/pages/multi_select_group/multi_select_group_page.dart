import 'package:cool_widget/app/style/app_color.dart';
import 'package:cool_widget/app/style/app_text_style.dart';
import 'package:cool_widget/presentation/components/single_select_group/cool_single_select_group_widget.dart';
import 'package:cool_widget/presentation/pages/multi_select_group/multi_select_group_view_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class MultiSelectGroup extends StatefulWidget {
  const MultiSelectGroup({super.key});

  @override
  State<MultiSelectGroup> createState() => _MultiSelectGroupState();
}

class _MultiSelectGroupState extends State<MultiSelectGroup> {
  late MultiSelectGroupViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = MultiSelectGroupViewModel(this);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MultiSelectGroupViewModel>.value(
      value: viewModel,
      child: Consumer<MultiSelectGroupViewModel>(
        builder: (context, value, child) {
          return Scaffold(
            appBar: AppBar(title: const Text("Radio Group")),
            body: Column(
              children: [
                CoolSingleSelectGroup<RadioOption>(
                  items: viewModel.items,
                  selectedValue: viewModel.selectedOption,
                  onChanged: (value) => viewModel.onChanged(value),
                  itemBuilder: (option, isSelected) =>
                      _radioButton(option, isSelected),
                  direction: Axis.horizontal,
                ),

                // 인덱스별로 다른 위젯 반환
                _contentWidget(viewModel.selectedOption),

                const Gap(24),
              ],
            ),
          );
        },
      ),
    );
  }

  /// 각 라디오 버튼의 UI를 구성하는 위젯
  Widget _radioButton(RadioOption option, bool isSelected) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: isSelected ? AppColor.green : AppColor.gray050,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        option.label,
        style: AppTextStyle.body1.copyWith(
          color: isSelected ? AppColor.white : AppColor.black,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  /// 선택된 인덱스(case)별로 다른 위젯을 반환하는 함수
  Widget _contentWidget(RadioOption selectedOption) {
    switch (selectedOption) {
      case RadioOption.option1:
        return const Text('옵션 1을 선택하셨습니다');
      case RadioOption.option2:
        return const Text('옵션 2를 선택하셨습니다');
      case RadioOption.option3:
        return const Text('옵션 3을 선택하셨습니다');
      default:
        return const SizedBox();
    }
  }
}
