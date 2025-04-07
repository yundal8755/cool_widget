import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'cool_date_time_spinner_style.dart';

class CoolDateSpinner extends StatefulWidget {
  final DateTime initialDate;
  final ValueChanged<DateTime> onConfirm;
  final VoidCallback? onCancel;

  /// 연도 범위
  final int minYear;
  final int maxYear;

  /// 스피너 타이틀 (ex: "날짜 선택")
  final String title;

  /// 스타일
  final CoolDateTimeSpinnerStyle style;

  const CoolDateSpinner({
    super.key,
    required this.initialDate,
    required this.onConfirm,
    this.onCancel,
    this.minYear = 1900,
    this.maxYear = 2100,
    this.title = "날짜 선택",
    this.style = const CoolDateTimeSpinnerStyle(),
  });

  @override
  State<CoolDateSpinner> createState() => _CoolDateSpinnerState();
}

class _CoolDateSpinnerState extends State<CoolDateSpinner> {
  late int _selectedYear;
  late int _selectedMonth;
  late int _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedYear = widget.initialDate.year;
    _selectedMonth = widget.initialDate.month;
    _selectedDay = widget.initialDate.day;
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style;

    // 전체 배경 데코가 필요하면 Container로 래핑
    return Container(
      decoration: style.backgroundDecoration,
      padding: style.contentPadding,
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // (1) 상단 Bar (타이틀, 닫기)
            SizedBox(
              height: style.topBarHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 48), // 여백 또는 아이콘 자리
                  Text(
                    widget.title,
                    style: style.titleTextStyle,
                  ),
                  IconButton(
                    icon: style.closeIcon,
                    onPressed: widget.onCancel ?? () => Navigator.pop(context),
                  ),
                ],
              ),
            ),

            // (2) 3중 Picker (년도/월/일)
            SizedBox(
              height: style.pickerHeight,
              child: Row(
                children: [
                  _buildYearPicker(style),
                  _buildMonthPicker(style),
                  _buildDayPicker(style),
                ],
              ),
            ),

            // (3) 버튼
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ElevatedButton(
                style: style.confirmButtonStyle,
                onPressed: _onConfirm,
                child: Text(
                  "확인",
                  style: style.confirmButtonTextStyle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildYearPicker(CoolDateTimeSpinnerStyle style) {
    final yearCount = widget.maxYear - widget.minYear + 1;
    return Expanded(
      child: CupertinoPicker(
        scrollController: FixedExtentScrollController(
          initialItem: _selectedYear - widget.minYear,
        ),
        itemExtent: style.itemExtent,
        onSelectedItemChanged: (index) {
          setState(() {
            _selectedYear = widget.minYear + index;
            _validateDay();
          });
        },
        children: List.generate(yearCount, (idx) {
          final year = widget.minYear + idx;
          return Center(
            child: Text("$year년", style: style.itemTextStyle),
          );
        }),
      ),
    );
  }

  Widget _buildMonthPicker(CoolDateTimeSpinnerStyle style) {
    return Expanded(
      child: CupertinoPicker(
        scrollController: FixedExtentScrollController(
          initialItem: _selectedMonth - 1,
        ),
        itemExtent: style.itemExtent,
        onSelectedItemChanged: (index) {
          setState(() {
            _selectedMonth = index + 1;
            _validateDay();
          });
        },
        children: List.generate(12, (idx) {
          final m = idx + 1;
          return Center(
            child: Text("$m월", style: style.itemTextStyle),
          );
        }),
      ),
    );
  }

  Widget _buildDayPicker(CoolDateTimeSpinnerStyle style) {
    return Expanded(
      child: CupertinoPicker(
        scrollController: FixedExtentScrollController(
          initialItem: _selectedDay - 1,
        ),
        itemExtent: style.itemExtent,
        onSelectedItemChanged: (index) {
          setState(() {
            _selectedDay = index + 1;
          });
        },
        children: List.generate(_daysInMonth(_selectedYear, _selectedMonth), (idx) {
          final d = idx + 1;
          return Center(
            child: Text("$d일", style: style.itemTextStyle),
          );
        }),
      ),
    );
  }

  int _daysInMonth(int year, int month) {
    final lastDay = DateTime(year, month + 1, 1).subtract(const Duration(days: 1));
    return lastDay.day;
  }

  void _validateDay() {
    final maxDay = _daysInMonth(_selectedYear, _selectedMonth);
    if (_selectedDay > maxDay) {
      _selectedDay = maxDay;
    }
  }

  void _onConfirm() {
    Navigator.pop(context);
    final selectedDate = DateTime(_selectedYear, _selectedMonth, _selectedDay);
    widget.onConfirm(selectedDate);
  }
}
