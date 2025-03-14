import 'package:cool_widget/view/dialog_page.dart';
import 'package:cool_widget/view/bottom_sheet_page.dart';
import 'package:cool_widget/view/button_page.dart';
import 'package:cool_widget/view/home_page.dart';
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
        '/BottomSheet': (context) => const BottomSheetPage(),
        '/Button': (context) => const ButtonPage(),
        '/Dialog': (context) => const DialogPage(),
      },
    );
  }
}
