import 'package:cool_widget/app/util/validator.dart';
import 'package:flutter/material.dart';

class FormFieldViewModel extends ChangeNotifier {
  State state;
  FormFieldViewModel(this.state);

  /// 이메일 검증 로직
  FormFieldValidator<String> get emailValidator => (value) {
    if (value == null || value.isEmpty) {
      return '이메일을 입력하세요.';
    }
    if (!Validator.isValidEmail(value)) {
      return '이메일 형식이 올바르지 않습니다.';
    }
    return null;
  };

  /// 숫자 검증 로직
  FormFieldValidator<String> get numberValidator => (value) {
    if (value == null || value.isEmpty) {
      return '숫자를 입력하세요.';
    }
    final numericValue = int.parse(value);
    if (numericValue < 10) {
      return '값은 10 이상이어야 합니다.';
    }
    return null;
  };

  /// 비밀번호 검증 로직
  FormFieldValidator<String> get passwordValidator => (value) {
    if (value == null || value.length < 6) {
      return '비밀번호는 6자 이상이어야 합니다.';
    }
    return null;
  };

  /// 메시지 전송 검증(예시)
  FormFieldValidator<String> get messageValidator => (value) {
    // 간단히 비어있는지만 체크
    if (value == null || value.isEmpty) {
      return '메시지를 입력해주세요.';
    }
    return null;
  };

}
