import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// validator로 에러 메시지 반환
typedef KeycoValidator = String? Function(String? value);

class CoolFormField extends FormField<String> {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool isNumber;
  final bool isObscureToggle; // 비밀번호 가리기/보기

  // suffix 부분 - 메시지 전송 버튼 등
  final bool isSend;
  final bool isSendButtonEnabled;
  final VoidCallback? onSend;

  // 스타일
  final InputDecoration? decoration;
  final BoxDecoration? boxDecoration;

  final bool isReadOnly;
  final String hintText;
  final int? maxLength;
  final bool autofocus;
  final List<TextInputFormatter>? customInputFormatters;
  final TextInputType? customKeyboardType;
  final bool obscureTextInitially;

  CoolFormField({
    super.key,
    // FormField 기본 속성
    String? initialValue,
    super.validator,
    super.onSaved,
    AutovalidateMode super.autovalidateMode = AutovalidateMode.disabled,

    // 커스텀 속성
    this.controller,
    this.focusNode,
    this.isNumber = false,
    this.isObscureToggle = false,
    this.isSend = false,
    this.isSendButtonEnabled = false,
    this.onSend,
    this.decoration,
    this.boxDecoration,
    this.isReadOnly = false,
    this.hintText = '',
    this.maxLength,
    this.autofocus = false,
    this.customInputFormatters,
    this.customKeyboardType,
    this.obscureTextInitially = false, // 초기에 obscure를 true로 할지?
  }) : super(
          initialValue:
              controller != null ? controller.text : (initialValue ?? ''),
          builder: (FormFieldState<String> field) {
            final _KeycoUnifiedFormFieldState state =
                field as _KeycoUnifiedFormFieldState;

            /// suffix 아이콘 (비밀번호 토글 or Send 버튼)
            Widget? suffixWidget;
            if (state.widget.isObscureToggle) {
              suffixWidget = CupertinoButton(
                minSize: 0,
                padding: EdgeInsets.zero,
                onPressed: state.toggleObscure,
                child: Icon(
                  state._obscureText ? Icons.visibility_off : Icons.visibility,
                  size: 20,
                ),
              );
            } else if (state.widget.isSend) {
              suffixWidget = CupertinoButton(
                minSize: 0,
                padding: const EdgeInsets.only(right: 8),
                onPressed: state.widget.isSendButtonEnabled
                    ? state.widget.onSend
                    : null,
                child: Text(
                  'Send',
                  style: TextStyle(
                    color: state.widget.isSendButtonEnabled
                        ? Colors.blue
                        : Colors.grey,
                  ),
                ),
              );
            }

            /// 기본/커스텀 InputDecoration
            /// - 만약 decoration이 null이 아니면, 그걸 그대로 복사해서 suffixIcon/ hintText / errorText만 덮어씌우는 방법
            final effectiveDecoration =
                (state.widget.decoration ?? const InputDecoration()).copyWith(
              hintText: state.widget.hintText.isNotEmpty
                  ? state.widget.hintText
                  : null,
              suffixIcon: suffixWidget,
              errorText: field.errorText, // FormField의 에러 메시지 연동
            );

            /// Material이나 Cupertino 디자인에 얽매이지 않고, 추가로 Container 레벨에서
            /// boxDecoration을 적용할 수도 있음 (그림자, 곡률 등)
            return Container(
              decoration: state.widget.boxDecoration,
              child: TextField(
                controller: state._effectiveController,
                focusNode: state._effectiveFocusNode,
                // 숫자 입력 vs 일반 텍스트
                keyboardType: state.effectiveKeyboardType,
                // 숫자만 입력 or 커스텀 포맷터
                inputFormatters: state.effectiveInputFormatters,
                maxLength: state.widget.maxLength,
                readOnly: state.widget.isReadOnly,
                obscureText: state._obscureText,
                autofocus: state.widget.autofocus,
                decoration: effectiveDecoration,
                onChanged: (value) {
                  field.didChange(value);
                },
              ),
            );
          },
        );

  @override
  FormFieldState<String> createState() => _KeycoUnifiedFormFieldState();
}

class _KeycoUnifiedFormFieldState extends FormFieldState<String> {
  TextEditingController? _controller;
  FocusNode? _focusNode;
  bool _obscureText = false; // 비밀번호 토글용

  @override
  CoolFormField get widget => super.widget as CoolFormField;

  TextEditingController get _effectiveController =>
      widget.controller ?? _controller!;
  FocusNode get _effectiveFocusNode => widget.focusNode ?? _focusNode!;

  /// isNumber=true일 때의 기본 키보드 타입 / inputFormatter
  TextInputType get defaultNumberKeyboard => TextInputType.number;
  List<TextInputFormatter> get defaultNumberFormatter =>
      [FilteringTextInputFormatter.digitsOnly];

  /// 최종적으로 적용될 keyboardType
  TextInputType get effectiveKeyboardType {
    if (widget.customKeyboardType != null) {
      return widget.customKeyboardType!;
    } else if (widget.isNumber) {
      return defaultNumberKeyboard;
    } else {
      return TextInputType.text;
    }
  }

  /// 최종적으로 적용될 inputFormatter
  List<TextInputFormatter>? get effectiveInputFormatters {
    if (widget.customInputFormatters != null &&
        widget.customInputFormatters!.isNotEmpty) {
      return widget.customInputFormatters;
    } else if (widget.isNumber) {
      return defaultNumberFormatter;
    }
    return null; // null이면 기본 제한 없음
  }

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = TextEditingController(text: widget.initialValue);
    } else {
      widget.controller!.text = widget.initialValue ?? '';
    }

    if (widget.focusNode == null) {
      _focusNode = FocusNode();
    }

    // 초기 비밀번호 모드
    _obscureText = widget.obscureTextInitially;
  }

  // 비밀번호 보기/숨기기
  void toggleObscure() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void didChange(String? value) {
    super.didChange(value);
    // FormFieldState가 바뀔 때 컨트롤러 동기화
    if (_effectiveController.text != value) {
      _effectiveController.text = value ?? '';
    }
  }

  @override
  void didUpdateWidget(covariant CoolFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue &&
        widget.initialValue != value) {
      setValue(widget.initialValue);
      if (_effectiveController.text != widget.initialValue) {
        _effectiveController.text = widget.initialValue ?? '';
      }
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller?.dispose();
    }
    if (widget.focusNode == null) {
      _focusNode?.dispose();
    }
    super.dispose();
  }
}
