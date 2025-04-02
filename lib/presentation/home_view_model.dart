import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  State state;
  HomeViewModel(this.state);

  // 41개의 위젯 이름을 담은 리스트
  final List<String> widgetNames = [
    "Avatar",
    "Avatar+Badge",
    "Badge",
    "Button",
    "BottomSheet",
    "Dialog",
    "FormField",
    "SnackBar",
    "StepIndicator",
    "RadioGroup",
    // ==========================
    "FilterChip",
    "Alert",
    "AppBar",
    "NavigationBar",
    "Drawer",
    "ListTile",
    "Checkbox",
    "Switch",
    "DataPager",
    "Image",
    // ==========================
    "Card",
    "ExpansionTile",
    "Dropdown",
    "TabBar",
    "PageView",
    "Tooltip",
    "ProgressBar",
    "LoadingIndicator",
    "DatePicker",
    "TimePicker",
    // ==========================
    "Calendar",
    "RangeSlider",
    "SliverAppBar",
    "DataTable",
    "ColorPicker",
    "SkeletonLoader",
    "Carousel",
    "SearchBar",
    "RatingBar",
    "ActionChip",
    // ==========================
    "Stepper",
  ];

  List<String> get completedWidgetNames => widgetNames.sublist(0, 10);
  List<String> get incompleteWidgetNames => widgetNames.sublist(10);

  ///
  /// 위젯 이름에 알맞게 라우팅
  ///
  void routeToWidgetPage(BuildContext context, String widgetName) {
    final routeName = '/$widgetName';

    try {
      Navigator.pushNamed(context, routeName);
    } catch (e, stackTrace) {
      // 라우트가 없을 때 발생하는 예외 처리
      debugPrint('라우팅 오류: $e\n$stackTrace');
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text('오류'),
            content: Text('$widgetName 페이지가 존재하지 않습니다.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('확인'),
              ),
            ],
          );
        },
      );
    }
  }
}
