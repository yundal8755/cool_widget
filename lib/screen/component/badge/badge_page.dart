import 'package:cool_widget/app/widget/component/badge/cool_badge_style.dart';
import 'package:cool_widget/app/widget/component/badge/cool_badge_widget.dart';
import 'package:cool_widget/screen/component/badge/badge_view_model.dart';
import 'package:flutter/material.dart';

class BadgePage extends StatefulWidget {
  const BadgePage({super.key});

  @override
  State<BadgePage> createState() => _BadgePageState();
}

class _BadgePageState extends State<BadgePage> {
  late BadgeViewModel viewModel;

  @override
  void initState() {
    viewModel = BadgeViewModel(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Badge")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CoolBadge.circle(
              style: CircleBadgeStyle(
                backgroundColor: Colors.lightBlue,
                radius: 80,
                contentPadding: const EdgeInsets.all(1),
              ),
              child: const Icon(Icons.follow_the_signs),
            ),
            const SizedBox(height: 24),
            CoolBadge.rectangle(
              style: RectangleBadgeStyle(
                backgroundColor: Colors.green,
                width: 80,
                height: 24,
                cornerRadius: 12,
              ),
              child: const Center(child: Text('안녕')),
            ),
          ],
        ),
      ),
    );
  }
}
