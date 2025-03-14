import 'package:flutter/material.dart';
import 'bottom_sheet_style.dart';

///
/// 1) 고정된 높이 & 스크롤 없이 사용할 수 있는 BottomSheet
///    - Drag to dismiss는 지원하지 않음
///    - (원한다면 내부에 SingleChildScrollView를 쓸 수도 있음)
///
class CoolBaseBottomSheet extends StatelessWidget {
  final AbstractBottomSheetStyle style;
  final Widget child;
  final VoidCallback? onClose;
  final VoidCallback? onTapIndicator;

  const CoolBaseBottomSheet({
    super.key,
    required this.style,
    required this.child,
    this.onClose,
    this.onTapIndicator,
  });

  @override
  Widget build(BuildContext context) {
    final double sheetHeight = style.mapHeight(context);

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        height: sheetHeight,
        decoration: BoxDecoration(
          color: style.backgroundColor,
          boxShadow: style.boxShadow,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(style.cornerRadius),
            topRight: Radius.circular(style.cornerRadius),
          ),
        ),
        child: Stack(
          children: [
            // 메인 컨텐츠
            Padding(
              padding: EdgeInsets.only(
                top: style.showCloseButton ? 40 : 16,
              ),
              child: child,
            ),

            // Indicator bar
            if (style.showIndicatorBar)
              Positioned(
                top: 8,
                left: 0,
                right: 0,
                child: Center(
                  child: GestureDetector(
                    onTap: onTapIndicator,
                    child: Container(
                      width: 36,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),
              ),

            // Close(X) 버튼
            if (style.showCloseButton)
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: onClose,
                  child: const Icon(Icons.close),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

///
/// 2) Draggable + Scrollable BottomSheet
///    - Drag to resize & dismiss
///    - 내부에 scrollController
///
class CoolDraggableBottomSheet extends StatelessWidget {
  final AbstractBottomSheetStyle style;
  final Widget child;
  final VoidCallback? onClose;
  final VoidCallback? onTapIndicator;

  /// Draggable 설정
  final double minChildSize;
  final double maxChildSize;
  final double initialChildSize;

  const CoolDraggableBottomSheet({
    super.key,
    required this.style,
    required this.child,
    this.onClose,
    this.onTapIndicator,
    this.minChildSize = 0.3,
    this.initialChildSize = 0.5,
    this.maxChildSize = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      // style.cornerRadius
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(style.cornerRadius),
        topRight: Radius.circular(style.cornerRadius),
      ),
      child: DraggableScrollableSheet(
        minChildSize: minChildSize,
        initialChildSize: initialChildSize,
        maxChildSize: maxChildSize,
        builder: (ctx, scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: style.backgroundColor,
              boxShadow: style.boxShadow,
            ),
            child: Stack(
              children: [
                // 내부 스크롤
                Padding(
                  padding: EdgeInsets.only(
                    top: style.showCloseButton ? 40 : 16,
                  ),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: child,
                  ),
                ),

                // Indicator
                if (style.showIndicatorBar)
                  Positioned(
                    top: 8,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: GestureDetector(
                        onTap: onTapIndicator,
                        child: Container(
                          width: 36,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ),
                  ),

                // Close button
                if (style.showCloseButton)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: onClose,
                      child: const Icon(Icons.close),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

///
/// 3) 편의용 래퍼: CoolBottomSheet
///    - 기본적으로 "고정된" BottomSheet를 사용
///    - dismissOnBackgroundTap, etc. → showModalBottomSheet 파라미터
///
class CoolBottomSheet extends StatelessWidget {
  final AbstractBottomSheetStyle? style;
  final Widget child;
  final VoidCallback? onClose;
  final VoidCallback? onTapIndicator;

  const CoolBottomSheet({
    super.key,
    this.style,
    required this.child,
    this.onClose,
    this.onTapIndicator,
  });

  @override
  Widget build(BuildContext context) {
    final usedStyle = style ?? const DefaultBottomSheetStyle();
    return CoolBaseBottomSheet(
      style: usedStyle,
      onClose: onClose,
      onTapIndicator: onTapIndicator,
      child: child,
    );
  }
}

///
/// 4) 편의용 래퍼: CoolDraggableSheet
///    - DraggableScrollableSheet를 사용하는 버전
///
class CoolDraggableSheet extends StatelessWidget {
  final AbstractBottomSheetStyle? style;
  final Widget child;
  final VoidCallback? onClose;
  final VoidCallback? onTapIndicator;

  final double minChildSize;
  final double maxChildSize;
  final double initialChildSize;

  const CoolDraggableSheet({
    super.key,
    this.style,
    required this.child,
    this.onClose,
    this.onTapIndicator,
    this.minChildSize = 0.3,
    this.initialChildSize = 0.5,
    this.maxChildSize = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    final usedStyle = style ?? const DefaultBottomSheetStyle();

    return CoolDraggableBottomSheet(
      style: usedStyle,
      onClose: onClose,
      onTapIndicator: onTapIndicator,
      minChildSize: minChildSize,
      initialChildSize: initialChildSize,
      maxChildSize: maxChildSize,
      child: child,
    );
  }
}
