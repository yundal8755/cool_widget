import 'package:cool_widget/presentation/components/search_bar/cool_search_bar.dart';
import 'package:flutter/material.dart';

class SearchBarPage extends StatelessWidget {
  const SearchBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Search Bar")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // (1) Outline 모드로 사용
            CoolSearchBar(
              hintText: "검색어를 입력해주세요.",
              useUnderline: false, // 여기서 false면 getOutlineDecoration
              controller: searchController,
            ),
            const SizedBox(height: 24),

            // (2) Underline 모드로 사용
            const CoolSearchBar(
              hintText: "검색어를 입력해주세요.",
              useUnderline: true, // true면 getUnderlineDecoration
            ),
          ],
        ),
      ),
    );
  }
}
