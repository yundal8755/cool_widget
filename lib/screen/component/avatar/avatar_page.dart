import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cool_widget/app/widget/component/avatar/cool_avatar_style.dart';
import 'package:cool_widget/app/widget/component/avatar/cool_avatar_widget.dart';
import 'package:cool_widget/core/constants/assets.dart';
import 'package:cool_widget/screen/component/avatar/avatar_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AvatarPage extends StatefulWidget {
  const AvatarPage({super.key});

  @override
  State<AvatarPage> createState() => _AvatarPageState();
}

class _AvatarPageState extends State<AvatarPage> {
  late AvatarViewModel viewModel;

  @override
  void initState() {
    viewModel = AvatarViewModel(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Avatar")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CoolAvatar.circle(child: _buildImage(imageUrl: viewModel.imageUrl)),
            const SizedBox(height: 48),
            CoolAvatar.rectangle(),
            const SizedBox(height: 48),
            CoolAvatar.rectangle(
              style: const RectangleAvatarStyle(
                  shape: AvatarShape.rectangle,
                  width: 80,
                  height: 40,
                  backgroundColor: Colors.red),
            ),
          ],
        ),
      ),
    );
  }

  /// 이미지
  Widget _buildImage({File? localFile, String? imageUrl}) {
    final defaultAsset = SvgPicture.asset(Assets.defaultLogoIcon);

    // 로컬 이미지
    if (localFile != null) {
      return Image.file(localFile, fit: BoxFit.cover);
    }
    // 네트워크 이미지
    else if (imageUrl != null && imageUrl.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        placeholder: (_, __) =>
            const Center(child: CircularProgressIndicator()),
        errorWidget: (_, __, ___) => defaultAsset,
      );
    }
    // 기본 이미지
    else {
      return defaultAsset;
    }
  }
}
