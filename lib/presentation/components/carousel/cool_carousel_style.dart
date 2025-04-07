import 'package:flutter/material.dart';

/// 캐러셀 옵션/스타일
class CoolCarouselStyle {
  /// 캐러셀 높이
  final double height;

  /// 한 화면에 보여줄 슬라이드의 폭 비율 (0.8 등으로 양옆 슬라이드가 살짝 보이게 할 수 있음)
  final double viewportFraction;

  /// 자동 슬라이드 활성화 여부
  final bool autoPlay;

  /// 자동 슬라이드 간격
  final Duration autoPlayInterval;

  /// **무한 루프**(Fake Items) 방식
  final bool infiniteScroll;

  /// **커스텀 애니메이션**(Transform) 사용 여부
  final bool usePageTransformer;

  /// (무한 스크롤일 때) 슬라이드 개수가 많아도
  /// 맨 끝 → 맨 처음으로 점프
  final bool loop; // 보통 infiniteScroll=true 이면 loop=true, 하지만 옵션으로 분리

  /// 인디케이터 표시/스타일
  final bool showIndicator;
  final Alignment indicatorAlignment;
  final Color indicatorActiveColor;
  final Color indicatorInactiveColor;
  final double indicatorSize; // 인디케이터 점(혹은 사각형) 크기
  final double indicatorSpacing; // 인디케이터 간격

  /// 인디케이터 모양: 원 or 사각형
  final BoxShape indicatorShape;

  /// Page Snapping (기본 true)
  final bool pageSnapping;

  /// 생성자
  const CoolCarouselStyle({
    this.height = 200,
    this.viewportFraction = 1.0,
    this.autoPlay = false,
    this.autoPlayInterval = const Duration(seconds: 3),
    this.infiniteScroll = false,
    this.usePageTransformer = false,
    this.loop = true,
    this.showIndicator = true,
    this.indicatorAlignment = Alignment.bottomCenter,
    this.indicatorActiveColor = Colors.blue,
    this.indicatorInactiveColor = Colors.grey,
    this.indicatorSize = 8,
    this.indicatorSpacing = 4,
    this.indicatorShape = BoxShape.circle,
    this.pageSnapping = true,
  });
}
