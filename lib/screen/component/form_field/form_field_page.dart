import 'package:cool_widget/app/widget/component/form_field/cool_form_field_style.dart';
import 'package:cool_widget/app/widget/component/form_field/cool_form_field_widget.dart';
import 'package:cool_widget/app/widget/component/snack_bar/cool_snackbar_widget.dart';
import 'package:cool_widget/screen/component/form_field/form_field_view_model.dart';
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
        title: const Text('FormField'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            /// 이메일
            CoolFormField(
              hintText: '이메일 입력',
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: viewModel.emailValidator,
              decoration: CoolFormFieldStyle.outlineStyle(
                  label: 'Email', hint: '이메일 입력'),
            ),
            const Gap(20),

            /// 숫자 입력
            CoolFormField(
              isNumber: true,
              hintText: '숫자만 입력',
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: viewModel.numberValidator,
              boxDecoration: CoolFormFieldStyle.boxShadowDecoration(),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
              ),
            ),
            const Gap(20),

            /// 비밀번호 입력
            CoolFormField(
              hintText: '비밀번호 입력',
              isObscureToggle: true,
              obscureTextInitially: true,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: viewModel.passwordValidator,
              decoration: CoolFormFieldStyle.outlineStyle(
                  label: 'Password', hint: '비밀번호 입력'),
            ),
            const Gap(20),

            /// 메시지 전송
            CoolFormField(
              hintText: '메시지 입력 후 전송',
              isSend: true,
              isSendButtonEnabled: true,
              onSend: () => debugPrint('SEND 버튼 눌림'),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: viewModel.messageValidator,
              decoration: CoolFormFieldStyle.underlineStyle(
                label: 'Message',
              ),
            ),
            const Gap(20),

            ElevatedButton(
              onPressed: () =>
                  CoolSnackbar.show(context: context, message: '모든 입력이 유효합니다!'),
              child: const Text('검증하기'),
            )
          ],
        ),
      ),
    );
  }
}
