import 'package:cool_widget/presentation/components/switch/cool_switch.dart';
import 'package:flutter/material.dart';

class SwitchPage extends StatefulWidget {
  const SwitchPage({super.key});

  @override
  State<SwitchPage> createState() => _SwitchPageState();
}

class _SwitchPageState extends State<SwitchPage> {
  bool status1 = false;
  bool status2 = true;
  bool status3 = false;
  bool status4 = false;
  bool statusDisabled = true;
  bool statusHaptic = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cool Switch'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // ──────────────────────────────────────────────────────────────
            // 1) 기본 사이즈 / ON-OFF 텍스트 노출
            // ──────────────────────────────────────────────────────────────
            Row(
              children: [
                const Text('1) 기본 스위치 (ON/OFF 텍스트)'),
                const Spacer(),
                CoolSwitch(
                  value: status1,
                  showOnOff: true,
                  onToggle: (val) {
                    setState(() {
                      status1 = val;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),

            // ──────────────────────────────────────────────────────────────
            // 2) 크기 확장 + 색상 커스텀 + 초기값 true
            // ──────────────────────────────────────────────────────────────
            Row(
              children: [
                const Text('2) 확장 스위치 (활성 상태)'),
                const Spacer(),
                CoolSwitch(
                  value: status2,
                  width: 80,
                  height: 40,
                  activeColor: Colors.redAccent,
                  inactiveColor: Colors.black26,
                  showOnOff: true,
                  onToggle: (val) {
                    setState(() {
                      status2 = val;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),

            // ──────────────────────────────────────────────────────────────
            // 3) 아이콘 사용
            // ──────────────────────────────────────────────────────────────
            Row(
              children: [
                const Text('3) 아이콘 스위치'),
                const Spacer(),
                CoolSwitch(
                  value: status3,
                  activeIcon: const Icon(Icons.check, size: 16),
                  inactiveIcon: const Icon(Icons.close, size: 16),
                  onToggle: (val) {
                    setState(() {
                      status3 = val;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),

            // ──────────────────────────────────────────────────────────────
            // 4) 토글 크기 크게 + Toggle Border 커스텀
            // ──────────────────────────────────────────────────────────────
            Row(
              children: [
                const Text('4) 토글 크게 + 테두리'),
                const Spacer(),
                CoolSwitch(
                  value: status4,
                  width: 70,
                  height: 35,
                  toggleSize: 30, // 토글을 키움
                  showOnOff: true,
                  toggleBorder: Border.all(color: Colors.blue, width: 1),
                  onToggle: (val) {
                    setState(() {
                      status4 = val;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),

            // ──────────────────────────────────────────────────────────────
            // 5) 비활성화(disabled) 스위치
            // ──────────────────────────────────────────────────────────────
            Row(
              children: [
                const Text('5) 비활성화 스위치'),
                const Spacer(),
                CoolSwitch(
                  value: statusDisabled,
                  disabled: true, // 스위치가 탭돼도 바뀌지 않음
                  onToggle: (val) {
                    // disabled 상태이므로 onToggle이 호출되어도 값 변경X
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),

            // ──────────────────────────────────────────────────────────────
            // 6) 햅틱 스위치
            // ──────────────────────────────────────────────────────────────
            Row(
              children: [
                const Text('6) 햅틱 스위치 (진동)'),
                const Spacer(),
                CoolSwitch(
                  value: statusHaptic,
                  useHaptic: true, // 토글 시 진동
                  onToggle: (val) {
                    setState(() {
                      statusHaptic = val;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
