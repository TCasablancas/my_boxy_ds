import 'package:flutter/material.dart';

class MBCarouselProgressDot extends StatefulWidget {
  final bool active;
  final Animation<double> progress;
  final VoidCallback onPressed;

  const MBCarouselProgressDot({
    super.key,
    required this.active,
    required this.progress,
    required this.onPressed,
  });

  @override
  State<MBCarouselProgressDot> createState() => MBCarouselProgressDotState();
}

class MBCarouselProgressDotState extends State<MBCarouselProgressDot> {
  final double _height = 4;
  final double _inactiveWidth = 8;
  final double _activeWidth = 44;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: widget.active ? _activeWidth : _inactiveWidth,
        height: _height,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: const Color(0xFFE0E0E0),
          borderRadius: BorderRadius.circular(_height / 2),
        ),
        child: widget.active
            ? AnimatedBuilder(
                animation: widget.progress,
                builder: (context, _) => FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: widget.progress.value.clamp(0.0, 1.0),
                  child: const ColoredBox(color: Color(0xFF007AFF)),
                ),
              )
            : null,
      ),
    );
  }
}