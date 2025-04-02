import 'package:flutter/material.dart';

class RadioGroupViewModel extends ChangeNotifier {
  final State state;

  List<RadioOption> items = RadioOption.values;
  RadioOption selectedOption = RadioOption.option1;

  /// CONSTRUCTOR
  RadioGroupViewModel(this.state);

  /// 값 변경시
  void onChanged(RadioOption value) {
    selectedOption = value;
    notifyListeners();
  }
}

enum RadioOption {
  option1('option 1'),
  option2('option 2'),
  option3('option 3');

  final String label;
  const RadioOption(this.label);
}
