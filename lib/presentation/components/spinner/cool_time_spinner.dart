import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'cool_date_time_spinner_style.dart';

class CoolTimeSpinner extends StatefulWidget {
  final TimeOfDay initialTime;
  final ValueChanged<TimeOfDay> onConfirm;
  final VoidCallback? onCancel;

  /// 스피너 타이틀
  final String title;

  /// 스타일
  final CoolDateTimeSpinnerStyle style;

  const CoolTimeSpinner({
    super.key,
    required this.initialTime,
    required this.onConfirm,
    this.onCancel,
    this.title = "시간 선택",
    this.style = const CoolDateTimeSpinnerStyle(),
  });

  @override
  State<CoolTimeSpinner> createState() => _CoolTimeSpinnerState();
}

class _CoolTimeSpinnerState extends State<CoolTimeSpinner> {
  late int _selectedHour;
  late int _selectedMinute;

  @override
  void initState() {
    super.initState();
    _selectedHour = widget.initialTime.hour;
    _selectedMinute = widget.initialTime.minute;
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style;

    return Container(
      decoration: style.backgroundDecoration,
      padding: style.contentPadding,
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // (1) 상단 Bar
            SizedBox(
              height: style.topBarHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 48),
                  Text(widget.title, style: style.titleTextStyle),
                  IconButton(
                    icon: style.closeIcon,
                    onPressed: widget.onCancel ?? () => Navigator.pop(context),
                  ),
                ],
              ),
            ),

            // (2) 2중 Picker (시/분)
            SizedBox(
              height: style.pickerHeight,
              child: Row(
                children: [
                  Expanded(child: _buildHourPicker(style)),
                  Expanded(child: _buildMinutePicker(style)),
                ],
              ),
            ),

            // (3) 버튼
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ElevatedButton(
                style: style.confirmButtonStyle,
                onPressed: _onConfirm,
                child: Text("확인", style: style.confirmButtonTextStyle),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHourPicker(CoolDateTimeSpinnerStyle style) {
    return CupertinoPicker(
      scrollController: FixedExtentScrollController(initialItem: _selectedHour),
      itemExtent: style.itemExtent,
      onSelectedItemChanged: (index) {
        setState(() {
          _selectedHour = index;
        });
      },
      children: List.generate(24, (idx) {
        return Center(child: Text("${idx.toString().padLeft(2, '0')}시", style: style.itemTextStyle));
      }),
    );
  }

  Widget _buildMinutePicker(CoolDateTimeSpinnerStyle style) {
    return CupertinoPicker(
      scrollController: FixedExtentScrollController(initialItem: _selectedMinute),
      itemExtent: style.itemExtent,
      onSelectedItemChanged: (index) {
        setState(() {
          _selectedMinute = index;
        });
      },
      children: List.generate(60, (idx) {
        return Center(child: Text("${idx.toString().padLeft(2, '0')}분", style: style.itemTextStyle));
      }),
    );
  }

  void _onConfirm() {
    Navigator.pop(context);
    widget.onConfirm(TimeOfDay(hour: _selectedHour, minute: _selectedMinute));
  }
}
