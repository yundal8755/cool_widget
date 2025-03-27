import 'package:cool_widget/app/style/app_color.dart';
import 'package:flutter/material.dart';

enum LinkedStepperProgress { standby, current, complete }

class LinkedStepperViewModel {
  final State state;
  int currentStep = 0;

  /// CONSTRUCTOR
  LinkedStepperViewModel(this.state);

  /// 스텝 인덱스에 해당하는 StepperProgress 계산
  LinkedStepperProgress getStepperProgress(int stepIndex) {
    if (currentStep > stepIndex) {
      return LinkedStepperProgress.complete;
    } else if (currentStep == stepIndex) {
      return LinkedStepperProgress.current;
    } else {
      return LinkedStepperProgress.standby;
    }
  }

  /// 스텝 상태에 따른 borderColor, backgroundColor, childWidget을 반환
  StepperStyle getStepperStyle(LinkedStepperProgress progress, int stepIndex) {
    switch (progress) {
      case LinkedStepperProgress.standby:
        return const StepperStyle(
          borderColor: AppColor.neutral100,
          backgroundColor: AppColor.neutral050,
          childWidget: SizedBox.shrink(),
        );

      case LinkedStepperProgress.current:
        return const StepperStyle(
          borderColor: AppColor.green,
          backgroundColor: AppColor.neutral050,
          childWidget: SizedBox.shrink(),
        );

      case LinkedStepperProgress.complete:
        return const StepperStyle(
          borderColor: AppColor.green,
          backgroundColor: AppColor.green,
          childWidget: Padding(
            padding: EdgeInsets.all(1),
            child: Icon(
              Icons.check,
              color: AppColor.white,
              size: 20,
            ),
          ),
        );
    }
  }
}

class StepperStyle {
  final Color borderColor;
  final Color backgroundColor;
  final Widget childWidget;

  const StepperStyle({
    required this.borderColor,
    required this.backgroundColor,
    required this.childWidget,
  });
}
