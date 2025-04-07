import 'package:cool_widget/presentation/components/tab_bar/cool_tab_bar_widget.dart';
import 'package:flutter/material.dart';

class TabBarPage extends StatefulWidget {
  const TabBarPage({super.key});

  @override
  State<TabBarPage> createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  // 최대 4개의 탭을 허용한다고 가정
  // (2개면 2등분, 3개면 3등분, 4개면 4등분)
  // 필요하면 실제 프로젝트에 맞춰 배열 크기를 제한하거나 처리
  final List<String> tabTexts = [
    "인터뷰",
    "Q&A",
    "긴 탭",
    // "더 긴 탭 Ekfkfkfkasdk",
    // 5개 이상은 허용하지 않는다고 가정할 때,
    // 이 이상을 넣으면 예외처리를 해도 되고,
    // 실제 로직으로 클라이언트 입력을 제한해도 됩니다.
  ];

  @override
  void initState() {
    super.initState();

    // 만약 4개를 초과하지 않는다고 가정
    // => 실제 상황에서는 assert나 예외처리로 방어 가능
    // assert(tabTexts.length <= 4, "최대 4개의 탭만 지원합니다.");

    // 탭 개수만큼 TabController 생성
    tabController = TabController(length: tabTexts.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // 화면너비
    final double screenWidth = MediaQuery.of(context).size.width;
    // 탭 개수
    final int tabCount = tabTexts.length;

    return Scaffold(
      appBar: AppBar(title: const Text("Tab Bar")),
      body: Column(
        children: [
          // ====== 커스텀 TabBar 위젯 (CommonTabBar) ======
          // 탭 개수에 맞춰 자동으로 등분
          CommonTabBar(
            tabController: tabController,
            tabLabels: tabTexts,
            totalWidth: screenWidth,
            tabCount: tabCount,
          ),

          // ====== TabBarView ======
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: List.generate(
                tabCount,
                (index) => Center(
                  child: Text("Tab Page: ${tabTexts[index]}"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
