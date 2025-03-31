import 'package:cool_widget/app/style/app_color.dart';
import 'package:cool_widget/app/style/app_text_style.dart';
import 'package:cool_widget/app/widget/component/badge/cool_badge_style.dart';
import 'package:cool_widget/app/widget/component/badge/cool_badge_widget.dart';

import 'package:cool_widget/app/widget/component/button/cool_button.dart';
import 'package:cool_widget/screen/layout/step_indicator/stepp_indicator_view_model.dart';
import 'package:flutter/material.dart';

class LinkedStepperPage extends StatefulWidget {
  const LinkedStepperPage({super.key});

  @override
  State<LinkedStepperPage> createState() => _LinkedStepperPageState();
}

class _LinkedStepperPageState extends State<LinkedStepperPage> {
  late StepperViewModel viewModel;

  @override
  void initState() {
    viewModel = StepperViewModel(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stepper'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _labelWidget(0, '위치정보'),
                        _labelWidget(1, '거래정보'),
                        _labelWidget(2, '상세정보'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 8, 12, 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _stepBadgeWidget(0),
                        _lineWidget(0),
                        _stepBadgeWidget(1),
                        _lineWidget(1),
                        _stepBadgeWidget(2),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: contentWidget(viewModel.currentStep),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (viewModel.currentStep < 3) {
                      viewModel.currentStep++;
                    } else {
                      viewModel.currentStep = 0;
                    }
                  });
                },
                child: const Text('다음'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Badge 위젯
  Widget _stepBadgeWidget(int stepIndex) {
    final progress = viewModel.getStepperProgress(stepIndex);
    final style = viewModel.getStepperStyle(progress, stepIndex);

    return CoolBadge.circle(
      style: CircleBadgeStyle(
        backgroundColor: style.backgroundColor,
        borderColor: style.borderColor,
        borderWidth: 4,
        contentPadding: const EdgeInsets.all(1),
        radius: 32,
      ),
      child: Center(child: style.childWidget),
    );
  }

  /// 스텝 사이 연결선
  Widget _lineWidget(int lineIndex) {
    final bool isLineActive = viewModel.currentStep >= (lineIndex + 1);
    return Expanded(
      child: Container(
        height: 4,
        color: isLineActive ? AppColor.green : AppColor.neutral100,
      ),
    );
  }

  /// 라벨 색상 결정
  Widget _labelWidget(int stepIndex, String label) {
    final progress = viewModel.getStepperProgress(stepIndex);

    final Color textColor;
    switch (progress) {
      case StepperProgress.standby:
        textColor = AppColor.neutral300;
        break;
      case StepperProgress.current:
      case StepperProgress.complete:
        textColor = AppColor.green;
        break;
    }

    return Text(label, style: AppTextStyle.body1.copyWith(color: textColor));
  }

  /// 스텝별 위젯
  Widget contentWidget(int stepIndex) {
    switch (stepIndex) {
      case 0:
        return Container(
          color: Colors.blue,
          child: const Placeholder(),
        );
      case 1:
        return Column(
          children: [
            const Text('hello'),
            const Spacer(),
            CoolButton(
              child: const Text('hello'),
              onPressed: () {
                setState(() {
                  if (viewModel.currentStep < 3) {
                    viewModel.currentStep++;
                  } else {
                    viewModel.currentStep = 0;
                  }
                });
              },
            ),
          ],
        );
      case 2:
        return const Text('STEP 3 화면', textAlign: TextAlign.center);
      case 3:
        return const Text('끝', textAlign: TextAlign.center);
      default:
        return const Text('오류: 존재하지 않는 단계입니다.');
    }
  }
}
