import 'package:cool_widget/app/style/app_color.dart';
import 'package:flutter/material.dart';

enum StepperProgress { standby, current, complete }

class StepperViewModel {
  final State state;
  int currentStep = 0;

  /// CONSTRUCTOR
  StepperViewModel(this.state);

  /// 스텝 인덱스에 해당하는 StepperProgress 계산
  StepperProgress getStepperProgress(int stepIndex) {
    if (currentStep > stepIndex) {
      return StepperProgress.complete;
    } else if (currentStep == stepIndex) {
      return StepperProgress.current;
    } else {
      return StepperProgress.standby;
    }
  }

  /// 스텝 상태에 따른 borderColor, backgroundColor, childWidget을 반환
  StepperStyle getStepperStyle(StepperProgress progress, int stepIndex) {
    switch (progress) {
      case StepperProgress.standby:
        return const StepperStyle(
          borderColor: AppColor.neutral100,
          backgroundColor: AppColor.neutral050,
          childWidget: SizedBox.shrink(),
        );

      case StepperProgress.current:
        return const StepperStyle(
          borderColor: AppColor.green,
          backgroundColor: AppColor.neutral050,
          childWidget: SizedBox.shrink(),
        );

      case StepperProgress.complete:
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
