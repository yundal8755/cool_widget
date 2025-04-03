import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // for HapticFeedback

import 'package:cool_widget/app/style/app_color.dart';
import 'package:cool_widget/app/style/app_text_style.dart';

/// CoolSwitch
///
/// - [value] : 스위치 ON/OFF 상태
/// - [onToggle] : 스위치를 탭했을 때 호출되는 콜백
/// - [activeColor] / [inactiveColor] : 켜짐/꺼짐 시 배경색
/// - [toggleColor] : 토글(원형) 기본 색상
/// - [width], [height] : 전체 크기
/// - [toggleSize] : 토글(원형) 크기(활성 상태)
/// - [disabledToggleSize] : 비활성 상태일 때 토글(원형) 크기 (작아짐)
/// - [duration] : ON/OFF 애니메이션 시간
/// - [useHaptic] : 탭 시 진동 여부
/// - 기타 FlutterSwitch와 유사한 속성들
///
class CoolSwitch extends StatefulWidget {
  const CoolSwitch({
    super.key,
    required this.value,
    required this.onToggle,
    this.activeColor = AppColor.green,
    this.inactiveColor = Colors.grey,
    this.activeTextColor = Colors.white70,
    this.inactiveTextColor = Colors.white70,
    this.toggleColor = Colors.white,
    this.activeToggleColor,
    this.inactiveToggleColor,
    this.width = 64.0,
    this.height = 35.0,
    this.toggleSize = 25.0,
    this.disabledToggleSize = 18.0,
    this.valueFontSize = 16.0,
    this.borderRadius = 20.0,
    this.padding = 4.0,
    this.showOnOff = false,
    this.activeText,
    this.inactiveText,
    this.activeTextFontWeight,
    this.inactiveTextFontWeight,
    this.switchBorder,
    this.activeSwitchBorder,
    this.inactiveSwitchBorder,
    this.toggleBorder,
    this.activeToggleBorder,
    this.inactiveToggleBorder,
    this.activeIcon,
    this.inactiveIcon,
    this.duration = const Duration(milliseconds: 200),
    this.disabled = false,
    this.useHaptic = false,
  })  : assert(
          (switchBorder == null || activeSwitchBorder == null) &&
              (switchBorder == null || inactiveSwitchBorder == null),
          'Cannot provide switchBorder when an activeSwitchBorder or inactiveSwitchBorder was given.\n'
          'To give the switch a border, use "activeSwitchBorder" or "inactiveSwitchBorder".',
        ),
        assert(
          (toggleBorder == null || activeToggleBorder == null) &&
              (toggleBorder == null || inactiveToggleBorder == null),
          'Cannot provide toggleBorder when an activeToggleBorder or inactiveToggleBorder was given.\n'
          'To give the toggle a border, use "activeToggleBorder" or "inactiveToggleBorder".',
        );

  /// ON/OFF 상태
  final bool value;

  /// 탭 시, 새 상태(!value)를 전달하는 콜백
  final ValueChanged<bool> onToggle;

  /// 스위치에 ON/OFF 텍스트를 표시할지 여부
  final bool showOnOff;

  /// ON 상태일 때 표시할 텍스트 (showOnOff=true 시)
  final String? activeText;

  /// OFF 상태일 때 표시할 텍스트 (showOnOff=true 시)
  final String? inactiveText;

  /// 스위치가 ON일 때 배경색
  final Color activeColor;

  /// 스위치가 OFF일 때 배경색
  final Color inactiveColor;

  /// ON 텍스트 색
  final Color activeTextColor;

  /// OFF 텍스트 색
  final Color inactiveTextColor;

  /// ON 텍스트 폰트 두께
  final FontWeight? activeTextFontWeight;

  /// OFF 텍스트 폰트 두께
  final FontWeight? inactiveTextFontWeight;

  /// 기본 토글 색상(ON/OFF 공통)
  final Color toggleColor;

  /// ON일 때 토글 색상
  final Color? activeToggleColor;

  /// OFF일 때 토글 색상
  final Color? inactiveToggleColor;

  /// 스위치 전체 너비
  final double width;

  /// 스위치 전체 높이
  final double height;

  /// 활성화 시 토글(원형) 크기
  final double toggleSize;

  /// 비활성화 시 토글(원형) 크기
  final double disabledToggleSize;

  /// ON/OFF 텍스트 폰트 크기
  final double valueFontSize;

  /// 모서리 둥근 정도
  final double borderRadius;

  /// 스위치 내부 여백
  final double padding;

  /// 스위치의 전체 경계선
  final BoxBorder? switchBorder;

  /// ON 시 스위치 경계선
  final BoxBorder? activeSwitchBorder;

  /// OFF 시 스위치 경계선
  final BoxBorder? inactiveSwitchBorder;

  /// 토글의 경계선
  final BoxBorder? toggleBorder;

  /// ON 시 토글 경계선
  final BoxBorder? activeToggleBorder;

  /// OFF 시 토글 경계선
  final BoxBorder? inactiveToggleBorder;

  /// ON 시 토글 내부 아이콘(문자, 이미지 등)
  final Widget? activeIcon;

  /// OFF 시 토글 내부 아이콘(문자, 이미지 등)
  final Widget? inactiveIcon;

  /// ON/OFF 애니메이션 시간
  final Duration duration;

  /// 스위치 활성/비활성
  final bool disabled;

  /// 토글을 눌렀을 때 햅틱 진동을 사용할지 여부
  final bool useHaptic;

  @override
  CoolSwitchState createState() => CoolSwitchState();
}

