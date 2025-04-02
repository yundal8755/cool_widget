import 'package:cool_widget/presentation/components/button/cool_button.dart';
import 'package:cool_widget/presentation/pages/button/button_view_model.dart';
import 'package:flutter/material.dart';

class ButtonPage extends StatefulWidget {
  const ButtonPage({super.key});

  @override
  State<ButtonPage> createState() => _ButtonPageState();
}

class _ButtonPageState extends State<ButtonPage> {
  late ButtonViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = ButtonViewModel(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Button")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              // 여백
              const SizedBox(height: 16),

              CoolButton(
                onPressed: () => debugPrint('hello'),
                child: const Text('닫기 버튼, indicator bar 존재'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
