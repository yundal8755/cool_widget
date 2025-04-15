import 'package:cool_widget/presentation/components/accodian/cool_accodian_style.dart';
import 'package:flutter/material.dart';

class CoolAccordion extends StatefulWidget {
  /// 아코디언 헤더 영역(접혀 있을 때 표시되는 부분).
  /// 예: Text("타이틀"), 혹은 Row, ListTile 등 어떤 위젯이든 사용 가능
  final Widget header;

  /// 아코디언 펼침 시 보여줄 콘텐츠(접혔을 때는 숨겨짐).
  final Widget content;

  /// 처음에 펼쳐진 상태로 시작할지 여부
  final bool initiallyExpanded;

  /// 펼치기(Expand) 아이콘
  final IconData expandIcon;

  /// 접기(Collapse) 아이콘
  final IconData collapseIcon;

  /// 아이콘의 색상, 크기 등 세부 스타일링을 입히고 싶다면
  /// IconTheme이나 IconButton 파라미터 등을 활용
  final Color iconColor;
  final double iconSize;

  /// (선택) 헤더를 누르면 펼침/접힘 동작을 할지 결정
  final bool toggleOnHeaderTap;

  /// 펼침/접힘 상태 변경 시 호출되는 콜백
  final ValueChanged<bool>? onExpansionChanged;

  /// 아코디언 전체 스타일
  final CoolAccordionStyle style;

  const CoolAccordion({
    super.key,
    required this.header,
    required this.content,
    this.initiallyExpanded = false,
    this.expandIcon = Icons.keyboard_arrow_down,
    this.collapseIcon = Icons.keyboard_arrow_up,
    this.iconColor = Colors.black54,
    this.iconSize = 24.0,
    this.toggleOnHeaderTap = true,
    this.onExpansionChanged,
    this.style = const CoolAccordionStyle(),
  });

  @override
  State<CoolAccordion> createState() => _CoolAccordionState();
}

class _CoolAccordionState extends State<CoolAccordion>
    with SingleTickerProviderStateMixin {
  late bool _isExpanded;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
    _animationController = AnimationController(
      vsync: this,
      duration: widget.style.animationDuration,
      value: _isExpanded ? 1.0 : 0.0,
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void didUpdateWidget(covariant CoolAccordion oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.style.animationDuration != widget.style.animationDuration) {
      _animationController.duration = widget.style.animationDuration;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
    // 펼침/접힘 상태 콜백
    if (widget.onExpansionChanged != null) {
      widget.onExpansionChanged!(_isExpanded);
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style;

    return Container(
      decoration: style.decoration ??
          BoxDecoration(
            color: style.backgroundColor,
            borderRadius: BorderRadius.circular(style.borderRadius),
            boxShadow: style.boxShadows,
          ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // (1) 헤더 부분
          InkWell(
            onTap: widget.toggleOnHeaderTap ? _toggleExpand : null,
            child: Row(
              children: [
                // 헤더 위젯
                Expanded(child: widget.header),
                // 펼치기/접기 아이콘
                IconButton(
                  onPressed: _toggleExpand,
                  icon: Icon(
                    _isExpanded ? widget.collapseIcon : widget.expandIcon,
                    color: widget.iconColor,
                    size: widget.iconSize,
                  ),
                ),
              ],
            ),
          ),
          // (2) 펼침/접힘 상태의 애니메이션 영역
          SizeTransition(
            sizeFactor: _animation,
            axis: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: widget.content,
            ),
          ),
        ],
      ),
    );
  }
}
