import 'package:cool_widget/presentation/pages/avatar/avatar_page.dart';
import 'package:cool_widget/presentation/pages/badge/badge_page.dart';
import 'package:cool_widget/presentation/pages/dialog/dialog_page.dart';
import 'package:cool_widget/presentation/pages/bottom_sheet/bottom_sheet_page.dart';
import 'package:cool_widget/presentation/pages/button/button_page.dart';
import 'package:cool_widget/presentation/pages/snackbar/snackbar_page.dart';
import 'package:cool_widget/presentation/pages/form_field/form_field_page.dart';
import 'package:cool_widget/presentation/home_page.dart';
import 'package:cool_widget/presentation/pages/avatar_with_badge/avatar_with_badge_page.dart';
import 'package:cool_widget/presentation/pages/radio_group/radio_group_page.dart';
import 'package:cool_widget/presentation/pages/step_indicator/step_indicator_page.dart';
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
