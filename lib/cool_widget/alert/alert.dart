import 'package:cool_widget/cool_widget/alert/alert_style.dart';
import 'package:flutter/material.dart';

Future<void> showCoolAlert({
  required BuildContext context,
  required AlertSize size,
  required Widget child,
}) {
  return showGeneralDialog(
    context: context,
    barrierColor: Colors.transparent, // 우린 직접 배경 애니메이션 처리
    barrierDismissible: true,
    barrierLabel: '',
    pageBuilder: (_, __, ___) {
      // 실제 UI는 transitionBuilder에서 그릴 것이므로 비워둡니다
      return const SizedBox.shrink();
    },
    transitionDuration: const Duration(milliseconds: 300),
    transitionBuilder: (ctx, animation, secondaryAnimation, childWidget) {
      // (1) 배경 투명도: 0 => 0.5 (검정 반투명), 뒤에는 0.5 => 0로
      final double backgroundOpacity = animation.value * 0.5;

      // (2) Alert의 슬라이드 애니메이션: 밑에서 위
      const Offset beginOffset = Offset(0, 1);
      const Offset endOffset = Offset.zero; // (0,0)
      final offsetTween = Tween<Offset>(begin: beginOffset, end: endOffset);
      final slideAnim = offsetTween.animate(CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
      ));

      return Stack(
        children: [
          // (A) 배경 (GestureDetector로 탭 시 닫기)
          Positioned.fill(
            child: GestureDetector(
              onTap: () => Navigator.of(ctx).pop(),
              child: Container(
                color: Colors.black.withOpacity(backgroundOpacity),
              ),
            ),
          ),

          // (B) Alert 본체: 밑에서 (0,1) → (0,0)
          //    아래에서 올라와서 하단 36px 남긴다
          Positioned(
            left: 12,
            right: 12,
            bottom: 36,
            child: SlideTransition(
              position: slideAnim,
              child: CoolAlertWidget(
                size: size,
                child: child,
              ),
            ),
          ),
        ],
      );
    },
  );
}

/// AlertWidget: width=화면 - 24, height=mapAlertHeight(size), cornerRadius=16
/// 내부는 scrollable
class CoolAlertWidget extends StatelessWidget {
  final AlertSize size;
  final Widget child;

  const CoolAlertWidget({
    super.key,
    required this.size,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final alertHeight = mapAlertHeight(size, context);

    return Container(
      height: alertHeight,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      // 내부 내용이 길면 스크롤
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: child,
      ),
    );
  }
}
