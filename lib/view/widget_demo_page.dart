// 예: lib/pages/widget_demo_page.dart
import 'package:flutter/material.dart';

class WidgetDemoPage extends StatelessWidget {
  final String widgetName;

  const WidgetDemoPage({super.key, required this.widgetName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widgetName),
      ),
      body: Center(
        child: Text(
          '$widgetName Page',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
