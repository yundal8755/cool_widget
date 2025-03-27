import 'package:cool_widget/app/style/app_text_style.dart';
import 'package:cool_widget/app/widget/component/badge/cool_badge_style.dart';
import 'package:cool_widget/app/widget/component/badge/cool_badge_widget.dart';
import 'package:flutter/material.dart';

enum StepperStatus { complete, active, inactive }

class StepData {
  final String title;
  final Widget content;
  StepData({required this.title, required this.content});
}

class CoolStepper extends StatefulWidget {
  final List<StepData> steps;
  final VoidCallback onCompleted;

  const CoolStepper({
    Key? key,
    required this.steps,
    required this.onCompleted,
  }) : super(key: key);

  @override
  State<CoolStepper> createState() => _CoolStepperState();
}

class _CoolStepperState extends State<CoolStepper> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 스크롤 영역
        Expanded(
          child: ListView.builder(
            itemCount: widget.steps.length,
            itemBuilder: (context, index) {
              return _buildStepItem(index);
            },
          ),
        ),
        // 하단 버튼들
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (_currentStep > 0)
              OutlinedButton(
                onPressed: _onStepCancel,
                child: const Text('이전 단계'),
              ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: _onStepContinue,
              child: _currentStep < widget.steps.length - 1
                  ? const Text('다음 단계')
                  : const Text('완료'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStepItem(int index) {
    final isActive = (index == _currentStep);
    final isCompleted = (index < _currentStep);
    final stepData = widget.steps[index];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // 위쪽 정렬
        children: [
          // Badge + Title
          _buildBadge(index, isActive, isCompleted, stepData.title),
          const SizedBox(width: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 만약 Divider를 세로선(VerticalDivider)로 쓰려면 바꿔야 하지만,
              // 그냥 임시로 width를 2, height를 30 등으로 정할 수도 있음
              Container(
                width: 2,
                height: 60,
                color: Colors.grey,
              ),
              const SizedBox(width: 8),
              if (isActive)
                Expanded(
                  child: _buildStepContent(stepData),
                ),
            ],
          ),
        ],
      ),
    );
  }

  // 왼쪽의 배지 + 아래로 늘어나는 라인(고정 높이)
  Widget _buildBadge(
    int index,
    bool isActive,
    bool isCompleted,
    String title,
  ) {
    final status = _getStepStatus(isCompleted, isActive);
    // 배지 색상/내용
    final (color, child) = switch (status) {
      StepperStatus.complete => (
          Colors.green,
          const Icon(Icons.check, color: Colors.white, size: 14)
        ),
      StepperStatus.active => (
          Colors.blue,
          Text('${index + 1}', style: const TextStyle(color: Colors.white))
        ),
      StepperStatus.inactive => (
          Colors.grey,
          Text('${index + 1}', style: const TextStyle(color: Colors.white))
        ),
    };

    return Row(
      children: [
        CoolBadge.circle(
          style: CircleBadgeStyle(
              backgroundColor: color,
              contentPadding: const EdgeInsets.all(1),
              radius: 36),
          child: Center(child: child),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: AppTextStyle.h3,
        )
      ],
    );
  }

  Widget _buildStepTitle(String title, bool isActive) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: isActive ? Colors.blue : Colors.black,
      ),
    );
  }

  Widget _buildStepContent(StepData data) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: data.content,
    );
  }

  StepperStatus _getStepStatus(bool isCompleted, bool isActive) {
    if (isCompleted) return StepperStatus.complete;
    if (isActive) return StepperStatus.active;
    return StepperStatus.inactive;
  }

  void _onStepContinue() {
    if (_currentStep < widget.steps.length - 1) {
      setState(() => _currentStep += 1);
    } else {
      widget.onCompleted();
    }
  }

  void _onStepCancel() {
    if (_currentStep > 0) {
      setState(() => _currentStep -= 1);
    }
  }
}
