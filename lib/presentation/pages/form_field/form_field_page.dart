import 'package:cool_widget/presentation/components/form_field/cool_form_field_widget.dart';
import 'package:cool_widget/presentation/components/snack_bar/cool_snackbar_widget.dart';
import 'package:cool_widget/presentation/pages/form_field/form_field_view_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class FormFieldPage extends StatefulWidget {
  const FormFieldPage({super.key});

  @override
  State<FormFieldPage> createState() => _FormFieldPageState();
}

class _FormFieldPageState extends State<FormFieldPage> {
  late FormFieldViewModel viewModel;

  @override
  void initState() {
    viewModel = FormFieldViewModel(this);
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Field'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            /// 이메일
            CoolFormField(
              label: '이메일',
              hintText: '이메일',
              validator: viewModel.emailValidator,
              visualType: CoolFormFieldVisualType.outline,
            ),
            const Gap(20),

            /// 숫자 입력
            CoolFormField(
              label: '휴대폰 번호',
              isNumber: true,
              hintText: '휴대폰 번호',
              validator: viewModel.numberValidator,
              visualType: CoolFormFieldVisualType.outline,
            ),
            const Gap(20),

            /// 비밀번호 입력
            CoolFormField(
              label: '비밀번호',
              hintText: '비밀번호',
              isObscure: true,
              obscureTextInitially: true,
              validator: viewModel.passwordValidator,
              visualType: CoolFormFieldVisualType.outline,
            ),
            const Gap(20),

            /// 메시지 전송
            CoolFormField(
              label: '메시지',
              hintText: '메시지',
              isSend: true,
              isSendButtonEnabled: true,
              onSend: () => debugPrint('SEND 버튼 눌림'),
              validator: viewModel.messageValidator,
              visualType: CoolFormFieldVisualType.outline,
            ),
            const Gap(20),

            ElevatedButton(
              onPressed: () {
                // 폼 전체 검증
                final isValid = _formKey.currentState?.validate() ?? false;
                if (isValid) {
                  CoolSnackbar.show(context: context, message: '모든 입력이 유효합니다!');
                }
              },
              child: const Text('검증하기'),
            ),
          ],
        ),
      ),
    );
  }
}
