import 'package:cool_widget/presentation/components/alert_dialog/cool_alert_dialog.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  State state;
  HomeViewModel(this.state);

  // 41개의 위젯 이름을 담은 리스트
  final List<String> widgetNames = [
    "Accodian",
    "AlertDialog",
    "Avatar",
    "Avatar+Badge",
    "Badge",
    "BottomSheet",
    "Button",
    "Carousel",
    "Dialog",
    "Drawer",
    "Dropdown",
    "FilterChip",
    "FormField",
    "Line",
    "LoadingIndicator",
    "MultiSelectGroup",
    "PullToRefresh",
    "SearchBar",
    "Spinner",
    "SkeletonLoader",
    "SnackBar",
    "StepIndicator",
    "Switch",
    "TabBar",
    "ToggleGroup",
    // ==========================
    "RatingBar",
    "AppBar",
    "NavigationBar",
    "ListTile",
    "DataPager",
    "ExpansionTile",
    "ColorPicker",
    "PageView",
    "Tooltip",
    "ProgressBar",
    "RangeSlider",
    "SliverAppBar",
    "Stepper",
  ];

  List<String> get completedWidgetNames => widgetNames.sublist(0, 25);
  List<String> get incompleteWidgetNames => widgetNames.sublist(25);

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
        builder: (_) => CoolAlertDialog.singleBtn(
          title: "",
          subTitle: "페이지가 존재하지 않습니다.",
          btnContent: "확인",
          onBtnClicked: () {
            Navigator.of(context).pop(); // 확인 버튼 클릭 시 닫기
          },
        ),
      );
    }
  }
}
