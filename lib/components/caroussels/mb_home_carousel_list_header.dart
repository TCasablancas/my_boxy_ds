import 'dart:ui';
import 'package:flutter/material.dart';

const double _sidePeekPercent = 0.1;
const double _cardHeight = 240;
const double _cardGap = 8;
const Duration _defaultAutoPlayDuration = Duration(milliseconds: 4500);

class MBHomeCarouselItem {
  final String id;
  final String title;
  final String imageUrl;
  final String? storeImageUrl;
  final String? storeName;
  final int? reviewCount;

  const MBHomeCarouselItem({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.storeImageUrl,
    this.storeName,
    this.reviewCount,
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
                return _MBCarouselCard(
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
                  _MBCarouselProgressDot(
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

class _MBCarouselCard extends StatelessWidget {
  final MBHomeCarouselItem item;
  final double gap;
  final VoidCallback onPressed;

  const _MBCarouselCard({
    required this.item,
    required this.gap,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: gap),
      child: GestureDetector(
        onTap: onPressed,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            color: const Color(0xFFD8D8D8),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  item.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) =>
                      const ColoredBox(color: Color(0xFFD8D8D8)),
                ),
                Container(color: const Color.fromRGBO(0, 0, 0, 0.45)),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _MBStoreBadge(
                            storeImageUrl: item.storeImageUrl ?? '',
                            storeName: item.storeName ?? '',
                          ),
                          const SizedBox(width: 8),
                          _MBRatingBadge(reviewCount: item.reviewCount ?? 12),
                        ],
                      ),
                      _MBCarouselTextBlur(item: item),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MBStoreBadge extends StatelessWidget {
  final String storeImageUrl;
  final String storeName;

  const _MBStoreBadge({required this.storeImageUrl, required this.storeName});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 2, right: 8, top: 2, bottom: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipOval(
            child: Image.network(
              storeImageUrl,
              width: 16,
              height: 16,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) =>
                  const ColoredBox(color: Color(0xFFCCCCCC)),
            ),
          ),
          const SizedBox(width: 4),
          Text(
            storeName,
            style: const TextStyle(
              fontSize: 10,
              fontFamily: 'SFMono',
              letterSpacing: -0.5,
              color: Color(0xFF4C4C4C),
            ),
          ),
        ],
      ),
    );
  }
}

class _MBRatingBadge extends StatelessWidget {
  final int reviewCount;

  const _MBRatingBadge({required this.reviewCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 4, right: 8, top: 2, bottom: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star, size: 16, color: Color(0xFFFBBF24)),
          const SizedBox(width: 2),
          Text(
            '$reviewCount',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Color(0xFF007BFF),
            ),
          ),
        ],
      ),
    );
  }
}

class _MBCarouselTextBlur extends StatelessWidget {
  final MBHomeCarouselItem item;

  const _MBCarouselTextBlur({required this.item});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          color: Colors.white.withValues(alpha: 0.08),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                child: Text(
                  item.title,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFFFBBF24),
                    fontSize: 22,
                    fontFamily: 'SFMono',
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                    height: 1.0,
                    shadows: [
                      Shadow(
                        color: Color.fromRGBO(0, 0, 0, 0.2),
                        offset: Offset(0, 2),
                        blurRadius: 12,
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(12, 0, 12, 8),
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                  style: TextStyle(
                    fontFamily: 'SFMono',
                    letterSpacing: -0.5,
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MBCarouselProgressDot extends StatelessWidget {
  static const double _height = 4;
  static const double _inactiveWidth = 8;
  static const double _activeWidth = 44;

  final bool active;
  final Animation<double> progress;
  final VoidCallback onPressed;

  const _MBCarouselProgressDot({
    required this.active,
    required this.progress,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: active ? _activeWidth : _inactiveWidth,
        height: _height,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: const Color(0xFFE0E0E0),
          borderRadius: BorderRadius.circular(_height / 2),
        ),
        child: active
            ? AnimatedBuilder(
                animation: progress,
                builder: (context, _) => FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: progress.value.clamp(0.0, 1.0),
                  child: const ColoredBox(color: Color(0xFF007AFF)),
                ),
              )
            : null,
      ),
    );
  }
}
