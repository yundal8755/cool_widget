import 'package:cool_widget/app/style/app_color.dart';
import 'package:cool_widget/presentation/components/line/cool_line_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LinePage extends StatelessWidget {
  const LinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Line')),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CoolLine(
            thickness: 16,
            color: AppColor.gray050,
          ),
          Gap(16),
          CoolLine(
            orientation: Axis.vertical,
            length: 64,
            thickness: 4,
          ),
          Gap(16),
        ],
      ),
    );
  }
}
