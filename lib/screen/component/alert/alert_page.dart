import 'package:cool_widget/screen/component/alert/alert_view_model.dart';
import 'package:cool_widget/app/widget/component/button/cool_button_widget.dart';
import 'package:flutter/material.dart';

class AlertPage extends StatefulWidget {
  const AlertPage({super.key});

  @override
  State<AlertPage> createState() => _AlertPageState();
}

class _AlertPageState extends State<AlertPage> {
  late AlertViewModel viewModel;

  @override
  void initState() {
    viewModel = AlertViewModel(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Alert")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CoolButton.text(
              title: "닫기 버튼, indicator bar 존재",
              onPressed: () => viewModel.showMyBottomSheet(context),
            ),
          ],
        ),
      ),
    );
  }
}
