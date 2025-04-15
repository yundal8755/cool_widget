import 'package:cool_widget/presentation/pages/accodian/accodian_page.dart';
import 'package:cool_widget/presentation/pages/alert_dialog/alert_dialog_page.dart';
import 'package:cool_widget/presentation/pages/avatar/avatar_page.dart';
import 'package:cool_widget/presentation/pages/badge/badge_page.dart';
import 'package:cool_widget/presentation/pages/calendar/calendar_page.dart';
import 'package:cool_widget/presentation/pages/carousel/carousel_page.dart';
import 'package:cool_widget/presentation/pages/dialog/dialog_page.dart';
import 'package:cool_widget/presentation/pages/bottom_sheet/bottom_sheet_page.dart';
import 'package:cool_widget/presentation/pages/button/button_page.dart';
import 'package:cool_widget/presentation/pages/drawer/drawer_page.dart';
import 'package:cool_widget/presentation/pages/drop_down/drop_down_page.dart';
import 'package:cool_widget/presentation/pages/filter_chip/filter_chip_page.dart';
import 'package:cool_widget/presentation/pages/line/line_page.dart';
import 'package:cool_widget/presentation/pages/pull_to_refresh/pull_to_refresh_page.dart';
import 'package:cool_widget/presentation/pages/search_bar/search_bar_page.dart';
import 'package:cool_widget/presentation/pages/skeleton_loader/skeleton_loader_page.dart';
import 'package:cool_widget/presentation/pages/snackbar/snackbar_page.dart';
import 'package:cool_widget/presentation/pages/form_field/form_field_page.dart';
import 'package:cool_widget/presentation/home_page.dart';
import 'package:cool_widget/presentation/pages/avatar_with_badge/avatar_with_badge_page.dart';
import 'package:cool_widget/presentation/pages/multi_select_group/multi_select_group_page.dart';
import 'package:cool_widget/presentation/pages/spinner/spinner_page.dart';
import 'package:cool_widget/presentation/pages/step_indicator/step_indicator_page.dart';
import 'package:cool_widget/presentation/pages/switch/switch_page.dart';
import 'package:cool_widget/presentation/pages/tab_bar/tab_bar_page.dart';
import 'package:cool_widget/presentation/pages/toggle_group/toggle_group_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 'ko_KR' 로케일에 대한 intl 날짜 형식 데이터를 로드
  await initializeDateFormatting('ko_KR', null);
  runApp(const _App());
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale('ko', 'KR'),
      title: 'Cool Widget',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/Accodian': (context) => const AccodianPage(),
        '/AlertDialog': (context) => const AlertDialogPage(),
        '/Avatar': (context) => const AvatarPage(),
        '/Avatar+Badge': (context) => const AvatarWithBadgePage(),
        '/Badge': (context) => const BadgePage(),
        '/BottomSheet': (context) => const BottomSheetPage(),
        '/Button': (context) => const ButtonPage(),
        '/Calendar': (context) => const CalendarPage(),
        '/Carousel': (context) => const CarouselPage(),
        '/Dialog': (context) => const DialogPage(),
        '/Dropdown': (context) => const DropDownPage(),
        '/Drawer': (context) => const DrawerPage(),
        '/FilterChip': (context) => const FilterChipPage(),
        '/FormField': (context) => const FormFieldPage(),
        '/Line': (context) => const LinePage(),
        '/MultiSelectGroup': (context) => const MultiSelectGroup(),
        '/PullToRefresh': (context) => const PullToRefreshPage(),
        '/SearchBar': (context) => const SearchBarPage(),
        '/SnackBar': (context) => const SnackBarPage(),
        '/Spinner': (context) => const SpinnerPage(),
        '/StepIndicator': (context) => const StepIndicatorPage(),
        '/SkeletonLoader': (context) => const SkeletonCardScreen(),
        '/Switch': (context) => const SwitchPage(),
        '/TabBar': (context) => const TabBarPage(),
        '/ToggleGroup': (context) => const ToggleGroupPage(),
      },
    );
  }
}
