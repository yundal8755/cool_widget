import 'package:cool_widget/app/widget/component/text_field/cool_text_field_style.dart';
import 'package:flutter/material.dart';

class CoolTextField extends StatefulWidget {
  final CoolTextFieldStyle style;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  /// 새로 추가
  final Widget? leadingIcon;
  final List<Widget>? trailingIcons;

  CoolTextField({
    super.key,
    TextFieldStyle? style,
    this.controller,
    this.onChanged,
    this.onSubmitted,

    // 새로 추가
    this.leadingIcon,
    this.trailingIcons,
  }) : style = style ?? TextFieldStyle.rectangleDefault;

  @override
  State<CoolTextField> createState() => _CoolTextFieldState();
}

class _CoolTextFieldState extends State<CoolTextField> {
  late FocusNode _focusNode;

  @override
  void initState() {
    debugPrint('init 실행됨');
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    debugPrint('dispose 실행됨');
    _focusNode.dispose();
    super.dispose();
  }

  bool get _isFocused => _focusNode.hasFocus;

  @override
  Widget build(BuildContext context) {
    final style = widget.style;

    final currentBorderColor = _isFocused
        ? (style.focusedBorderColor ?? style.borderColor)
        : style.borderColor;
    final currentBorderWidth = _isFocused
        ? (style.focusedBorderWidth ?? style.borderWidth)
        : style.borderWidth;

    // trailing 아이콘 최대 2개만 사용하기 (옵션)
    final trailingList = widget.trailingIcons ?? [];
    final effectiveTrailing =
        trailingList.length > 2 ? trailingList.sublist(0, 2) : trailingList;

    return Container(
      // height 적용
      height: style.height, // null이면 자식에 맞춰짐, 아니면 고정 높이
      decoration: BoxDecoration(
        color: style.backgroundColor,
        borderRadius: BorderRadius.circular(style.borderRadius ?? 0),
        boxShadow: style.shadow,
        border: Border.all(
          color: currentBorderColor ?? Colors.transparent,
          width: currentBorderWidth ?? 0,
        ),
      ),
      // 기존 padding도 유지
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 왼쪽 아이콘
          if (widget.leadingIcon != null) ...[
            // 4px 패딩
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: widget.leadingIcon,
            ),
          ],

          // TextField는 Expanded로 감싸서 남은 공간 차지
          Expanded(
            child: TextField(
              focusNode: _focusNode,
              controller: widget.controller,
              onChanged: widget.onChanged,
              onSubmitted: widget.onSubmitted,
              style: style.textStyle,
              decoration: InputDecoration(
                hintText: style.hintText,
                hintStyle: style.hintStyle,
                border: InputBorder.none,
                isDense: true,
              ),
              autofocus: false,
            ),
          ),

          // 오른쪽 아이콘들 (최대 2개)
          for (final icon in effectiveTrailing) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: icon,
            ),
          ],
        ],
      ),
    );
  }
}
