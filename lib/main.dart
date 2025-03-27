import 'package:cool_widget/screen/component/avatar/avatar_page.dart';
import 'package:cool_widget/screen/component/badge/badge_page.dart';
import 'package:cool_widget/screen/component/dialog/dialog_page.dart';
import 'package:cool_widget/screen/component/bottom_sheet/bottom_sheet_page.dart';
import 'package:cool_widget/screen/component/button/button_page.dart';
import 'package:cool_widget/screen/component/text_field/text_field_page.dart';
import 'package:cool_widget/screen/home_page.dart';
import 'package:cool_widget/screen/layout/avatar_with_badge/avatar_with_badge_page.dart';
import 'package:cool_widget/screen/layout/stepper/stepper_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const _App());
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cool Widget',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        // '/Alert': (context) => const AlertPage(),
        '/Avatar': (context) => const AvatarPage(),
        '/Avatar+Badge': (context) => const AvatarWithBadgePage(),
        '/Badge': (context) => const BadgePage(),
        '/BottomSheet': (context) => const BottomSheetPage(),
        '/Button': (context) => const ButtonPage(),
        '/Dialog': (context) => const DialogPage(),
        '/TextField': (context) => const TextFieldPage(),
        '/Stepper': (context) => const StepperPage(),
      },
    );
  }
}
