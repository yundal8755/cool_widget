import 'package:cool_widget/presentation/components/button/cool_button.dart';
import 'package:cool_widget/presentation/pages/alert/alert_view_model.dart';
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
            CoolButton(
              onPressed: () => viewModel.showMyBottomSheet(context),
              child: const Text('닫기 버튼, indicator bar 존재'),
            ),
          ],
        ),
      ),
    );
  }
}
