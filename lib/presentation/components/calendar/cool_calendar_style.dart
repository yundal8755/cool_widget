// cool_calendar_container_style.dart
import 'package:flutter/material.dart';

/// 캘린더 바깥 Container에 대한 스타일
class CoolCalendarContainerStyle {
  /// 배경색
  final Color backgroundColor;

  /// 모서리 둥글림
  final double borderRadius;

  /// 그림자 리스트
  final List<BoxShadow> boxShadows;

  /// decoration이 별도로 있다면 우선 적용
  final Decoration? decoration;

  const CoolCalendarContainerStyle({
    this.backgroundColor = Colors.white,
    this.borderRadius = 8.0,
    this.boxShadows = const [],
    this.decoration,
  });

  CoolCalendarContainerStyle copyWith({
    Color? backgroundColor,
    double? borderRadius,
    List<BoxShadow>? boxShadows,
    Decoration? decoration,
  }) {
    return CoolCalendarContainerStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderRadius: borderRadius ?? this.borderRadius,
      boxShadows: boxShadows ?? this.boxShadows,
      decoration: decoration ?? this.decoration,
    );
  }
}

/// TableCalendar의 HeaderStyle + headerTitleBuilder에 관련된 옵션
class CoolCalendarHeaderStyle {
  /// 헤더 배경색
  final Color backgroundColor;

  /// 헤더의 상하좌우 패딩, 마진 등
  final EdgeInsets headerMargin;
  final EdgeInsets headerPadding;

  /// 제목(YYYY.MM) 텍스트 스타일
  final TextStyle titleTextStyle;

  /// 좌우 화살표 아이콘 색상, 크기
  final Color iconColor;
  final double iconSize;

  /// 헤더 모서리 둥글림
  final BorderRadius? borderRadius;

  /// 기타 decoration 전체를 지정하고 싶다면
  final BoxDecoration? decoration;

  /// (추가) 헤더 높이 등등, 필요한 만큼 추가 가능

  const CoolCalendarHeaderStyle({
    this.backgroundColor = const Color(0xffcce0ff),
    this.headerMargin = const EdgeInsets.only(bottom: 4),
    this.headerPadding = const EdgeInsets.symmetric(vertical: 8),
    this.titleTextStyle =
        const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    this.iconColor = Colors.black,
    this.iconSize = 24.0,
    this.borderRadius,
    this.decoration,
  });

  CoolCalendarHeaderStyle copyWith({
    Color? backgroundColor,
    EdgeInsets? headerMargin,
    EdgeInsets? headerPadding,
    TextStyle? titleTextStyle,
    Color? iconColor,
    double? iconSize,
    BorderRadius? borderRadius,
    BoxDecoration? decoration,
  }) {
    return CoolCalendarHeaderStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      headerMargin: headerMargin ?? this.headerMargin,
      headerPadding: headerPadding ?? this.headerPadding,
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      iconColor: iconColor ?? this.iconColor,
      iconSize: iconSize ?? this.iconSize,
      borderRadius: borderRadius ?? this.borderRadius,
      decoration: decoration ?? this.decoration,
    );
  }
}

/// 요일 줄(월화수목금토일)의 텍스트 스타일
class CoolCalendarDaysOfWeekStyle {
  /// 평일 요일 텍스트 스타일
  final TextStyle weekdayStyle;

  /// 주말 요일 텍스트 스타일
  final TextStyle weekendStyle;

  /// 요일 줄 높이
  final double daysOfWeekHeight;

  /// (추가) 요일 텍스트에 적용할 padding
  final EdgeInsets dowPadding;

  const CoolCalendarDaysOfWeekStyle({
    this.weekdayStyle = const TextStyle(color: Colors.black),
    this.weekendStyle = const TextStyle(color: Colors.red),
    this.daysOfWeekHeight = 28.0,
    this.dowPadding = const EdgeInsets.all(0),
  });

  CoolCalendarDaysOfWeekStyle copyWith({
    TextStyle? weekdayStyle,
    TextStyle? weekendStyle,
    double? daysOfWeekHeight,
    EdgeInsets? dowPadding,
  }) {
    return CoolCalendarDaysOfWeekStyle(
      weekdayStyle: weekdayStyle ?? this.weekdayStyle,
      weekendStyle: weekendStyle ?? this.weekendStyle,
      daysOfWeekHeight: daysOfWeekHeight ?? this.daysOfWeekHeight,
      dowPadding: dowPadding ?? this.dowPadding,
    );
  }
}


/// 날짜 셀(오늘, 선택, 이벤트)에 대한 스타일
class CoolCalendarCellStyle {
  /// 오늘 날짜 배경 색
  final Color todayColor;

  /// 선택된 날짜 배경 색
  final Color selectedColor;

  /// 이벤트 날짜 배경 색
  final Color eventColor;

  /// 평일/주말 텍스트 스타일
  final TextStyle weekdayTextStyle;
  final TextStyle weekendTextStyle;

  /// 오늘 날짜 텍스트 스타일
  final TextStyle todayTextStyle;

  /// 선택된 날짜 텍스트 스타일
  final TextStyle selectedDayTextStyle;

  /// 셀 높이(각 날짜 rowHeight)
  final double rowHeight;

  /// 모서리 둥글림
  final double borderRadius;

  /// TableCalendar의 outsideDaysVisible, tableBorder 등등도 이곳에서 관리 가능

  /// (추가) 날짜 셀 내부 margin
  final EdgeInsets cellMargin;

  const CoolCalendarCellStyle({
    this.todayColor = const Color(0xffd3d3d3),
    this.selectedColor = const Color(0xff005bbf),
    this.eventColor = const Color(0xff99ccff),
    this.weekdayTextStyle = const TextStyle(color: Colors.black),
    this.weekendTextStyle = const TextStyle(color: Colors.red),
    this.todayTextStyle = const TextStyle(color: Colors.black),
    this.selectedDayTextStyle = const TextStyle(color: Colors.white),
    this.rowHeight = 48.0,
    this.borderRadius = 4.0,

    /// (추가) 기본값은 좌우 0
    this.cellMargin = const EdgeInsets.all(0),
  });

  CoolCalendarCellStyle copyWith({
    Color? todayColor,
    Color? selectedColor,
    Color? eventColor,
    TextStyle? weekdayTextStyle,
    TextStyle? weekendTextStyle,
    TextStyle? todayTextStyle,
    TextStyle? selectedDayTextStyle,
    double? rowHeight,
    double? borderRadius,
    EdgeInsets? cellMargin,
  }) {
    return CoolCalendarCellStyle(
      todayColor: todayColor ?? this.todayColor,
      selectedColor: selectedColor ?? this.selectedColor,
      eventColor: eventColor ?? this.eventColor,
      weekdayTextStyle: weekdayTextStyle ?? this.weekdayTextStyle,
      weekendTextStyle: weekendTextStyle ?? this.weekendTextStyle,
      todayTextStyle: todayTextStyle ?? this.todayTextStyle,
      selectedDayTextStyle: selectedDayTextStyle ?? this.selectedDayTextStyle,
      rowHeight: rowHeight ?? this.rowHeight,
      borderRadius: borderRadius ?? this.borderRadius,
      cellMargin: cellMargin ?? this.cellMargin,
    );
  }
}
