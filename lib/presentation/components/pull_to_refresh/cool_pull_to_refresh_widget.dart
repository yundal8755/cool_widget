import 'dart:async';
import 'package:cool_widget/presentation/components/pull_to_refresh/cool_pull_to_refresh_style.dart';
import 'package:flutter/material.dart';

/// Pull-to-refresh 모듈화
class CoolPullToRefresh extends StatefulWidget {
  /// 실제 스크롤되는 콘텐츠
  final Widget child;

  /// 당겨서 새로고침 시 수행할 비동기 로직
  final Future<void> Function() onRefresh;

  /// 스타일/옵션
  final CoolPullToRefreshStyle style;

  /// 새로고침 완료 후 표시될 SnackBar를 띄울지 여부 (예시)
  final bool showSnackBarOnComplete;

  const CoolPullToRefresh({
    super.key,
    required this.child,
    required this.onRefresh,
    this.style = const CoolPullToRefreshStyle(),
    this.showSnackBarOnComplete = false,
  });

  @override
  State<CoolPullToRefresh> createState() => _CoolPullToRefreshState();
}

class _CoolPullToRefreshState extends State<CoolPullToRefresh> {
  Future<void> _handleRefresh() async {
    setState(() {});
    await widget.onRefresh();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style;

    return RefreshIndicator(
      displacement: style.displacement,
      color: style.color,
      backgroundColor: style.backgroundColor,
      strokeWidth: style.strokeWidth,
      onRefresh: _handleRefresh,
      child: Stack(
        children: [
          widget.child,
        ],
      ),
    );
  }
}
