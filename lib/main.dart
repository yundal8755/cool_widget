import 'package:cool_widget/screen/component/avatar/avatar_page.dart';
import 'package:cool_widget/screen/component/badge/badge_page.dart';
import 'package:cool_widget/screen/component/dialog/dialog_page.dart';
import 'package:cool_widget/screen/component/bottom_sheet/bottom_sheet_page.dart';
import 'package:cool_widget/screen/component/button/button_page.dart';
import 'package:cool_widget/screen/component/snackbar/snackbar_page.dart';
import 'package:cool_widget/screen/component/form_field/form_field_page.dart';
import 'package:cool_widget/screen/home_page.dart';
import 'package:cool_widget/screen/layout/avatar_with_badge/avatar_with_badge_page.dart';
import 'package:cool_widget/screen/layout/radio_button/radio_group_page.dart';
import 'package:cool_widget/screen/layout/step_indicator/step_indicator_page.dart';
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
        '/Button': (context) => const ButtonPage(),
        '/BottomSheet': (context) => const BottomSheetPage(),
        '/Dialog': (context) => const DialogPage(),
        '/FormField': (context) => const FormFieldPage(),
        '/SnackBar': (context) => const SnackBarPage(),
        '/StepIndicator': (context) => const StepIndicatorPage(),
        '/RadioGroup': (context) => const RadioGroupPage(),
      },
    );
  }
}
