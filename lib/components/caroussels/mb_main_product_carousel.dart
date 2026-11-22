import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:my_boxy_ds/components/buttons/mb_pill_btn.dart';
import 'package:my_boxy_ds/components/buttons/mb_play_pause_btn.dart';
import 'package:my_boxy_ds/components/caroussels/mb_carousel_progress_dot.dart';
import 'package:my_boxy_ds/ui/design_tokens/design_tokens.dart';
import '../buttons/mb_text_btn.dart';
import 'package:video_player/video_player.dart';
import '../containers/mb_box_rounded_container.dart';

/// Tipo de mídia de um item do carrossel (espelha `product_media.media_type`).
enum MBCarouselMediaType { image, video }

class MBMainProductCarouselItem {
  final String id;

  /// URL da imagem ou do vídeo, conforme [type].
  final String url;
  final MBCarouselMediaType type;

  /// Capa do vídeo, mostrada enquanto ele carrega. Ignorada em imagem.
  final String? thumbnailUrl;

  const MBMainProductCarouselItem({
    required this.id,
    required this.url,
    this.type = MBCarouselMediaType.image,
    this.thumbnailUrl,
  });

  bool get isVideo => type == MBCarouselMediaType.video;
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
    url:
        'https://images.unsplash.com/photo-1485955900006-10f4d324d411?q=80&w=1200&auto=format&fit=crop',
  ),
  MBMainProductCarouselItem(
    id: 'default-2',
    url:
        'https://images.unsplash.com/photo-1465146344425-f00d5f5c8f07?q=80&w=1200&auto=format&fit=crop',
  ),
  MBMainProductCarouselItem(
    id: 'default-3',
    url:
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
  // Vídeos que não carregaram: seguem o timer como se fossem imagem
  final Set<String> _failedVideos = {};

  int get _imageCount => _items.where((item) => !item.isVideo).length;
  int get _videoCount => _items.where((item) => item.isVideo).length;

  /// Página de vídeo avança sozinha quando o vídeo termina, não pelo timer.
  bool _drivenByVideo(int index) =>
      _items[index].isVideo && !_failedVideos.contains(_items[index].id);

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
    if (!_isPlaying || _items.length <= 1 || _drivenByVideo(_activeIndex)) return;
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

  void _onVideoProgress(int index, double progress) {
    if (index == _activeIndex) _progressController.value = progress;
  }

  void _onVideoEnded(int index) {
    if (index == _activeIndex && _isPlaying && _items.length > 1) _goToNext();
  }

  void _onVideoFailed(int index) {
    _failedVideos.add(_items[index].id);
    if (index == _activeIndex) _startTimer();
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
                        onTap: item.isVideo
                            ? _togglePlayPause
                            : () => _openZoom(item.url),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            if (item.isVideo)
                              _CarouselVideo(
                                item: item,
                                active: index == _activeIndex,
                                playing: _isPlaying,
                                loop: _items.length <= 1,
                                onProgress: (progress) =>
                                    _onVideoProgress(index, progress),
                                onEnded: () => _onVideoEnded(index),
                                onFailed: () => _onVideoFailed(index),
                              )
                            else
                              Image.network(item.url, fit: BoxFit.cover),
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
                Positioned(
                  top: 12, right: 12,
                  child: MBBoxRoundedContainer(
                    background: AppColors.grey900.withAlpha(180),
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          Expanded(
                              child: MBTextButton(
                                icon: LucideIcons.image,
                                title: '$_imageCount',
                                textColor: AppColors.grey400,
                                onPressed: (){},
                                horizontalAlign: .center,
                              )
                          ),
                          Expanded(
                              child: MBTextButton(
                                icon: LucideIcons.video,
                                title: '$_videoCount',
                                textColor: AppColors.grey400,
                                onPressed: (){},
                                horizontalAlign: .center,
                              )
                          )
                        ],
                      ),
                    )
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
/// Página de vídeo do carrossel: mostra a capa até o vídeo começar a tocar.
/// Só carrega quando a página está ativa; toca mudo e pausa ao sair dela.
class _CarouselVideo extends StatefulWidget {
  const _CarouselVideo({
    required this.item,
    required this.active,
    required this.playing,
    required this.loop,
    required this.onProgress,
    required this.onEnded,
    required this.onFailed,
  });

  final MBMainProductCarouselItem item;
  final bool active;
  final bool playing;
  final bool loop;
  final ValueChanged<double> onProgress;
  final VoidCallback onEnded;
  final VoidCallback onFailed;

  @override
  State<_CarouselVideo> createState() => _CarouselVideoState();
}

class _CarouselVideoState extends State<_CarouselVideo> {
  VideoPlayerController? _controller;
  bool _failed = false;
  bool _showVideo = false;
  bool _ended = false;

  @override
  void initState() {
    super.initState();
    _sync();
  }

  @override
  void didUpdateWidget(covariant _CarouselVideo oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.active != widget.active || oldWidget.playing != widget.playing) {
      if (oldWidget.active && !widget.active) _rewind();
      _sync();
    }
  }

  @override
  void dispose() {
    _controller
      ?..removeListener(_onVideoChanged)
      ..dispose();
    super.dispose();
  }

  void _sync() {
    if (_failed) return;
    if (widget.active && widget.playing) {
      unawaited(_play());
    } else {
      _controller?.pause();
    }
  }

  /// Saiu da página: na volta o vídeo recomeça.
  void _rewind() {
    _ended = false;
    _controller?.seekTo(Duration.zero);
  }

  Future<void> _play() async {
    var controller = _controller;
    if (controller == null) {
      controller = VideoPlayerController.networkUrl(
        Uri.parse(widget.item.url),
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
      );
      _controller = controller;
      controller.addListener(_onVideoChanged);
      try {
        await controller.initialize().timeout(const Duration(seconds: 10));
        await controller.setVolume(0);
        await controller.setLooping(widget.loop);
      } catch (_) {
        _fail();
        return;
      }
    }
    // Pode ter saído da página enquanto carregava.
    if (!mounted || _failed || !widget.active || !widget.playing) return;
    if (_ended) _rewind();
    await controller.play();
  }

  void _onVideoChanged() {
    final value = _controller?.value;
    if (value == null || !mounted) return;
    if (value.hasError) {
      _fail();
      return;
    }
    final totalMs = value.duration.inMilliseconds;
    if (widget.active && totalMs > 0) {
      widget.onProgress((value.position.inMilliseconds / totalMs).clamp(0.0, 1.0));
    }
    if (value.isCompleted && !_ended) {
      _ended = true;
      widget.onEnded();
    }
    // Só cobre a capa com o vídeo já andando (evita tela preta).
    final showVideo = value.isInitialized && value.position > Duration.zero;
    if (showVideo != _showVideo) setState(() => _showVideo = showVideo);
  }

  void _fail() {
    if (_failed) return;
    _failed = true;
    _controller?.pause();
    if (mounted) setState(() => _showVideo = false);
    widget.onFailed();
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;
    final thumbnail = widget.item.thumbnailUrl;
    return Stack(
      fit: StackFit.expand,
      children: [
        if (thumbnail != null && thumbnail.isNotEmpty)
          Image.network(thumbnail, fit: BoxFit.cover)
        else
          const ColoredBox(color: AppColors.grey900),
        if (_showVideo && controller != null)
          FittedBox(
            fit: BoxFit.cover,
            clipBehavior: Clip.hardEdge,
            child: SizedBox(
              width: controller.value.size.width,
              height: controller.value.size.height,
              child: VideoPlayer(controller),
            ),
          )
        else
          const Center(
            child: Icon(LucideIcons.play, color: AppColors.white, size: 40),
          ),
      ],
    );
  }
}
