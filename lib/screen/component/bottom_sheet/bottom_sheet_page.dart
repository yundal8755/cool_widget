import 'package:cool_widget/app/widget/component/button/new_cool_button.dart';
import 'package:cool_widget/screen/component/bottom_sheet/bottom_sheet_view_model.dart';
import 'package:flutter/material.dart';

class BottomSheetPage extends StatefulWidget {
  const BottomSheetPage({super.key});

  @override
  State<BottomSheetPage> createState() => _BottomSheetPageState();
}

class _BottomSheetPageState extends State<BottomSheetPage>
    with TickerProviderStateMixin {
  late BottomSheetViewModel viewModel;

  @override
  void initState() {
    viewModel = BottomSheetViewModel(this);
    super.initState();
  }

  @override
  void dispose() {
    viewModel = BottomSheetViewModel(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bottom Sheet")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
            child: Column(
              children: [
                CoolButton(
                  onPressed: () => showBouncyBottomSheet1(),
                  child: const Text('닫기 버튼, indicator bar 존재'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 1) 살짝 튀었다 돌아오는 기본 애니메이션 (Curves.easeOutBack), 300ms
  Future<void> showBouncyBottomSheet1() async {
    final controller = BottomSheet.createAnimationController(this);
    controller.duration = const Duration(milliseconds: 300);
    controller.drive(CurveTween(curve: Curves.easeOutBack));

    await showModalBottomSheet(
      context: context,
      // 아래 두 속성이 true면, 상단이나 배경 탭할 시 닫힘
      isScrollControlled: false,
      backgroundColor: Colors.transparent,
      transitionAnimationController: controller,
      isDismissible: true,
      builder: (_) {
        // 높이는 400 (예시)
        return const _BouncyBottomSheetContent(sheetHeight: 500);
      },
    );
  }
}

///
/// 바텀시트 내부 UI (고정 높이 + 스크롤 가능 + indicator + 둥근 모서리)
///
class _BouncyBottomSheetContent extends StatelessWidget {
  final double sheetHeight;
  final double cornerRadius;

  const _BouncyBottomSheetContent({
    this.sheetHeight = 400,
    this.cornerRadius = 24,
  });

  @override
  Widget build(BuildContext context) {
    // Align + ClipRRect 조합으로 위 모서리를 둥글게 처리
    return Align(
      alignment: Alignment.bottomCenter,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(cornerRadius),
          topRight: Radius.circular(cornerRadius),
        ),
        child: Container(
          height: sheetHeight,
          color: Colors.white,
          child: Column(
            children: [
              const SizedBox(height: 4),

              // Indicator
              Container(
                width: 48,
                height: 5,
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // 내부 스크롤 영역
              Expanded(
                child: ListView.builder(
                  itemCount: 30,
                  itemBuilder: (_, i) => ListTile(title: Text("Item $i")),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
