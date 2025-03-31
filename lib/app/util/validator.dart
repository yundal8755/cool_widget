class Validator {
  var kWhiteSpaceRegex = RegExp(r"\s");
  var kSpecialCharRegex = RegExp(r"[^\u3131-\u3163\uac00-\ud7a3a-zA-Z0-9]");

  /// 이메일
  static bool isValidEmail(String input) {
    if (input.isEmpty || input.length > 31) return false;

    RegExp pattern =
        RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+$");
    return pattern.hasMatch(input);
  }

  /// 닉네임
  static bool isValidNickname(String input) {
    if (input.isEmpty || input.length > 16) return false;

    RegExp pattern = RegExp(r"^[\u3131-\u3163\uac00-\ud7a3a-zA-Z0-9]+$");
    return pattern.hasMatch(input);
  }

  /// 비밀번호
  static bool validPasswordPattern(String input) {
    if (input.isEmpty || input.length > 31) return false;

    RegExp pattern = RegExp(
        r'^(?=.*[a-z])(?=.*\d)(?=.*[$@$!%*#?~^<>,.&+=])[A-Za-z\d$@$!%*#?~^<>,.&+=]{8,20}$');
    return pattern.hasMatch(input);
  }

  /// 휴대폰
  static bool isValidPasswordNumber(String input) {
    RegExp pattern = RegExp(r'^[0-9]{6}$');

    return pattern.hasMatch(input);
  }

  /// 휴대폰
  static bool isValidPhone(String input) {
    RegExp pattern = RegExp(r'^01(?:0|1|[6-9])\d{8}$');

    return pattern.hasMatch(input);
  }
}
