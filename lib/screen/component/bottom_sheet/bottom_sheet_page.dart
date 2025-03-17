import 'package:cool_widget/app/widget/component/button/button.dart';
import 'package:cool_widget/app/widget/component/button/button_style.dart';
import 'package:cool_widget/screen/component/bottom_sheet/bottom_sheet_view_model.dart';
import 'package:flutter/material.dart';

class BottomSheetPage extends StatefulWidget {
  const BottomSheetPage({super.key});

  @override
  State<BottomSheetPage> createState() => _BottomSheetPageState();
}

class _BottomSheetPageState extends State<BottomSheetPage> {
  late BottomSheetViewModel viewModel;

  @override
  void initState() {
    viewModel = BottomSheetViewModel(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bottom Sheet")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PrimaryButton(
              title: "닫기 버튼, indicator bar 존재",
              onPressed: () => viewModel.showMyBottomSheet(context),
              width: ButtonWidth.infinity,
            ),
          ],
        ),
      ),
    );
  }
}
