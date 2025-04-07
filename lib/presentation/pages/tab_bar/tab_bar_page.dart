import 'package:cool_widget/app/style/app_color.dart';
import 'package:cool_widget/app/style/app_text_style.dart';
import 'package:flutter/material.dart';

class TabBarPage extends StatefulWidget {
  const TabBarPage({super.key});

  @override
  State<TabBarPage> createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> _tabs = [
    '앱 UI',
    '봄',
    '데스크',
    '집',
    '피크닉',
    '테니스룩',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _tabs.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('TabBar'),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48), // TabBar 높이
            child: TabBar(
              controller: _tabController,
              tabs: _tabs.map((text) {
                return Tab(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(text),
                  ),
                );
              }).toList(),
              indicatorSize: TabBarIndicatorSize.label,
              isScrollable: true,
              indicatorPadding: const EdgeInsets.symmetric(horizontal: 2),
              labelColor: AppColor.green,
              unselectedLabelColor: AppColor.gray060,
              labelStyle: const TextStyle(fontWeight: FontWeight.bold),
              unselectedLabelStyle: AppTextStyle.body2,
              indicatorColor: AppColor.green,
              indicatorWeight: 3,
              overlayColor: WidgetStateProperty.all(Colors.transparent),
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: _tabs.map((tab) {
            return Center(child: Text('$tab 화면'));
          }).toList(),
        ),
      ),
    );
  }
}
