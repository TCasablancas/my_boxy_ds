import 'package:flutter/material.dart';
import 'package:my_boxy_ds/components/buttons/mb_play_pause_btn.dart';

class MBMainHomeCarouselItem {
  final String id;
  final String imageUrl;

  const MBMainHomeCarouselItem({required this.id, required this.imageUrl});
}

class MBMainHomeCarouselTag {
  final String id;
  final String label;
  final Widget? icon;

  const MBMainHomeCarouselTag({
    required this.id,
    required this.label,
    this.icon,
  });
}

const _defaultItems = [
  MBMainHomeCarouselItem(
    id: 'default-1',
    imageUrl:
        'https://images.unsplash.com/photo-1485955900006-10f4d324d411?q=80&w=1200&auto=format&fit=crop',
  ),
  MBMainHomeCarouselItem(
    id: 'default-2',
    imageUrl:
        'https://images.unsplash.com/photo-1465146344425-f00d5f5c8f07?q=80&w=1200&auto=format&fit=crop',
  ),
  MBMainHomeCarouselItem(
    id: 'default-3',
    imageUrl:
        'https://images.unsplash.com/photo-1470246973918-29a93221c455?q=80&w=1200&auto=format&fit=crop',
  ),
];

class MBMainHomeCarousel extends StatefulWidget {
  final List<MBMainHomeCarouselItem>? items;
  final String? title;
  final String? subtitle;
  final Duration autoPlayDuration;
  final List<MBMainHomeCarouselTag>? tags;
  final double height;

  const MBMainHomeCarousel({
    super.key,
    this.items = _defaultItems,
    this.title,
    this.subtitle,
    this.autoPlayDuration = const Duration(milliseconds: 5000),
    this.tags,
    this.height = 360,
  });

  @override
  State<MBMainHomeCarousel> createState() => _MBMainHomeCarouselState();
}

class _MBMainHomeCarouselState extends State<MBMainHomeCarousel>
    with SingleTickerProviderStateMixin {
  late final List<MBMainHomeCarouselItem> _items =
      ((widget.items != null && widget.items!.isNotEmpty)
              ? widget.items!
              : _defaultItems)
          .take(5)
          .toList();

  final PageController _pageController = PageController();
  late final AnimationController _progressController = AnimationController(
    vsync: this,
    duration: widget.autoPlayDuration,
  )..addStatusListener(_handleProgressStatus);

  int _activeIndex = 0;
  bool _isPlaying = true;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _progressController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _handleProgressStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed && _isPlaying) {
      _goToNext();
    }
  }

  void _startTimer({bool resumeFromPause = false}) {
    if (!_isPlaying || _items.length <= 1) return;
    final fromValue = resumeFromPause ? _progressController.value : 0.0;
    final totalMs = widget.autoPlayDuration.inMilliseconds;
    final remainingMs = resumeFromPause
        ? (totalMs * (1 - fromValue)).round().clamp(100, totalMs)
        : totalMs;
    _progressController
      ..duration = Duration(milliseconds: remainingMs)
      ..value = fromValue
      ..forward();
  }

  void _stopTimer() => _progressController.stop();

  void _goToIndex(int index, {bool animated = true}) {
    if (_items.isEmpty) return;
    final nextIndex =
        ((index % _items.length) + _items.length) % _items.length;
    if (animated) {
      _pageController.animateToPage(
        nextIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    } else {
      _pageController.jumpToPage(nextIndex);
    }
    _resetProgressForIndex(nextIndex);
  }

  void _goToNext() => _goToIndex(_activeIndex + 1);

  void _resetProgressForIndex(int index) {
    setState(() => _activeIndex = index);
    _progressController
      ..duration = widget.autoPlayDuration
      ..value = 0;
    _startTimer();
  }

  void _togglePlayPause() {
    if (_isPlaying) {
      _stopTimer();
      setState(() => _isPlaying = false);
    } else {
      setState(() => _isPlaying = true);
      _startTimer(resumeFromPause: true);
    }
  }

  void _openZoom(String imageUri) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      barrierColor: const Color.fromRGBO(0, 0, 0, 0.95),
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, animation, secondaryAnimation) {
        return SafeArea(
          child: Stack(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Image.network(imageUri, fit: BoxFit.contain),
                ),
              ),
              Positioned(
                top: 52,
                right: 16,
                child: IconButton(
                  icon: const Icon(
                    Icons.cancel,
                    color: Colors.white,
                    size: 34,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_items.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: widget.height,
          child: ClipRect(
            child: Stack(
              children: [
                NotificationListener<ScrollNotification>(
                  onNotification: (notification) {
                    if (notification is ScrollStartNotification &&
                        notification.dragDetails != null) {
                      _stopTimer();
                    }
                    return false;
                  },
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _items.length,
                    onPageChanged: _resetProgressForIndex,
                    itemBuilder: (context, index) {
                      final item = _items[index];
                      return GestureDetector(
                        onTap: () => _openZoom(item.imageUrl),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(item.imageUrl, fit: BoxFit.cover),
                            Container(
                              color: const Color.fromRGBO(0, 0, 0, 0.2),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                if (widget.title != null || widget.subtitle != null)
                  Positioned(
                    top: 14,
                    left: 14,
                    right: 90,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (widget.title != null)
                          Text(
                            widget.title!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        if (widget.subtitle != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              widget.subtitle!,
                              style: const TextStyle(
                                color: Color(0xFFF1F1F1),
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                Positioned(
                  bottom: 12,
                  right: 12,
                  child: MBPlayPauseButton(
                    isPlaying: _isPlaying,
                    onPressed: _togglePlayPause,
                  ),
                ),
                if (widget.tags != null && widget.tags!.isNotEmpty)
                  Positioned(
                    bottom: 12,
                    left: 14,
                    right: 90,
                    child: Row(
                      children: [
                        for (final tag in widget.tags!) ...[
                          _MBCarouselTagChip(tag: tag),
                          const SizedBox(width: 8),
                        ],
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
        if (_items.length > 1)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < _items.length; i++) ...[
                  _MBProgressDot(
                    active: i == _activeIndex,
                    progress: _progressController,
                    onPressed: () => _goToIndex(i),
                  ),
                  if (i != _items.length - 1) const SizedBox(width: 6),
                ],
              ],
            ),
          ),
      ],
    );
  }
}

class _MBProgressDot extends StatelessWidget {
  static const double _height = 4;
  static const double _inactiveWidth = 8;
  static const double _activeWidth = 44;

  final bool active;
  final Animation<double> progress;
  final VoidCallback onPressed;

  const _MBProgressDot({
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

class _MBCarouselTagChip extends StatelessWidget {
  final MBMainHomeCarouselTag tag;

  const _MBCarouselTagChip({required this.tag});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.8,
      child: Container(
        height: 24,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (tag.icon != null)
              Container(
                width: 18,
                height: 18,
                margin: const EdgeInsets.only(right: 4),
                decoration: const BoxDecoration(
                  color: Color(0xFF333333),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: tag.icon,
              ),
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Text(
                tag.label,
                style: const TextStyle(
                  fontSize: 12,
                  letterSpacing: -0.5,
                  color: Color(0xFF333333),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
