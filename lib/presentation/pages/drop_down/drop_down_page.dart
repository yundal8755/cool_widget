import 'package:cool_widget/presentation/components/button/cool_button.dart';
import 'package:cool_widget/presentation/components/drop_down/cool_drop_down.dart';
import 'package:flutter/material.dart';

class DropDownPage extends StatefulWidget {
  const DropDownPage({super.key});

  @override
  State<DropDownPage> createState() => _DropDownPageState();
}

class _DropDownPageState extends State<DropDownPage> {
  final GlobalKey _buttonKey = GlobalKey();
  String? _selectedItem;

  final List<String> fruits = [
    'Apple', 'Banana', 'Cherry', 'Durian', 'Mango', 'Papaya', 'Pineapple',
    // 길게 넣어 스크롤 테스트도 가능
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dropdown'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // (1) 드롭다운 열기 위한 버튼
            CoolButton(
              key: _buttonKey, // 필수: 드롭다운 위치 계산에 사용
              onPressed: () {
                showCustomDropdown<String>(
                  context: context,
                  anchorKey: _buttonKey,
                  items: fruits,
                  onItemSelected: (value) {
                    setState(() {
                      _selectedItem = value;
                    });
                  },
                );
              },
              child: const Text('과일 선택하기'),
            ),

            const SizedBox(height: 16),

            // (2) 선택된 값 표시
            Text(
              _selectedItem == null
                  ? '선택된 과일이 없습니다.'
                  : '선택된 과일: $_selectedItem',
            ),
          ],
        ),
      ),
    );
  }
}
