import 'package:cool_widget/presentation/components/toggle_group/cool_toggle_group.dart';
import 'package:flutter/material.dart';

class ToggleGroupPage extends StatelessWidget {
  const ToggleGroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 라벨 및 각 탭에서 보여줄 위젯
    final List<String> tabs = ['지도 보기', '리스트 보기', '설정'];
    final List<Widget> children = [
      Container(
        alignment: Alignment.center,
        color: Colors.lightBlueAccent,
        child: const Text(
          '지도 화면',
          style: TextStyle(fontSize: 20),
        ),
      ),
      Container(
        alignment: Alignment.center,
        color: Colors.amberAccent,
        child: const Text(
          '리스트 화면',
          style: TextStyle(fontSize: 20),
        ),
      ),
      Container(
        alignment: Alignment.center,
        color: Colors.greenAccent,
        child: const Text(
          '설정 화면',
          style: TextStyle(fontSize: 20),
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Toggle Group')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: CoolToggleGroup(
            labels: tabs,
            height: 48,
            initialIndex: 0,
            backgroundBorderRadius: 24.0,
            borderColor: Colors.transparent,
            onChanged: (index) {
              debugPrint('선택된 인덱스: $index');
            },
            children: children,
          ),
        ),
      ),
    );
  }
}
