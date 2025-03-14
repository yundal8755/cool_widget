import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  State state;
  HomeViewModel(this.state);

  // 48개의 위젯 이름을 담은 리스트
  final List<String> widgetNames = [
    "Alert",
    "Button",
    "BottomSheet",
    "Dialog",
    "TextField",
    "AppBar",
    "NavigationBar",
    "Drawer",
    "Snackbar",
    "ListTile",
    "Checkbox",
    "Switch",
    "RadioButton",
    "Toast",
    "FormField",
    "Image",
    "Card",
    "ExpansionTile",
    "Chip",
    "Dropdown",
    "TabBar",
    "PageView",
    "Tooltip",
    "ModalSheet",
    "GestureDetector",
    "ProgressBar",
    "LoadingIndicator",
    "ActivityIndicator",
    "DatePicker",
    "TimePicker",
    "Calendar",
    "Stepper",
    "RangeSlider",
    "SliverAppBar",
    "DataTable",
    "MapWidget",
    "TreeView",
    "ColorPicker",
    "Avatar",
    "Badge",
    "SkeletonLoader",
    "Carousel",
    "SearchBar",
    "RatingBar",
    "FilterChip",
    "ActionChip",
    "StepIndicator",
    "DataPager",
  ];

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
