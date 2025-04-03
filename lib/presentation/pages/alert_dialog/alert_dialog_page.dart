import 'package:cool_widget/presentation/components/button/cool_button.dart';
import 'package:cool_widget/presentation/components/loading_indicator/cool_loading_indicator.dart';
import 'package:cool_widget/presentation/pages/alert_dialog/alert_dialog_view_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AlertDialogPage extends StatefulWidget {
  const AlertDialogPage({super.key});

  @override
  State<AlertDialogPage> createState() => _AlertDialogPageState();
}

class _AlertDialogPageState extends State<AlertDialogPage> {
  late AlertDialogViewModel viewModel;

  // 로딩 상태를 표현할 변수
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    viewModel = AlertDialogViewModel(this);

    // 3초 후에 로딩 상태를 false로 변경
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
        if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CoolLoadingIndicator(
            isMaterial: true,
            radius: 16.0,
          )
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Alert")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// 단일 확인 버튼
            CoolButton(
              onPressed: () => viewModel.showSingleConfirmDialog(context),
              child: const Text('제목이 없는 경고성 알림'),
            ),
            const Gap(24),

            /// 확인, 취소 버튼
            CoolButton(
              onPressed: () => viewModel.showConfirmCancelDialog(context),
              child: const Text('확인, 취소의 선택지가 있는 버튼'),
            ),
          ],
        ),
      ),
    );
  }
}
