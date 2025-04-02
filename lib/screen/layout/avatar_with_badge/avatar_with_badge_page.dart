import 'package:cool_widget/app/widget/component/avatar/cool_avatar_widget.dart';
import 'package:cool_widget/app/widget/component/badge/cool_badge_style.dart';
import 'package:cool_widget/app/widget/component/badge/cool_badge_widget.dart';
import 'package:cool_widget/screen/layout/avatar_with_badge/avatar_with_badge_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

class AvatarWithBadgePage extends StatefulWidget {
  const AvatarWithBadgePage({super.key});

  @override
  State<AvatarWithBadgePage> createState() => _AvatarWithBadgePageState();
}

class _AvatarWithBadgePageState extends State<AvatarWithBadgePage> {
  late AvatarWithBadgeViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = AvatarWithBadgeViewModel(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Avatar With Badge")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _profileEditImage(),
          ],
        ),
      ),
    );
  }

  /// 프로필 사진 편집 위젯
  /// 커스텀 위젯으로 새로 생성 가능
  Widget _profileEditImage() {
    return Bounceable(
      onTap: () async {
        await viewModel.pickImage();
        setState(() {});
      },
      child: SizedBox(
        width: 92,
        height: 92,
        child: Stack(
          children: [
            Center(
              child: CoolAvatar.circle(child: _buildImage()),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: CoolBadge.circle(
                style: CircleBadgeStyle(
                  radius: 36,
                  backgroundColor: Colors.blue,
                  contentPadding: const EdgeInsets.all(1),
                ),
                child: const Icon(Icons.image),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    // 1) 로컬 파일
    if (viewModel.localFile != null) {
      return Image.file(viewModel.localFile!, fit: BoxFit.cover);
    }
    // 2) 네트워크 이미지
    else if (viewModel.imageUrl != null && viewModel.imageUrl!.isNotEmpty) {
      return Image.network(viewModel.imageUrl!, fit: BoxFit.cover);
    }
    // 3) 기본 아이콘 or SizedBox
    else {
      return const Icon(Icons.person); // 혹은 SizedBox.shrink()
    }
  }
}
