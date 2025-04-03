import 'package:cool_widget/presentation/components/alert_dialog/cool_alert_dialog.dart';
import 'package:flutter/material.dart';

class AlertDialogViewModel extends ChangeNotifier {
  State state;
  AlertDialogViewModel(this.state);

  /// 단일 확인 버튼
  void showSingleConfirmDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => CoolAlertDialog.singleBtn(
        title: "",
        subTitle: "아이디 또는 비밀번호를 다시 확인해주세요.",
        btnContent: "확인",
        onBtnClicked: () {
          Navigator.of(context).pop(); // 확인 버튼 클릭 시 닫기
        },
      ),
    );
  }

  /// 확인, 취소 버튼
  void showConfirmCancelDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => CoolAlertDialog.dividedBtn(
        title: "계정 복구",
        subTitle: "탈퇴한 계정입니다.\n계정을 복구하시겠습니까?",
        leftBtnContent: "취소",
        rightBtnContent: "확인",
        onLeftBtnClicked: () {
          Navigator.of(context).pop(); // 취소 버튼 클릭 시 닫기
        },
        onRightBtnClicked: () {
          Navigator.of(context).pop(); // 확인 버튼 클릭 시 닫기
        },
      ),
    );
  }
}
