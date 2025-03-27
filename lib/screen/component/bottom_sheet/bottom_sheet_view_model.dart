import 'package:cool_widget/app/widget/component/bottom_sheet/bottom_sheet.dart';
import 'package:cool_widget/app/widget/component/bottom_sheet/bottom_sheet_style.dart';
import 'package:flutter/material.dart';

class BottomSheetViewModel extends ChangeNotifier {
  State state;
  BottomSheetViewModel(this.state);

  ///
  void showBottomSheet1(BuildContext context) {
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


    void showBottomSheet2(BuildContext context) {
    // 1) style 선택(또는 미리 정의된 CoolSheetStyles.xxxx)
    final style = CoolSheetStyles.fullGreen.copyWith(
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

  
}