class CoolSwitchState extends State<CoolSwitch>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<Alignment> _toggleAnimation;

  // 비활성화 시 토글 크기 축소용
  late final AnimationController _disabledSizeController;
  late final Animation<double> _disabledSizeAnimation;

  @override
  void initState() {
    super.initState();

    // ---------- (1) ON/OFF 위치 이동 애니메이션 ----------
    _animationController = AnimationController(
      vsync: this,
      value: widget.value ? 1.0 : 0.0, // 초기 위치
      duration: widget.duration,
    );

    _toggleAnimation = AlignmentTween(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
      ),
    );

    // ---------- (2) 비활성화 시 토글 크기 변경 애니메이션 ----------
    _disabledSizeController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    // Tween: disabledSize (end) ←→ enabledSize (begin)
    _disabledSizeAnimation = Tween<double>(
      begin: widget.toggleSize,
      end: widget.disabledToggleSize,
    ).animate(
      CurvedAnimation(
        parent: _disabledSizeController,
        curve: Curves.easeInOut,
      ),
    );

    // 만약 시작부터 disabled=true라면 토글이 작아진 상태로 시작
    if (widget.disabled) {
      _disabledSizeController.value = 1.0;
    } else {
      _disabledSizeController.value = 0.0;
    }
  }

  @override
  void didUpdateWidget(covariant CoolSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);

    // (A) 스위치 ON/OFF 애니메이션
    if (oldWidget.value != widget.value) {
      if (widget.value) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }

    // (B) disabled 여부가 바뀌면 토글 크기 애니메이션
    if (oldWidget.disabled != widget.disabled) {
      if (widget.disabled) {
        _disabledSizeController.forward(); // 작아짐
      } else {
        _disabledSizeController.reverse(); // 커짐
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _disabledSizeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ON/OFF일 때 색상이나 border 결정
    final bool isOn = widget.value;

    final Color switchColor = isOn ? widget.activeColor : widget.inactiveColor;
    final Color toggleColor = isOn
        ? (widget.activeToggleColor ?? widget.toggleColor)
        : (widget.inactiveToggleColor ?? widget.toggleColor);

    final Border? switchBorder = (isOn
            ? widget.activeSwitchBorder
            : widget.inactiveSwitchBorder) as Border? ??
        (widget.switchBorder as Border?);

    final Border? toggleBorder = (isOn
            ? widget.activeToggleBorder
            : widget.inactiveToggleBorder) as Border? ??
        (widget.toggleBorder as Border?);

    // 텍스트 영역: (전체너비 - 토글너비)
    // 토글너비는 disabled 상태 시 _disabledSizeAnimation.value로 변경
    final double currentToggleSize = _disabledSizeAnimation.value;
    final double textSpace = widget.width - currentToggleSize;

    return AnimatedBuilder(
      animation:
          Listenable.merge([_animationController, _disabledSizeController]),
      builder: (context, child) {
        return GestureDetector(
          onTap: widget.disabled
              ? null
              : () {
                  // 햅틱 진동 여부
                  if (widget.useHaptic) {
                    HapticFeedback.lightImpact();
                  }

                  // 스위치 상태 토글
                  if (widget.value) {
                    _animationController.forward();
                  } else {
                    _animationController.reverse();
                  }
                  widget.onToggle(!widget.value);
                },
          child: Opacity(
            opacity: widget.disabled ? 0.6 : 1.0,
            child: Container(
              width: widget.width,
              height: widget.height,
              padding: EdgeInsets.all(widget.padding),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                color: switchColor,
                border: switchBorder,
              ),
              child: Stack(
                children: [
                  // (1) ON 텍스트
                  AnimatedOpacity(
                    opacity: isOn ? 1.0 : 0.0,
                    duration: widget.duration,
                    child: Container(
                      width: textSpace,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: _buildActiveText(),
                    ),
                  ),

                  // (2) OFF 텍스트
                  AnimatedOpacity(
                    opacity: isOn ? 0.0 : 1.0,
                    duration: widget.duration,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        width: textSpace,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: _buildInactiveText(),
                      ),
                    ),
                  ),

                  // (3) Toggle(동그라미)
                  Align(
                    alignment: _toggleAnimation.value,
                    child: Container(
                      width: currentToggleSize,
                      height: currentToggleSize,
                      padding: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: toggleColor,
                        border: toggleBorder,
                      ),
                      child: FittedBox(
                        child: Stack(
                          children: [
                            // ON 아이콘
                            AnimatedOpacity(
                              opacity: isOn ? 1.0 : 0.0,
                              duration: widget.duration,
                              child: widget.activeIcon ?? const SizedBox(),
                            ),
                            // OFF 아이콘
                            AnimatedOpacity(
                              opacity: isOn ? 0.0 : 1.0,
                              duration: widget.duration,
                              child: widget.inactiveIcon ?? const SizedBox(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildActiveText() {
    if (!widget.showOnOff) return const SizedBox();
    return Text(
      widget.activeText ?? '',
      style: AppTextStyle.alert2.copyWith(
        color: widget.activeTextColor,
        fontWeight: widget.activeTextFontWeight ?? FontWeight.w900,
        fontSize: widget.valueFontSize,
      ),
    );
  }

  Widget _buildInactiveText() {
    if (!widget.showOnOff) return const SizedBox();
    return Text(
      widget.inactiveText ?? '',
      textAlign: TextAlign.right,
      style: AppTextStyle.alert2.copyWith(
        color: widget.inactiveTextColor,
        fontWeight: widget.inactiveTextFontWeight ?? FontWeight.w900,
        fontSize: widget.valueFontSize,
      ),
    );
  }
}
