import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'cool_search_bar_style.dart';

enum CoolSearchBarStatus {
  inactive,
  active,
  typing,
}

class CoolSearchBar extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String hintText;
  final bool isReadOnly;
  final bool autofocus;

  /// true면 Underline 스타일, false면 Outline 스타일
  final bool useUnderline;

  const CoolSearchBar({
    super.key,
    this.controller,
    this.focusNode,
    this.hintText = "",
    this.isReadOnly = false,
    this.autofocus = false,
    this.useUnderline = false,
  });

  @override
  State<CoolSearchBar> createState() => _CoolSearchBarState();
}

class _CoolSearchBarState extends State<CoolSearchBar> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();

    // Controller 세팅
    _controller = widget.controller ?? TextEditingController();
    // FocusNode 세팅
    _focusNode = widget.focusNode ?? FocusNode();

    // 포커스 리스너 등록
    _focusNode.addListener(_handleFocusChange);

    // 초기 상태 업데이트
    _updateStatus(_controller.text, _focusNode.hasFocus);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  // 포커스 여부 바뀔 때 상태 갱신
  void _handleFocusChange() {
    _updateStatus(_controller.text, _focusNode.hasFocus);
  }

  // 텍스트 변경 시 상태 갱신
  void _onTextChanged(String text) {
    _updateStatus(text, _focusNode.hasFocus);
  }

  // 포커스 및 텍스트 유무에 따른 상태 업데이트
  void _updateStatus(String text, bool hasFocus) {
    if (text.isEmpty) {
    } else {}
    setState(() {}); // UI 갱신
  }

  // 'X' 아이콘 클릭 시 텍스트 지움
  void _clearText() {
    _controller.clear();
    _updateStatus('', _focusNode.hasFocus);
  }

  @override
  Widget build(BuildContext context) {
    final bool isFocused = _focusNode.hasFocus;
    final bool hasText = _controller.text.isNotEmpty;

    // suffixIcon 설정: 텍스트 있으면 'X' 아이콘 노출
    Widget? suffixIcon;
    if (hasText) {
      suffixIcon = CupertinoButton(
        minSize: 0,
        padding: EdgeInsets.zero,
        onPressed: _clearText,
        child: const Icon(Icons.clear, size: 20),
      );
    }

    // Underline vs Outline
    final InputDecoration effectiveDecoration = widget.useUnderline
        ? CoolSearchBarStyle.getUnderlineDecoration(
            isFocused: isFocused,
            hintText: widget.hintText,
            suffixIcon: suffixIcon,
            prefixIcon: const Icon(CupertinoIcons.search, size: 20),
          )
        : CoolSearchBarStyle.getOutlineDecoration(
            isFocused: isFocused,
            hintText: widget.hintText,
            suffixIcon: suffixIcon,
            prefixIcon: const Icon(CupertinoIcons.search, size: 20),
          );

    // 포커스면 초록색, 아니면 회색
    final Color cursorColor = isFocused
        ? CoolSearchBarStyle.activeColor
        : CoolSearchBarStyle.inactiveColor;

    return TextField(
      controller: _controller,
      focusNode: _focusNode,
      readOnly: widget.isReadOnly,
      autofocus: widget.autofocus,
      cursorColor: cursorColor,
      decoration: effectiveDecoration,
      onChanged: _onTextChanged,
    );
  }
}
