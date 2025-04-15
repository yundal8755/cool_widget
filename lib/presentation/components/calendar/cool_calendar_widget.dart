// cool_calendar_widget.dart
import 'package:cool_widget/presentation/components/calendar/cool_calendar_style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

/// 모듈화된 CoolCalendar 위젯
class CoolCalendar extends StatefulWidget {
  final Map<DateTime, List> events;
  final Function(DateTime selectedDay, DateTime focusedDay)? onDaySelected;

  /// 주간, 월간 등 포맷 변경 가능 여부
  final bool allowFormatChange;

  /// 달력이 처음 보여줄 날짜
  final DateTime initialFocusedDay;

  /// Header 부분 스타일
  final CoolCalendarHeaderStyle headerStyle;

  /// Container(바깥) 스타일
  final CoolCalendarContainerStyle containerStyle;

  /// 요일 줄 스타일
  final CoolCalendarDaysOfWeekStyle daysOfWeekStyle;

  /// 날짜 셀 스타일
  final CoolCalendarCellStyle cellStyle;

  /// 달력 포맷(월, 주, 2주 등)
  final CalendarFormat initialCalendarFormat;

  /// "일요일만 주말로" 등 활용하려면 weekendDays도 파라미터로 받을 수 있음
  final List<int> weekendDays;

  CoolCalendar({
    super.key,
    required this.events,
    this.onDaySelected,
    this.allowFormatChange = true,
    DateTime? initialFocusedDay,

    // 스타일 파라미터
    this.headerStyle = const CoolCalendarHeaderStyle(),
    this.containerStyle = const CoolCalendarContainerStyle(),
    this.daysOfWeekStyle = const CoolCalendarDaysOfWeekStyle(),
    this.cellStyle = const CoolCalendarCellStyle(),

    // 기본 포맷, 주말 설정
    this.initialCalendarFormat = CalendarFormat.month,
    this.weekendDays = const [DateTime.sunday],
  }) : initialFocusedDay = initialFocusedDay ?? DateTime.now();

  @override
  State<CoolCalendar> createState() => _CoolCalendarState();
}

class _CoolCalendarState extends State<CoolCalendar> {
  late CalendarFormat _calendarFormat;
  late DateTime _focusedDay;
  DateTime? _selectedDay;

  PageController? _pageController;

  @override
  void initState() {
    super.initState();
    _calendarFormat = widget.initialCalendarFormat;
    _focusedDay = widget.initialFocusedDay;
  }

