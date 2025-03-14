import 'package:flutter/material.dart';

enum AlertSize {
  small,
  medium,
  large,
  extraLarge,
}

/// AlertSize를 실제 px 혹은 화면 비율로 변환하는 함수
double mapAlertHeight(AlertSize size, BuildContext context) {
  final screenHeight = MediaQuery.of(context).size.height;

  switch (size) {
    case AlertSize.small:
      return 200;
    case AlertSize.medium:
      return 300;
    case AlertSize.large:
      return 400;
    case AlertSize.extraLarge:
      // 예: 화면의 80% 정도 차지
      return screenHeight * 0.8;
  }
}
