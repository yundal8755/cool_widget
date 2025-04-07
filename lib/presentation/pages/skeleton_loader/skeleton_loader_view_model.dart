import 'package:flutter/material.dart';

class SkeletonLoaderViewModel extends ChangeNotifier {
  State state;

  List<String> categories = ['전체', '음악', '영화', '스포츠'];
  final Set<String> selectedCategories = {};

  /// CONSTRUCTOR
  SkeletonLoaderViewModel(this.state);

  /// 특정 항목의 선택 상태를 토글하는 함수
  void toggleCategory(String category) {
    if (selectedCategories.contains(category)) {
      selectedCategories.remove(category);
    } else {
      selectedCategories.add(category);
    }
    notifyListeners();
  }

  /// 항목이 선택되었는지 확인하는 함수
  bool isSelected(String category) {
    return selectedCategories.contains(category);
  }
}
