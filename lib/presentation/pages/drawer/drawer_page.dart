import 'package:cool_widget/presentation/components/drawer/cool_drawer_style.dart';
import 'package:cool_widget/presentation/components/drawer/cool_drawer_widget.dart';
import 'package:flutter/material.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 스타일 인스턴스 생성
    const customStyle = CoolDrawerStyle(
      width: 300, // 넓은 Drawer
      backgroundColor: Colors.white,
      borderRadius: 0.0,
      boxShadows: [
        BoxShadow(
          color: Colors.black26,
          offset: Offset(0, 4),
          blurRadius: 8,
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Drawer'),
      ),
      // 왼쪽 드로어
      drawer: CoolDrawer(
        drawerSide: DrawerSide.left,
        style: customStyle,
        header: Container(
          color: Colors.blueAccent,
          padding: const EdgeInsets.all(16.0),
          child: const Row(
            children: [
              Icon(Icons.person, color: Colors.white),
              SizedBox(width: 8),
              Text(
                '사용자 이름',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ),
        bodyItems: [
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('홈'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('설정'),
            onTap: () => Navigator.pop(context),
          ),
        ],
        footer: Container(
          color: Colors.grey.shade200,
          padding: const EdgeInsets.all(16.0),
          child: const Text('App Version 1.0.0'),
        ),
      ),

      // 오른쪽 드로어
      endDrawer: CoolDrawer(
        drawerSide: DrawerSide.right,
        style: CoolDrawerStyle(
          width: 250,
          backgroundColor: Colors.deepPurple.shade50,
          borderRadius: 24.0,
          boxShadows: [
            BoxShadow(
              color: Colors.deepPurple.withOpacity(0.3),
              offset: const Offset(0, 4),
              blurRadius: 10,
            ),
          ],
        ),
        header: Container(
          padding: const EdgeInsets.all(16.0),
          child: const Text(
            '오른쪽 Drawer',
            style: TextStyle(fontSize: 18),
          ),
        ),
        bodyItems: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('원하는 위젯을 마음껏 배치하세요.'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('확인'),
          ),
        ],
        footer: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(16.0),
          child: const Text('© 2025 MyCompany'),
        ),
      ),
      body: const Center(
        child: Text('Drawer 스타일 테스트 화면'),
      ),
    );
  }
}
