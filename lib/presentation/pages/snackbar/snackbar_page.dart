import 'package:cool_widget/presentation/components/button/cool_button.dart';
import 'package:cool_widget/presentation/components/snack_bar/cool_snackbar_style.dart';
import 'package:cool_widget/presentation/components/snack_bar/cool_snackbar_widget.dart';
import 'package:cool_widget/presentation/pages/snackbar/snackbar_view_model.dart';
import 'package:flutter/material.dart';

class SnackBarPage extends StatefulWidget {
  const SnackBarPage({super.key});

  @override
  State<SnackBarPage> createState() => _SnackBarPageState();
}

class _SnackBarPageState extends State<SnackBarPage> {
  late SnackBarViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = SnackBarViewModel(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("SnackBar")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              // 여백
              const SizedBox(height: 16),

              CoolButton(
                onPressed: () {
                  CoolSnackbar.show(
                    context: context,
                    message: '업로드에 성공했습니다!',
                    style: CoolSnackbarStyle.success(),
                    position: SnackbarPosition.top,
                  );
                },
                child: const Text('위에서 아래로 내려오는 성공 스낵바'),
              ),

              const SizedBox(height: 16),

              CoolButton(
                onPressed: () {
                  CoolSnackbar.show(
                    context: context,
                    message: '업로드에 실패했습니다!',
                    style: CoolSnackbarStyle.error(),
                    position: SnackbarPosition.bottom,
                  );
                },
                child: const Text('아래에서 위로 올라오는 실패 스낵바'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
