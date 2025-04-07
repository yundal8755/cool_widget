import 'package:flutter/material.dart';

/// PullToRefresh 모듈의 스타일/옵션 정의
class CoolPullToRefreshStyle {
  /// RefreshIndicator가 나타날 때의 스크롤 거리 (기본 80)
  final double displacement;

  /// 당겨서 새로고침 진행 시에 보이는 원형 인디케이터의 색상
  final Color color;

  /// 원형 인디케이터 배경색
  final Color backgroundColor;

  /// 인디케이터 두께
  final double strokeWidth;

  /// RefreshIndicator 내부에 들어갈 커스텀 위젯 (직접 구현한 애니메이션 등)
  /// 만약 null이 아니면, 기본 CircularProgressIndicator 대신 이 커스텀 위젯 표시
  final Widget? customIndicator;

  /// 진행 중 스낵바나 텍스트 등을 표시할지 여부 (예시)
  final bool showRefreshingText;

  /// (선택) 새로고침 완료 시 표시할 메시지나 UI
  final String? completeText;

  /// 생성자
  const CoolPullToRefreshStyle({
    this.displacement = 80.0,
    this.color = Colors.blue,
    this.backgroundColor = Colors.white,
    this.strokeWidth = 2.0,
    this.customIndicator,
    this.showRefreshingText = false,
    this.completeText,
  });
}
