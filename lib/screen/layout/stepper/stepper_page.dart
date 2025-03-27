import 'package:flutter/material.dart';

class StepperPage extends StatelessWidget {
  const StepperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TabBar Example',
      home: DefaultTabController(
        // 탭의 개수를 지정. 탭이 늘어나면 이 값도 해당 개수로 수정해야 함.
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('TabBar Example'),
            // TabBar를 AppBar의 하단 영역에 배치 (bottom 프로퍼티)
            bottom: const TabBar(
              // 각 탭에 들어갈 위젯 목록
              tabs: [
                Tab(text: '홈그라운드'),       // 텍스트만 있는 탭
                Tab(icon: Icon(Icons.star)), // 아이콘만 있는 탭
                Tab(text: '프로필'),   // 텍스트만 있는 탭
              ],
            ),
          ),
          // 탭과 연결되어, 탭 전환 시 표시될 화면(Widget)을 배치
          body: const TabBarView(
            children: [
              HomeTab(),
              StarTab(),
              ProfileTab(),
            ],
          ),
        ),
      ),
    );
  }
}

// 첫 번째 탭에서 표시할 화면
class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('홈 화면'),
    );
  }
}

// 두 번째 탭에서 표시할 화면
class StarTab extends StatelessWidget {
  const StarTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('스타 화면'),
    );
  }
}

// 세 번째 탭에서 표시할 화면
class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('프로필 화면'),
    );
  }
}