import 'dart:async';
import 'package:flutter/material.dart';
import 'cool_carousel_style.dart';
import 'dart:math' as math;

class CoolCarousel extends StatefulWidget {
  /// 실제 슬라이드 목록
  final List<Widget> slides;

  /// 스타일/옵션
  final CoolCarouselStyle style;

  /// 슬라이드 탭 콜백
  final ValueChanged<int>? onSlideTap;

  const CoolCarousel({
    super.key,
    required this.slides,
    this.style = const CoolCarouselStyle(),
    this.onSlideTap,
  });

  @override
  State<CoolCarousel> createState() => _CoolCarouselState();
}

class _CoolCarouselState extends State<CoolCarousel> {
  late PageController _pageController;
  late int _currentIndex;

  Timer? _autoPlayTimer;

  /// 무한 스크롤용 슬라이드 목록 (페이크 앞뒤 추가)
  late List<Widget> _infiniteSlides;
// 실제 slides.length

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    _pageController =
        PageController(viewportFraction: widget.style.viewportFraction);

    if (widget.style.infiniteScroll && widget.slides.isNotEmpty) {
      _setupInfiniteSlides();
      // start index = 1 => 가운데가 실제 첫 슬라이드
      _currentIndex = 1;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_pageController.hasClients) {
          _pageController.jumpToPage(_currentIndex);
        }
      });
    }

    if (widget.style.autoPlay) {
      _startAutoPlayTimer();
    }
  }

  void _setupInfiniteSlides() {
    // [last, slides..., first]
    final first = widget.slides.first;
    final last = widget.slides.last;
    _infiniteSlides = [last, ...widget.slides, first];
  }

  @override
  void dispose() {
    _autoPlayTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoPlayTimer() {
    _autoPlayTimer?.cancel();
    _autoPlayTimer = Timer.periodic(widget.style.autoPlayInterval, (timer) {
      if (!mounted) return;
      final style = widget.style;
      int nextPage = _currentIndex + 1;

      // 무한 스크롤
      if (style.infiniteScroll) {
        if (nextPage >= _infiniteSlides.length) {
          // jump to page=1
          nextPage = 1;
        }
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOut,
        );
      } else {
        // 일반(끝에서 멈추거나 loop)
        if (nextPage >= widget.slides.length) {
          if (style.loop) {
            nextPage = 0;
          } else {
            timer.cancel();
            return;
          }
        }
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  int get _effectiveItemCount => widget.style.infiniteScroll
      ? _infiniteSlides.length
      : widget.slides.length;

  @override
  Widget build(BuildContext context) {
    final style = widget.style;
    return SizedBox(
      height: style.height,
      child: Stack(
        children: [
          // (1) PageView
          PageView.builder(
            controller: _pageController,
            itemCount: _effectiveItemCount,
            onPageChanged: (index) => _onPageChanged(index),
            physics: style.pageSnapping
                ? const PageScrollPhysics()
                : const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
            itemBuilder: (context, index) {
              // 슬라이드
              final child = widget.style.infiniteScroll
                  ? _infiniteSlides[index]
                  : widget.slides[index];

              // 커스텀 트랜스폼
              if (style.usePageTransformer) {
                return AnimatedBuilder(
                  animation: _pageController,
                  builder: (ctx, childWidget) {
                    return _buildTransformedSlide(index, childWidget!);
                  },
                  child: GestureDetector(
                    onTap: () => _handleTap(index),
                    child: child,
                  ),
                );
              } else {
                // 그냥 기본
                return GestureDetector(
                  onTap: () => _handleTap(index),
                  child: child,
                );
              }
            },
          ),

          // (2) 인디케이터
          if (style.showIndicator)
            Positioned.fill(
              child: Align(
                alignment: style.indicatorAlignment,
                child: _buildIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  /// 애니메이션 트랜스폼 (예: Scale / 3D / Rotate)
  Widget _buildTransformedSlide(int index, Widget child) {
    // 현재 스크롤 위치
    double pageOffset = 0;
    try {
      // pageController.page는 double로 현재 offset
      pageOffset =
          _pageController.page ?? _pageController.initialPage.toDouble();
    } catch (_) {
      pageOffset = _currentIndex.toDouble();
    }

    final distance = (index - pageOffset).abs();
    // 예: 거리가 0이면 가운데 슬라이드, distance가 커질수록 축소
    final scale = math.max(0.85, 1 - distance * 0.15);

    // 3D 회전까지 넣어볼 수도 있음
    final angle = distance * 0.3; // 라디안
    final transform = Matrix4.identity()
      ..setEntry(3, 2, 0.001) // perspective
      ..rotateY(angle * (index < pageOffset ? 1 : -1))
      ..scale(scale);

    return Transform(
      transform: transform,
      alignment: Alignment.center,
      child: child,
    );
  }

  void _onPageChanged(int index) {
    _currentIndex = index;

    // 무한 스크롤 보정
    if (widget.style.infiniteScroll) {
      if (_currentIndex == 0) {
        // fake last → jump to real last
        Future.microtask(() {
          _pageController.jumpToPage(_infiniteSlides.length - 2);
        });
        _currentIndex = _infiniteSlides.length - 2;
      } else if (_currentIndex == _infiniteSlides.length - 1) {
        // fake first → jump to page=1
        Future.microtask(() {
          _pageController.jumpToPage(1);
        });
        _currentIndex = 1;
      }
    }

    setState(() {});
  }

  Widget _buildIndicator() {
    final style = widget.style;

    final totalSlides = widget.style.infiniteScroll
        ? widget.slides.length // 실제 슬라이드 수
        : widget.slides.length;

    // 무한 스크롤 시 _currentIndex가 1~n 사이
    // real index = _currentIndex -1
    int realIndex = _currentIndex;
    if (style.infiniteScroll &&
        _currentIndex > 0 &&
        _currentIndex < _infiniteSlides.length - 1) {
      realIndex = _currentIndex - 1;
    } else if (style.infiniteScroll &&
        _currentIndex == _infiniteSlides.length - 1) {
      // 맨 끝(가짜 first)
      realIndex = 0;
    } else if (style.infiniteScroll && _currentIndex == 0) {
      // 맨 앞(가짜 last)
      realIndex = totalSlides - 1;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(totalSlides, (i) {
        final isActive = (i == realIndex);
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: EdgeInsets.all(style.indicatorSpacing / 2),
          width: style.indicatorSize,
          height: style.indicatorSize,
          decoration: BoxDecoration(
            shape: style.indicatorShape,
            color: isActive
                ? style.indicatorActiveColor
                : style.indicatorInactiveColor,
          ),
        );
      }),
    );
  }

  void _handleTap(int index) {
    int realIndex = index;
    if (widget.style.infiniteScroll) {
      // 무한 스크롤이면, 실제 인덱스 보정
      if (index > 0 && index < _infiniteSlides.length - 1) {
        realIndex = index - 1;
      } else if (index == 0) {
        realIndex = widget.slides.length - 1;
      } else if (index == _infiniteSlides.length - 1) {
        realIndex = 0;
      }
    }

    widget.onSlideTap?.call(realIndex);
  }
}
