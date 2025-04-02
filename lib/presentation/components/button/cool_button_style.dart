import 'package:cool_widget/app/style/app_color.dart';
import 'package:cool_widget/app/style/app_text_style.dart';
import 'package:flutter/material.dart';

class CoolButtonStyle {
  /// 1) 메인 스타일
  static final ButtonStyle main = FilledButton.styleFrom(
    backgroundColor: AppColor.green,
    foregroundColor: Colors.white,
    disabledBackgroundColor: Colors.grey,
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    textStyle: AppTextStyle.body1,
  );

  /// 2) 새롭게 추가된 스타일 1: Secondary
  static final ButtonStyle secondaryStyle = FilledButton.styleFrom(
    backgroundColor: Colors.green,
    foregroundColor: Colors.black,
    disabledBackgroundColor: Colors.grey,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    textStyle: AppTextStyle.h3,
  );

  /// 3) 새롭게 추가된 스타일 2: Danger
  static final ButtonStyle dangerStyle = FilledButton.styleFrom(
    backgroundColor: Colors.red,
    foregroundColor: Colors.white,
    disabledBackgroundColor: Colors.grey,
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    textStyle: AppTextStyle.h3,
  );
}
