import 'package:cool_widget/presentation/components/accodian/cool_accodian_style.dart';
import 'package:cool_widget/presentation/components/accodian/cool_accodian_widget.dart';
import 'package:flutter/material.dart';

class AccodianPage extends StatelessWidget {
  const AccodianPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 스타일 정의
    const accordionStyle = CoolAccordionStyle(
      backgroundColor: Colors.white,
      borderRadius: 8.0,
      boxShadows: [
        BoxShadow(
          color: Colors.black12,
          offset: Offset(0, 2),
          blurRadius: 6,
        ),
      ],
      animationDuration: Duration(milliseconds: 300),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Accordion'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // (1) 간단한 아코디언 예시
          CoolAccordion(
            style: accordionStyle,
            header: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                '간단한 아코디언',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            content: Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: const Text('이곳에 펼쳐질 내용이 들어갑니다.'),
            ),
            expandIcon: Icons.add,
            collapseIcon: Icons.remove,
            // 처음엔 접힘 상태
            initiallyExpanded: false,
            onExpansionChanged: (bool expanded) {
              debugPrint('아코디언 펼쳐짐 여부: $expanded');
            },
          ),

          const SizedBox(height: 20),

          // (2) 토글OnHeaderTap 비활성화(아이콘만 클릭해서 펼침)
          CoolAccordion(
            style: accordionStyle.copyWith(
              backgroundColor: Colors.orange.shade50,
            ),
            header: const ListTile(
              leading: Icon(Icons.info_outline),
              title: Text('헤더 누르면 아무것도 안 함'),
            ),
            content: Container(
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                'header를 눌러도 펼치기/접기가 되지 않고, 아이콘만 눌렀을 때 동작합니다.',
              ),
            ),
            toggleOnHeaderTap: false, // 헤더 탭 동작 off
            expandIcon: Icons.keyboard_arrow_down,
            collapseIcon: Icons.keyboard_arrow_up,
            iconColor: Colors.red, // 아이콘 컬러 변경
            iconSize: 30.0, // 아이콘 사이즈 크게
          ),

          const SizedBox(height: 20),

          // (3) 초기부터 펼쳐진 상태
          CoolAccordion(
            style: accordionStyle.copyWith(
              backgroundColor: Colors.green.shade50,
            ),
            header: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                '처음부터 펼쳐짐',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            content: Container(
              padding: const EdgeInsets.all(16.0),
              child: const Text('초기 상태에서 이미 펼쳐져 있습니다.'),
            ),
            expandIcon: Icons.arrow_drop_down,
            collapseIcon: Icons.arrow_drop_up,
            initiallyExpanded: true, // 디폴트로 펼쳐진 상태
          ),

          // (추가된) 텍스트 + 펼침/닫힘 아이콘만 보여주는 간단한 아코디언 예시
          CoolAccordion(
            // 새로 추가된 onlyTextAndIcon 스타일 사용
            style: CoolAccordionStyle.onlyTextAndIcon(
              backgroundColor: Colors.white,
              animationDuration: const Duration(milliseconds: 300),
            ),
            header: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                '단순 텍스트 + 아이콘 아코디언',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            content: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                '이 아코디언은 최소한의 스타일만 적용되어, 텍스트와 아이콘만 간단히 표시됩니다.',
              ),
            ),
            expandIcon: Icons.add,
            collapseIcon: Icons.remove,
          ),
        ],
      ),
    );
  }
}
