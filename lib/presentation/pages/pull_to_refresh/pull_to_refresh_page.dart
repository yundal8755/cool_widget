import 'package:cool_widget/presentation/components/pull_to_refresh/cool_pull_to_refresh_style.dart';
import 'package:cool_widget/presentation/components/pull_to_refresh/cool_pull_to_refresh_widget.dart';
import 'package:flutter/material.dart';

class PullToRefreshPage extends StatefulWidget {
  const PullToRefreshPage({super.key});

  @override
  State<PullToRefreshPage> createState() => _PullToRefreshPageState();
}

class _PullToRefreshPageState extends State<PullToRefreshPage> {
  List<String> items = List.generate(20, (index) => "Item $index");

  Future<void> _onRefresh() async {
    // 예시: 1.5초 뒤에 아이템 추가
    await Future.delayed(const Duration(milliseconds: 1500));
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    const style = CoolPullToRefreshStyle(
      displacement: 60.0,
      color: Colors.blue,
      backgroundColor: Colors.white,
      strokeWidth: 3.0,
      showRefreshingText: true,
    );

    return Scaffold(
      appBar: AppBar(title: const Text("Pull to Refresh")),
      body: CoolPullToRefresh(
        onRefresh: _onRefresh,
        style: style,
        showSnackBarOnComplete: true,
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (_, index) {
            return ListTile(
              title: Text(items[index]),
            );
          },
        ),
      ),
    );
  }
}
