import 'package:cool_widget/presentation/components/spinner/cool_date_spinner.dart';
import 'package:cool_widget/presentation/components/spinner/cool_date_time_spinner_style.dart';
import 'package:cool_widget/presentation/components/spinner/cool_time_spinner.dart';
import 'package:flutter/material.dart';

class SpinnerPage extends StatefulWidget {
  const SpinnerPage({super.key});

  @override
  State<SpinnerPage> createState() => _SpinnerPageState();
}

class _SpinnerPageState extends State<SpinnerPage> {
  DateTime _selectedSpinnerDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Spinner Demo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // (1) Date Spinner
            Text("Date Spinner: $_selectedSpinnerDate"),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () async {
                // 예시로 스타일을 하나 만들어 전달
                final customStyle = CoolDateTimeSpinnerStyle(
                  pickerHeight: 250,
                  itemExtent: 48,
                  itemTextStyle:
                      const TextStyle(fontSize: 18, color: Colors.blue),
                  titleTextStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange),
                  closeIcon: const Icon(Icons.close, color: Colors.red),
                  backgroundDecoration:
                      BoxDecoration(color: Colors.grey.shade50),
                  confirmButtonStyle: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  confirmButtonTextStyle:
                      const TextStyle(fontSize: 16, color: Colors.white),
                );

                await showDateSpinnerSheet(
                  context: context,
                  initialDate: _selectedSpinnerDate,
                  onConfirm: (newDate) {
                    setState(() {
                      _selectedSpinnerDate = newDate;
                    });
                  },
                  style: customStyle,
                  minYear: 2000,
                  maxYear: 2100,
                );
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text("날짜 스피너 열기"),
              ),
            ),

            const SizedBox(height: 40),

            // (2) Time Spinner
            Text("Time Spinner: ${_selectedTime.hour}:${_selectedTime.minute}"),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () async {
                // 다른 스타일 (간단히)
                const timeStyle = CoolDateTimeSpinnerStyle(
                  itemTextStyle: TextStyle(fontSize: 20, color: Colors.purple),
                  titleTextStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                );
                await showTimeSpinnerSheet(
                  context: context,
                  initialTime: _selectedTime,
                  onConfirm: (newTime) {
                    setState(() {
                      _selectedTime = newTime;
                    });
                  },
                  style: timeStyle,
                );
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text("시간 스피너 열기"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Date BottomSheet
Future<void> showDateSpinnerSheet({
  required BuildContext context,
  required DateTime initialDate,
  required ValueChanged<DateTime> onConfirm,
  CoolDateTimeSpinnerStyle style = const CoolDateTimeSpinnerStyle(),
  int minYear = 1900,
  int maxYear = 2100,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent, // 투명 배경
    builder: (ctx) {
      // 배경이 투명하므로, 내부에서 Container decoration 사용 가능
      return Container(
        margin: const EdgeInsets.only(top: 24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: CoolDateSpinner(
          initialDate: initialDate,
          onConfirm: onConfirm,
          minYear: minYear,
          maxYear: maxYear,
          style: style, // 받아온 style 주입
        ),
      );
    },
  );
}

// Time BottomSheet
Future<void> showTimeSpinnerSheet({
  required BuildContext context,
  required TimeOfDay initialTime,
  required ValueChanged<TimeOfDay> onConfirm,
  CoolDateTimeSpinnerStyle style = const CoolDateTimeSpinnerStyle(),
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (ctx) {
      return Container(
        margin: const EdgeInsets.only(top: 24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: CoolTimeSpinner(
          initialTime: initialTime,
          onConfirm: onConfirm,
          style: style,
        ),
      );
    },
  );
}
