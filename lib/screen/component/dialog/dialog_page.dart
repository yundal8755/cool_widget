import 'package:cool_widget/app/widget/component/button/cool_button_widget.dart';
import 'package:cool_widget/screen/component/dialog/dialog_view_model.dart';
import 'package:flutter/material.dart';

class DialogPage extends StatefulWidget {
  const DialogPage({super.key});

  @override
  State<DialogPage> createState() => _DialogPageState();
}

class _DialogPageState extends State<DialogPage> {
  late DialogViewModel viewModel;

  @override
  void initState() {
    viewModel = DialogViewModel(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dialog")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CoolButton.text(
              title: '밑에서 위로 올라옴',
              onPressed: () => viewModel.bottomToTopAlert(context),
            ),
          ],
        ),
      ),
    );
  }
}
