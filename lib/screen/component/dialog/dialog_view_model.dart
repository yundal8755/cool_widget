import 'package:cool_widget/app/widget/component/alert/alert.dart';
import 'package:cool_widget/app/widget/component/alert/alert_style.dart';
import 'package:flutter/material.dart';

class DialogViewModel extends ChangeNotifier {
  State state;
  DialogViewModel(this.state);

  /// 밑에서 위로 올라오는 알림
  void bottomToTopAlert(BuildContext context) {
    showCoolAlert(
      context: context,
      size: AlertSize.medium,
      child: Material(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("밑에서 올라온 후 하단 36px만 남김"),
            const SizedBox(height: 16),
            for (int i = 0; i < 20; i++) ListTile(title: Text("Item #$i")),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Close"),
            ),
          ],
        ),
      ),
    );
  }
}
