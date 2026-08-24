import 'package:flutter/material.dart';
import 'package:my_boxy_ds/components/buttons/mb_pill_btn.dart';
import 'package:my_boxy_ds/components/buttons/mb_play_pause_btn.dart';
import 'package:my_boxy_ds/components/caroussels/mb_carousel_progress_dot.dart';
import 'package:my_boxy_ds/ui/mb_design_tokens.dart';

class MBMainProductCarouselItem {
  final String id;
  final String imageUrl;

  const MBMainProductCarouselItem({required this.id, required this.imageUrl});
}

class MBMainProductCarouselTag {
  final String id;
  final String label;
  final Widget? icon;

  const MBMainProductCarouselTag({
    required this.id,
    required this.label,
    this.icon,
  });
}

const _defaultItems = [
  MBMainProductCarouselItem(
    id: 'default-1',
    imageUrl:
        'https://images.unsplash.com/photo-1485955900006-10f4d324d411?q=80&w=1200&auto=format&fit=crop',
  ),
  MBMainProductCarouselItem(
    id: 'default-2',
    imageUrl:
        'https://images.unsplash.com/photo-1465146344425-f00d5f5c8f07?q=80&w=1200&auto=format&fit=crop',
  ),
  MBMainProductCarouselItem(
    id: 'default-3',
    imageUrl:
        'https://images.unsplash.com/photo-1470246973918-29a93221c455?q=80&w=1200&auto=format&fit=crop',
  ),
];

class MBMainProductCarousel extends StatefulWidget {
  final List<MBMainProductCarouselItem>? items;
  final String? title;
  final String? subtitle;
  final Duration autoPlayDuration;
  final List<MBPillBtn>? tags;
  final double height;

  const MBMainProductCarousel({
    super.key,
    this.items = _defaultItems,
    this.title,
    this.subtitle,
    this.autoPlayDuration = const Duration(milliseconds: 5000),
    this.tags,
    this.height = 360,
  });

  @override
  State<MBMainProductCarousel> createState() => _MBMainProductCarouselState();
}

class _MBMainProductCarouselState extends State<MBMainProductCarousel>
    with SingleTickerProviderStateMixin {
  late final List<MBMainProductCarouselItem> _items =
    ((widget.items != null && widget.items!.isNotEmpty)
        ? widget.items! : _defaultItems).take(5).toList();

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
                  bottom: 12, right: 12,
                  child: MBPlayPauseButton(
                    isPlaying: _isPlaying,
                    onPressed: _togglePlayPause,
                  ),
                ),
                if (widget.tags != null && widget.tags!.isNotEmpty)
                  Positioned(
                    bottom: 12, left: 14,
                    child: Row(
                      children: [
                        for (final tag in widget.tags!) ...[
                          MBPillBtn(
                            text: tag.text, 
                            color: Colors.white,
                            textColor: AppColors.primaryDark,
                            borderColor: Colors.transparent,
                            onPressed: tag.onPressed
                          ),
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
                  MBCarouselProgressDot(
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