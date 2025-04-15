// calendar_page.dart
import 'package:cool_widget/presentation/components/calendar/cool_calendar_style.dart';
import 'package:cool_widget/presentation/components/calendar/cool_calendar_widget.dart';
import 'package:flutter/material.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final myEvents = {
      DateTime(2025, 4, 20): [],
    };

    // 1) Container 전체 스타일
    const containerStyle = CoolCalendarContainerStyle(
      backgroundColor: Colors.white,
      borderRadius: 16.0,
      boxShadows: [
        BoxShadow(
          color: Colors.black12,
          offset: Offset(0, 3),
          blurRadius: 6,
        ),
      ],
    );

    // 2) Header 스타일
    const headerStyle = CoolCalendarHeaderStyle(
      backgroundColor: Color(0xffcce0ff),
      titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      iconColor: Colors.black,
      iconSize: 28.0,
      headerMargin: EdgeInsets.only(bottom: 13),
      headerPadding: EdgeInsets.symmetric(vertical: 0),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
    );

    // 3) 요일 줄 스타일
    const daysOfWeekStyle = CoolCalendarDaysOfWeekStyle(
      weekdayStyle: TextStyle(color: Colors.black),
      weekendStyle: TextStyle(color: Colors.red),
      daysOfWeekHeight: 30.0,
    );

    // 4) 날짜 셀 스타일
    const cellStyle = CoolCalendarCellStyle(
      todayColor: Color(0xffd3d3d3),
      selectedColor: Color(0xff005bbf),
      eventColor: Color(0xff99ccff),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
      ),
      body: Container(
        height: 410,
        margin: const EdgeInsets.all(20.0),
        child: CoolCalendar(
          events: myEvents,
          containerStyle: containerStyle,
          headerStyle: headerStyle,
          daysOfWeekStyle: daysOfWeekStyle,
          cellStyle: cellStyle,
          initialFocusedDay: DateTime.now(),
          allowFormatChange: false,
          weekendDays: const [DateTime.sunday], // 일요일만 주말
          onDaySelected: (selected, focused) {},
        ),
      ),
    );
  }
}
