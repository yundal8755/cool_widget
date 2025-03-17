import 'package:cool_widget/app/widget/component/alert/alert.dart';
import 'package:cool_widget/app/widget/component/alert/alert_style.dart';
import 'package:cool_widget/app/widget/component/bottom_sheet/bottom_sheet.dart';
import 'package:cool_widget/app/widget/component/bottom_sheet/bottom_sheet_style.dart';
import 'package:cool_widget/app/widget/component/button/button.dart';
import 'package:cool_widget/app/widget/component/button/button_style.dart';
import 'package:flutter/material.dart';

class ButtonPage extends StatelessWidget {
  const ButtonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Button")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PrimaryButton(
              title: "텍스트 버튼",
              onPressed: () => showMyBottomSheet(context),
              width: ButtonWidth.infinity,
            ),

            // 여백
            const SizedBox(height: 16),

            PrimaryButton(
              icon: const Icon(Icons.thumb_up),
              onPressed: () => _testAlert(context),
            ),
          ],
        ),
      ),
    );
  }

  void showMyBottomSheet(BuildContext context) {
    // 1) style 선택(또는 미리 정의된 CoolSheetStyles.xxxx)
    final style = CoolSheetStyles.closableWithIndicator.copyWith(
      sheetHeight: BottomSheetHeight.partial,
      cornerRadius: 24.0,
    );

    // 2) showModalBottomSheet
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: true, // 배경 탭 닫기
      builder: (ctx) {
        // 3) CoolBottomSheet (고정 높이) or CoolDraggableSheet (드래그 가능)
        return CoolDraggableSheet(
          style: style,
          onClose: () => Navigator.of(ctx).pop(),
          onTapIndicator: () => debugPrint("indicator tapped"),
          child: Column(
            children: [
              const Text("Hello from Draggable BottomSheet"),
              for (int i = 0; i < 15; i++) ListTile(title: Text("Item $i")),
            ],
          ),
        );
      },
    );
  }

  void _testAlert(BuildContext context) {
    showCoolAlert(
      context: context,
      size: AlertSize.medium,
      child: Material(
        color: Colors.white, // or Colors.transparent
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("밑에서 올라온 후 하단 36px만 남김"),
            const SizedBox(height: 16),
            for (int i = 0; i < 20; i++) ListTile(title: Text("Item #$i")),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Close"),
            ),
          ],
        ),
      ),
    );
  }
}
