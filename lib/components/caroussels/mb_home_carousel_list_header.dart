import 'package:flutter/material.dart';
import 'package:my_boxy_ds/components/cards/mb_user_home_carousel_card.dart';
import 'package:my_boxy_ds/components/caroussels/mb_carousel_progress_dot.dart';

const double _sidePeekPercent = 0.1;
const double _cardHeight = 240;
const double _cardGap = 8;
const Duration _defaultAutoPlayDuration = Duration(milliseconds: 4500);

class MBHomeCarouselItem {
  final String id;
  final String? title;
  final String imageUrl;
  final String? storeImageUrl;
  final String? storeName;
  final double? rating;
  final VoidCallback? onPressed;

  const MBHomeCarouselItem({
    required this.id,
    this.title,
    required this.imageUrl,
    this.storeImageUrl,
    this.storeName,
    this.rating,
    this.onPressed,
  });
}

class MBHomeCarouselListHeader extends StatefulWidget {
  final List<MBHomeCarouselItem>? items;
  final Duration autoPlayDuration;
  final ValueChanged<MBHomeCarouselItem>? onPressItem;

  const MBHomeCarouselListHeader({
    super.key,
    this.items,
    this.autoPlayDuration = _defaultAutoPlayDuration,
    this.onPressItem,
  });

  @override
  State<MBHomeCarouselListHeader> createState() =>
      _MBHomeCarouselListHeaderState();
}

class _MBHomeCarouselListHeaderState extends State<MBHomeCarouselListHeader>
    with SingleTickerProviderStateMixin {
  late final List<MBHomeCarouselItem> _sourceItems = (widget.items ?? const [])
      .take(8)
      .toList();

  late final int _loopLength = _sourceItems.length;
  late final int _middleStartIndex = _loopLength > 1 ? _loopLength : 0;

  late final double _screenWidth = _resolveScreenWidth();
  late final double _cardWidth = _screenWidth * (1.05 - _sidePeekPercent * 2);
  late final double _snapInterval = _cardWidth + _cardGap;
  late final double _viewportFraction = _screenWidth == 0
      ? 1
      : _snapInterval / _screenWidth;

  late final PageController _pageController = PageController(
    viewportFraction: _viewportFraction,
    initialPage: _middleStartIndex,
  );
  late final AnimationController _progressController =
      AnimationController(vsync: this, duration: widget.autoPlayDuration)
        ..addStatusListener(_handleProgressStatus);

  int _activeIndex = 0;
  int _virtualIndex = 0;
  double _pausedProgress = 0;

  static double _resolveScreenWidth() {
    final view = WidgetsBinding.instance.platformDispatcher.views.first;
    return view.physicalSize.width / view.devicePixelRatio;
  }

  @override
  void initState() {
    super.initState();
    _virtualIndex = _middleStartIndex;
    _startTimer();
  }

  @override
  void dispose() {
    _progressController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _stopTimer() => _progressController.stop();

  void _handleProgressStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _goToVirtualIndex(_virtualIndex + 1);
    }
  }

  void _startTimer({bool resumeFromPause = false}) {
    if (_loopLength <= 1) return;
    _stopTimer();
    final fromProgress = resumeFromPause ? _pausedProgress : 0.0;
    final totalMs = widget.autoPlayDuration.inMilliseconds;
    final remainingMs = resumeFromPause
        ? (totalMs * (1 - fromProgress)).round().clamp(100, totalMs)
        : totalMs;
    _progressController
      ..duration = Duration(milliseconds: remainingMs)
      ..value = fromProgress
      ..forward();
  }

  void _syncActiveFromVirtual(int nextVirtualIndex) {
    if (_loopLength == 0) return;
    final nextActive =
        ((nextVirtualIndex % _loopLength) + _loopLength) % _loopLength;
    setState(() => _activeIndex = nextActive);
  }

  void _goToVirtualIndex(int nextVirtualIndex, {bool animated = true}) {
    if (_sourceItems.isEmpty) return;
    if (animated) {
      _pageController.animateToPage(
        nextVirtualIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    } else {
      _pageController.jumpToPage(nextVirtualIndex);
    }
    _virtualIndex = nextVirtualIndex;
    _syncActiveFromVirtual(nextVirtualIndex);
    _pausedProgress = 0;
    _progressController.value = 0;
  }

  void _goToLogicalIndex(int index, {bool animated = true}) {
    if (_loopLength == 0) return;
    final normalizedIndex = ((index % _loopLength) + _loopLength) % _loopLength;
    final targetVirtualIndex = _loopLength > 1
        ? _loopLength + normalizedIndex
        : normalizedIndex;
    _goToVirtualIndex(targetVirtualIndex, animated: animated);
  }

  int _normalizeVirtualIndex(int index) {
    if (_loopLength <= 1) return index;
    if (index < _loopLength) return index + _loopLength;
    if (index >= _loopLength * 2) return index - _loopLength;
    return index;
  }

  void _handlePageChanged(int rawIndex) {
    final normalizedIndex = _normalizeVirtualIndex(rawIndex);
    if (normalizedIndex != rawIndex) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _pageController.jumpToPage(normalizedIndex);
      });
    }
    _virtualIndex = normalizedIndex;
    _syncActiveFromVirtual(normalizedIndex);
    _pausedProgress = 0;
    _progressController.value = 0;
    if (_loopLength > 1) {
      _startTimer();
    }
  }

  void _handlePressItem(MBHomeCarouselItem item) {
    widget.onPressItem?.call(item);
  }

  @override
  Widget build(BuildContext context) {
    if (_sourceItems.isEmpty) return const SizedBox.shrink();

    final itemCount = _loopLength <= 1 ? _loopLength : _loopLength * 3;

    return Column(
      children: [
        SizedBox(
          height: _cardHeight,
          child: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is ScrollStartNotification &&
                  notification.dragDetails != null) {
                _pausedProgress = _progressController.value;
                _stopTimer();
              }
              return false;
            },
            child: PageView.builder(
              controller: _pageController,
              itemCount: itemCount,
              onPageChanged: _handlePageChanged,
              itemBuilder: (context, index) {
                final item = _sourceItems[index % _loopLength];
                return MBUserHomeCarouselCard(
                  item: item,
                  gap: _cardGap,
                  onPressed: () => _handlePressItem(item),
                );
              },
            ),
          ),
        ),
        if (_sourceItems.length > 1)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < _sourceItems.length; i++) ...[
                  MBCarouselProgressDot(
                    active: i == _activeIndex,
                    progress: _progressController,
                    onPressed: () => _goToLogicalIndex(i),
                  ),
                  if (i != _sourceItems.length - 1) const SizedBox(width: 6),
                ],
              ],
            ),
          ),
      ],
    );
  }
}
