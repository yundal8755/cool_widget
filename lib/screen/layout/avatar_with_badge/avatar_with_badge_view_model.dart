import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AvatarWithBadgeViewModel {
  final State state; // State 객체 (예: StatefulWidget의 State)

  String? imageUrl;
  File? localFile;

  AvatarWithBadgeViewModel(this.state);

  /// 갤러리에서 이미지를 선택
  Future<void> pickImage() async {
    final picker = ImagePicker();
    final XFile? xfile = await picker.pickImage(source: ImageSource.gallery);
    if (xfile != null) {
      // 파일을 ViewModel의 localFile 프로퍼티로 저장
      localFile = File(xfile.path);
      imageUrl = null; // 만약 기존에 네트워크 이미지가 있었다면 무효화
    }
  }
}
