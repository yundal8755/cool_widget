import 'package:flutter/material.dart';

/// BottomSheet의 높이를 정의하는 enum
/// - partial: 화면의 30%
/// - half: 화면의 50%
/// - full: 화면 가득
/// - fixed: 고정 px
enum BottomSheetHeight {
  partial,
  half,
  full,
  fixed,
}

/// AbstractBottomSheetStyle
/// - showCloseButton: 우측 상단 X 버튼 표시 여부
/// - showIndicatorBar: 상단 가운데 indicator bar 표시 여부
/// - backgroundColor, cornerRadius, boxShadow: 시각 요소
/// - sheetHeight + fixedHeightPx: 높이를 enum 기반으로 결정
abstract class AbstractBottomSheetStyle {
  bool get showCloseButton;
  bool get showIndicatorBar;

  Color get backgroundColor;
  double get cornerRadius;
  List<BoxShadow>? get boxShadow;

  /// bottomSheet 높이 결정
  BottomSheetHeight get sheetHeight;

  /// fixed 모드일 때 몇 px 쓸지
  double? get fixedHeightPx;

  /// sheetHeight.enum → 실제 높이(px) 계산
  double mapHeight(BuildContext context);

  /// copyWith for extension
  AbstractBottomSheetStyle copyWith({
    bool? showCloseButton,
    bool? showIndicatorBar,
    Color? backgroundColor,
    double? cornerRadius,
    List<BoxShadow>? boxShadow,
    BottomSheetHeight? sheetHeight,
    double? fixedHeightPx,
  });
}

///
/// DefaultBottomSheetStyle
/// - 기본 구현
///
class DefaultBottomSheetStyle implements AbstractBottomSheetStyle {
  @override
  final bool showCloseButton;
  @override
  final bool showIndicatorBar;
  @override
  final Color backgroundColor;
  @override
  final double cornerRadius;
  @override
  final List<BoxShadow>? boxShadow;
  @override
  final BottomSheetHeight sheetHeight;
  @override
  final double? fixedHeightPx;

  const DefaultBottomSheetStyle({
    this.showCloseButton = false,
    this.showIndicatorBar = false,
    this.backgroundColor = Colors.white,
    this.cornerRadius = 16.0,
    this.boxShadow,
    this.sheetHeight = BottomSheetHeight.half,
    this.fixedHeightPx,
  });

  @override
  double mapHeight(BuildContext context) {
    switch (sheetHeight) {
      case BottomSheetHeight.partial:
        return MediaQuery.of(context).size.height * 0.3;
      case BottomSheetHeight.half:
        return MediaQuery.of(context).size.height * 0.5;
      case BottomSheetHeight.full:
        return MediaQuery.of(context).size.height;
      case BottomSheetHeight.fixed:
        return fixedHeightPx ?? 200.0;
    }
  }

  @override
  AbstractBottomSheetStyle copyWith({
    bool? showCloseButton,
    bool? showIndicatorBar,
    Color? backgroundColor,
    double? cornerRadius,
    List<BoxShadow>? boxShadow,
    BottomSheetHeight? sheetHeight,
    double? fixedHeightPx,
  }) {
    return DefaultBottomSheetStyle(
      showCloseButton: showCloseButton ?? this.showCloseButton,
      showIndicatorBar: showIndicatorBar ?? this.showIndicatorBar,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      cornerRadius: cornerRadius ?? this.cornerRadius,
      boxShadow: boxShadow ?? this.boxShadow,
      sheetHeight: sheetHeight ?? this.sheetHeight,
      fixedHeightPx: fixedHeightPx ?? this.fixedHeightPx,
    );
  }
}

///
/// 예시로, 여러 스타일을 한곳에 모아둘 수도 있음
///
class CoolSheetStyles {
  /// 가장 기본 (X 버튼 표시, 상단 indicator 표시)
  static const DefaultBottomSheetStyle closableWithIndicator =
      DefaultBottomSheetStyle(
    showCloseButton: true,
    showIndicatorBar: true,
    backgroundColor: Colors.white,
    cornerRadius: 16.0,
    sheetHeight: BottomSheetHeight.half,
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 4,
        offset: Offset(0, 2),
      ),
    ],
  );

  /// 모든 화면을 꽉 채우는, 초록색 배경
  static const DefaultBottomSheetStyle fullGreen = DefaultBottomSheetStyle(
    showCloseButton: false,
    showIndicatorBar: false,
    backgroundColor: Colors.green,
    cornerRadius: 20.0,
    sheetHeight: BottomSheetHeight.full,
  );
}
