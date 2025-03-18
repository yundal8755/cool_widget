import 'package:cool_widget/app/widget/component/text_field/cool_text_field_widget.dart';
import 'package:cool_widget/screen/component/text_field/text_field_view_model.dart';
import 'package:flutter/material.dart';

class TextFieldPage extends StatefulWidget {
  const TextFieldPage({super.key});

  @override
  State<TextFieldPage> createState() => _TextFieldPageState();
}

class _TextFieldPageState extends State<TextFieldPage> {
  late TextFieldPageViewModel viewModel;

  @override
  void initState() {
    viewModel = TextFieldPageViewModel(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Text Field")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            const SizedBox(height: 48),

            // 검색창
            CoolTextField(
              leadingIcon: const Icon(Icons.search),
              trailingIcons: const [
                Icon(Icons.clear),
                Icon(Icons.mic),
              ],
              onChanged: (value) => debugPrint('검색어: $value'),
            ),
          ],
        ),
      ),
    );
  }
}