  @override
  Widget build(BuildContext context) {
    final contStyle = widget.containerStyle;
    final header = widget.headerStyle;
    final dowStyle = widget.daysOfWeekStyle;
    final cell = widget.cellStyle;

    return Container(
      decoration: contStyle.decoration ??
          BoxDecoration(
            color: contStyle.backgroundColor,
            borderRadius: BorderRadius.circular(contStyle.borderRadius),
            boxShadow: contStyle.boxShadows,
          ),
      child: TableCalendar(
        firstDay: DateTime(2000),
        lastDay: DateTime(2100),
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,

        weekendDays: widget.weekendDays,
        eventLoader: (date) {
          final key = DateTime(date.year, date.month, date.day);
          return widget.events[key] ?? [];
        },

        // onDaySelected
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
          widget.onDaySelected?.call(selectedDay, focusedDay);
        },
        onFormatChanged: (format) {
          if (widget.allowFormatChange) {
            setState(() => _calendarFormat = format);
          }
        },
        onPageChanged: (focusedDay) {
          _focusedDay = focusedDay;
        },
        onCalendarCreated: (controller) {
          _pageController = controller;
        },

        // ====================== HeaderStyle ======================
        headerStyle: HeaderStyle(
          titleCentered: true,
          formatButtonVisible: false,
          leftChevronVisible: false,
          rightChevronVisible: false,

          // 이 값은 headerTitleBuilder에서 직접 표시
          titleTextFormatter: (_, __) => '',
          headerMargin: header.headerMargin,
          headerPadding: header.headerPadding,
          decoration: header.decoration ??
              BoxDecoration(
                color: header.backgroundColor,
                borderRadius: header.borderRadius,
              ),
        ),

        // ====================== CalendarBuilders ======================
        calendarBuilders: CalendarBuilders(
          // (◀ YYYY.MM ▶)를 한 줄에 배치
          headerTitleBuilder: (context, day) {
            final year = day.year;
            final month = day.month.toString().padLeft(2, '0');
            final text = '$year.$month';

            return Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_left,
                        color: header.iconColor, size: header.iconSize),
                    onPressed: () {
                      _pageController?.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                      );
                    },
                  ),
                  Text(
                    text,
                    style: header.titleTextStyle,
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_right,
                        color: header.iconColor, size: header.iconSize),
                    onPressed: () {
                      _pageController?.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                      );
                    },
                  ),
                ],
              ),
            );
          },

          dowBuilder: (context, day) {
            // day.weekday == 1 => 월요일
            // intl 사용 -> "월", "화", "수", "목", "금", "토", "일" 형태로
            final shortName = DateFormat.E('ko_KR').format(day);
            // 필요에 따라 E, EEE, EEEE 등 패턴 조정 가능
            // E('ko_KR'): "월"
            // EEEE('ko_KR'): "월요일"

            final isWeekend = widget.weekendDays.contains(day.weekday);

            return Container(
              padding: dowStyle.dowPadding, // 기존 스타일로부터 패딩 적용
              alignment: Alignment.center,
              child: Text(
                shortName,
                style:
                    isWeekend ? dowStyle.weekendStyle : dowStyle.weekdayStyle,
              ),
            );
          },

          // 이벤트 날짜에 점 대신 사각형 배경
          defaultBuilder: (context, date, _) {
            if (isSameDay(date, _selectedDay)) return null;
            if (isSameDay(date, DateTime.now())) return null;

            final normalized = DateTime(date.year, date.month, date.day);
            final hasEvent = widget.events[normalized]?.isNotEmpty ?? false;
            if (hasEvent) {
              return Container(
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: cell.eventColor,
                  borderRadius: BorderRadius.circular(cell.borderRadius),
                ),
                child: Center(
                  child: Text(
                    '${date.day}',
                    style: _isSunday(date)
                        ? cell.weekendTextStyle
                        : cell.weekdayTextStyle,
                  ),
                ),
              );
            }
            return null; // 기본 렌더링
          },
        ),

        // ====================== DaysOfWeekStyle ======================
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: dowStyle.weekdayStyle,
          weekendStyle: dowStyle.weekendStyle,
        ),
        daysOfWeekHeight: dowStyle.daysOfWeekHeight,

        // ====================== CalendarStyle(날짜 셀) ======================
        calendarStyle: CalendarStyle(
          outsideDaysVisible: false,
          defaultTextStyle: cell.weekdayTextStyle,
          weekendTextStyle: cell.weekendTextStyle,

          todayDecoration: BoxDecoration(
            color: cell.todayColor,
            borderRadius: BorderRadius.circular(cell.borderRadius),
          ),
          todayTextStyle: cell.todayTextStyle,

          selectedDecoration: BoxDecoration(
            color: cell.selectedColor,
            borderRadius: BorderRadius.circular(cell.borderRadius),
          ),
          selectedTextStyle: cell.selectedDayTextStyle,
          cellMargin: cell.cellMargin,

          // 테이블 줄 선, 등등 필요하다면 추가
          tableBorder: TableBorder(
            horizontalInside: BorderSide(
              color: Colors.grey.shade300,
              width: 1,
            ),
          ),
        ),
      ),
    );
  }

  bool _isSunday(DateTime date) => date.weekday == DateTime.sunday;
}
