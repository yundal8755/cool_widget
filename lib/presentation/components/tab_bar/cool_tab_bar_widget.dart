import 'package:flutter/material.dart';

// ========================= CommonTabBar =========================

class CommonTabBar extends StatelessWidget {
  final TabController tabController;
  final List<String> tabLabels;
  final double totalWidth; // 전체 화면 너비
  final int tabCount; // 탭 개수 (최대 4)

  const CommonTabBar({
    Key? key,
    required this.tabController,
    required this.tabLabels,
    required this.totalWidth,
    required this.tabCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 탭 개수만큼 등분된 폭
    // (예: 탭이 2개면 1/2, 3개면 1/3, 4개면 1/4)
    final double singleTabWidth = totalWidth / tabCount;

    return ColoredBox(
      color: Colors.white,
      child: Stack(
        children: [
          // Flutter 기본 TabBar 사용
          // isScrollable=false 면 전체 폭을 차지하고, 내부적으로 탭 개수만큼 균등 배분
          // 단, 아래 처럼 Expanded를 감싸거나 전체 폭 제한이 있어야
          // 정확히 singleTabWidth씩 나누어 집니다.
          SizedBox(
            width: totalWidth,
            child: TabBar(
              controller: tabController,
              // 고정 너비 배분을 위해, isScrollable=false
              isScrollable: false,
              tabs: tabLabels.map((tabText) => Tab(text: tabText)).toList(),

              // 외관 스타일
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              labelStyle: const TextStyle(fontSize: 16),
              unselectedLabelStyle: const TextStyle(fontSize: 14),

              // 커스텀 인디케이터: 탭 한 칸에 맞춘 폭
              indicator: TechtalkTabBar(
                width: singleTabWidth,
                height: 2,
              ),
            ),
          ),

          // 아래쪽 Divider
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 0.5,
              color: Colors.grey.shade300,
            ),
          ),
        ],
      ),
    );
  }
}

// ========================= TechtalkTabBar =========================

class TechtalkTabBar extends Decoration {
  final double width;
  final double height; // 인디케이터 높이

  // 기본 높이 2, width는 (화면너비 / 탭개수)로 설정
  const TechtalkTabBar({
    required this.width,
    this.height = 2,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CustomPainter(
      width: width,
      height: height,
    );
  }
}

class _CustomPainter extends BoxPainter {
  final double width;
  final double height;

  _CustomPainter({
    required this.width,
    required this.height,
  });

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    // 현재 탭 한 칸의 폭 = configuration.size!.width
    // 하지만 여기서는 이미 width 파라미터로 (화면너비 / 탭수) 전달받았으므로
    // 그대로 사용할 수 있음.
    // 아래는 "해당 탭" 영역을 정확히 채운다고 가정해, xCenter 기준으로 인디케이터를 그립니다.

    final double xCenter = offset.dx + (configuration.size!.width / 2);
    final double yBottom = configuration.size!.height - height;

    // 커스텀 인디케이터 폭
    // 여기서는 "화면 / 탭 수" 로 넘어온 width.
    // 만약 특정 패딩을 더 주고 싶으면, width에서 몇 픽셀 빼도 됨
    final double indicatorWidth = width;

    final double startX = xCenter - (indicatorWidth / 2);
    final double endX = xCenter + (indicatorWidth / 2);

    // 그리기
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTRB(startX, yBottom, endX, yBottom + height),
        Radius.circular(height / 2),
      ),
      paint,
    );
  }
}
