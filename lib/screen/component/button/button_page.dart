import 'package:cool_widget/app/widget/component/button/cool_button_widget.dart';
import 'package:cool_widget/app/constants/assets.dart';
import 'package:cool_widget/screen/component/button/button_view_model.dart';
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CoolButton.text(
              title: "텍스트 버튼",
              onPressed: () => viewModel.bottomToTopAlert(context),
            ),

            // 여백
            const SizedBox(height: 16),

            CoolButton.icon(
              iconPath: Assets.defaultLogoIcon,
              iconSize: 12,
              onPressed: () => viewModel.bottomToTopAlert(context),
            ),

            // 여백
            const SizedBox(height: 16),

            CoolButton.iconText(
              title: '아이콘텍스트',
              iconSize: 24,
              width: 240,
              leadingIcon: Assets.defaultLogoIcon,
              onPressed: () => viewModel.bottomToTopAlert(context),
            ),
          ],
        ),
      ),
    );
  }
}
