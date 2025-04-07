import 'package:cool_widget/app/style/app_color.dart';
import 'package:cool_widget/app/style/app_text_style.dart';
import 'package:flutter/material.dart';

/// CoolToggleGroup
///
/// - 세그먼트처럼 2~4개의 라벨을 수평 배치해 선택
/// - 선택된 인덱스의 하이라이트(Selector)가 슬라이딩 애니메이션으로 이동
/// - 하위 영역은 AnimatedSwitcher + IndexedStack으로 “선택된 탭”의 내용을 표시
///
class CoolToggleGroup extends StatefulWidget {
  /// 토글 버튼에 표시될 라벨 텍스트 목록 (2~4개)
  final List<String> labels;

  /// 각 라벨 선택 시, 보여줄 위젯(탭) 목록
  final List<Widget> children;

  /// 초기 선택 인덱스 (기본값 0)
  final int initialIndex;

  /// 인덱스 변경 콜백
  final ValueChanged<int>? onChanged;

  /// 세그먼트 컨트롤(버튼 영역)의 높이
  final double height;

  /// 바탕색 (비활성 영역)
  final Color backgroundColor;

  /// 하이라이트 색상 (활성 영역)
  final Color highlightColor;

  /// 버튼 테두리 색
  final Color borderColor;

  /// 배경 영역(border)의 모서리 둥글기(기본은 height/2).
  final double? backgroundBorderRadius;

  /// 전체 너비를 라벨 개수만큼 균등 분배할지 여부 (기본 true)
  /// - true: 각 세그먼트가 동일 너비
  /// - false: 라벨 텍스트 길이에 따라 크기가 달라질 수 있음
  final bool expandEqual;

  const CoolToggleGroup({
    super.key,
    required this.labels,
    required this.children,
    this.initialIndex = 0,
    this.onChanged,
    this.height = 48.0,
    this.backgroundColor = const Color(0xFFEDEDEF), // 예시
    this.highlightColor = Colors.white, // 예시
    this.borderColor = const Color(0xFFE0E0E0), // 예시
    this.backgroundBorderRadius,
    this.expandEqual = true,
  }) : assert(labels.length == children.length,
            'labels.length와 children.length가 일치해야 합니다.');

  @override
  State<CoolToggleGroup> createState() => _CoolToggleGroupState();
}

class _CoolToggleGroupState extends State<CoolToggleGroup> {
  late int _currentIndex;

  // Lazy 로딩을 위한 “방문 여부” 맵
  late Map<int, bool> _visited;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;

    _visited = {
      for (int i = 0; i < widget.children.length; i++) i: (i == _currentIndex),
    };
  }

  void _onTap(int index) {
    if (_currentIndex == index) return; // 같은 인덱스면 무시

    setState(() {
      _currentIndex = index;
      _visited[index] = true;
    });
    widget.onChanged?.call(index);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 상단의 “슬라이딩 하이라이트” 토글 버튼 영역
        _buildSegmentedControl(context),

        const SizedBox(height: 16),

        // 하단의 “선택된 탭 내용” 영역
        _buildChildContent(),
      ],
    );
  }

  Widget _buildSegmentedControl(BuildContext context) {
    final itemCount = widget.labels.length;

    // 배경 영역의 radius를 지정(기본은 widget.height/2)
    final double bgRadius =
        widget.backgroundBorderRadius ?? (widget.height / 2);

    // LayoutBuilder로 전체 넓이를 측정 -> 선택 인덱스에 따른 이동 애니메이션 계산
    return LayoutBuilder(
      builder: (context, constraints) {
        double totalWidth = constraints.maxWidth;
        if (totalWidth == double.infinity) {
          // 혹시나 부모가 무제한 너비를 줄 수도 있으므로, 방어적으로
          totalWidth = MediaQuery.of(context).size.width;
        }

        // 세그먼트(각 버튼)의 너비
        final segmentWidth = totalWidth / itemCount;

        // highlight 영역의 margin (4px)
        // 높이/너비에서 8을 빼면, 각 방향으로 4px씩 여백
        final double highlightLeft = _currentIndex * segmentWidth + 4;
        final double highlightWidth = segmentWidth - 8;
        final double highlightHeight = widget.height - 8;

        return SizedBox(
          height: widget.height,
          child: Stack(
            children: [
              /// 1) 배경 영역 (둥근 테두리, 배경색)
              Container(
                width: totalWidth,
                height: widget.height,
                decoration: BoxDecoration(
                  color: widget.backgroundColor,
                  borderRadius: BorderRadius.circular(bgRadius),
                  border: Border.all(color: widget.borderColor),
                ),
              ),

              /// 2) 하이라이트 영역 (선택된 버튼 뒤로 애니메이션 이동 + 그림자)
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,

                // 위/왼쪽 위치
                top: 4,
                left: highlightLeft,

                // 크기
                height: highlightHeight,
                width: highlightWidth,

                child: Container(
                  decoration: BoxDecoration(
                    color: AppColor.gray020,
                    borderRadius: BorderRadius.circular(bgRadius),
                    boxShadow: [
                      // (1) 그림자 추가
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      )
                    ],
                  ),
                ),
              ),

              /// 3) 버튼들(텍스트), 클릭 시 _onTap
              Row(
                children: List.generate(itemCount, (index) {
                  final label = widget.labels[index];
                  final isSelected = (index == _currentIndex);

                  return InkWell(
                    onTap: () => _onTap(index),
                    borderRadius: BorderRadius.circular(bgRadius),
                    child: Container(
                      width: segmentWidth,
                      alignment: Alignment.center,
                      height: widget.height,
                      child: AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 200),
                        style: isSelected
                            ? AppTextStyle.body1.copyWith(color: AppColor.black)
                            : AppTextStyle.body2
                                .copyWith(color: AppColor.gray060),
                        child: Text(label),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildChildContent() {
    // 하단의 탭 내용: Lazy 로딩 + AnimatedSwitcher
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      transitionBuilder: (child, animation) {
        // Fade + 살짝의 scale(옵션)
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.97, end: 1.0).animate(animation),
            child: child,
          ),
        );
      },
      child: IndexedStack(
        key: ValueKey<int>(_currentIndex), // AnimatedSwitcher를 위해 key 사용
        index: _currentIndex,
        children: List.generate(widget.children.length, (i) {
          // 아직 방문 안 한 인덱스는 SizedBox.shrink()
          if (_visited[i] == true) {
            return widget.children[i];
          } else {
            return const SizedBox.shrink();
          }
        }),
      ),
    );
  }
}
