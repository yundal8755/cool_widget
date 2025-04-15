import 'package:cool_widget/presentation/components/drawer/cool_drawer_style.dart';
import 'package:flutter/material.dart';

enum DrawerSide { left, right }

class CoolDrawer extends StatelessWidget {
  /// 왼쪽(left) 또는 오른쪽(right) Drawer로 열릴 위치를 정한다.
  final DrawerSide drawerSide;

  /// Drawer의 상단에 들어갈 영역(예: 유저 정보, 프로필 사진, 메뉴 타이틀 등).
  final Widget? header;

  /// Drawer의 하단에 들어갈 영역(예: 앱 버전, 로그아웃 버튼, 저작권 안내 등).
  final Widget? footer;

  /// Drawer 내부에 표시할 주요 콘텐츠 목록.
  /// ListTile 뿐만 아니라 아무 위젯이나 넣어 확장성 있게 활용 가능.
  final List<Widget> bodyItems;

  /// Drawer에 반드시 들어가야 한다고 생각하는 기본 기능 예시:
  /// - 닫기(닫기 버튼을 누르거나 바깥을 누르면 닫힐 수 있도록)
  /// - 스크롤 지원 (항상 스크롤 가능하도록 ListView나 SingleChildScrollView 사용)
  /// - 적절한 너비 설정 (컨텐츠를 담기에 적당한 너비)
  /// - Material 디자인(또는 커스텀 디자인) 적용
  ///
  /// 여기서는 closeButton을 통해 간단한 닫기 기능을 보여준다.
  final bool showCloseButton;
  final VoidCallback? onClosePressed;

  /// Drawer 스타일(너비, 배경색, 모서리 둥글림, 그림자 등)을 담는 클래스
  final CoolDrawerStyle style;

  const CoolDrawer({
    super.key,
    this.drawerSide = DrawerSide.left,
    this.header,
    this.footer,
    this.bodyItems = const [],
    this.showCloseButton = true,
    this.onClosePressed,

    /// 기본 값이 적용된 스타일
    this.style = const CoolDrawerStyle(),
  });

  @override
  Widget build(BuildContext context) {
    // DrawerSide에 따라 정렬(Scaffold에서 실제로는 drawer나 endDrawer에 넣겠지만,
    // 이 안에서 정렬을 컨트롤할 수도 있다)
    final alignment = drawerSide == DrawerSide.left
        ? Alignment.centerLeft
        : Alignment.centerRight;

    return Align(
      alignment: alignment,
      // Material 디자인의 Drawer 모양을 그대로 쓰면서 안쪽을 커스텀
      child: Container(
        width: style.width, // 스타일에서 설정한 너비
        decoration: style.decoration ??
            BoxDecoration(
              color: style.backgroundColor,
              borderRadius: style.borderRadius > 0
                  ? BorderRadius.circular(style.borderRadius)
                  : null,
              boxShadow: style.boxShadows,
            ),
        child: Drawer(
          elevation: 0, // Container에서 쉐도우를 관리하므로 Drawer의 elevation을 0으로
          child: SafeArea(
            child: Column(
              children: [
                // (1) Header 영역
                if (header != null) header!,
                // (2) 닫기 버튼
                if (showCloseButton)
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: onClosePressed ??
                          () {
                            Navigator.of(context).pop();
                          },
                    ),
                  ),
                // (3) bodyItems를 스크롤 가능하게 표시
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: bodyItems,
                    ),
                  ),
                ),
                // (4) Footer 영역
                if (footer != null) footer!,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
