import 'package:flutter/material.dart';

import 'dart:ui';

import 'package:my_boxy_ds/components/bottomsheet/mb_bottomsheet_handler.dart';

class MBFloatingBottomMenu extends StatefulWidget {
  final bool isVisible;
  final Widget child;
  final Duration duration;
  final Curve curve;
  final Color barrierColor;
  final VoidCallback? onDismiss;

  const MBFloatingBottomMenu({
    super.key,
    required this.isVisible,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
    this.barrierColor = const Color(0x66000000),
    this.onDismiss,
  });

  @override
  State<MBFloatingBottomMenu> createState() => _MBFloatingBottomMenuState();
}

class _MBFloatingBottomMenuState extends State<MBFloatingBottomMenu>
    with SingleTickerProviderStateMixin {
  static const _dismissDragThreshold = 100.0;
  static const _dismissVelocityThreshold = 300.0;

  late final AnimationController _slideController;

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      vsync: this,
      value: widget.isVisible ? 0 : 1,
    );
  }

  void _animateSlideTo(double value) {
    _slideController.animateTo(
      value,
      duration: widget.duration,
      curve: widget.curve,
    );
  }

  void _handleDragStart(DragStartDetails details) {
    _slideController.stop();
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    _slideController.value =
        (_slideController.value + details.delta.dy / screenHeight).clamp(
          0.0,
          1.0,
        );
  }

  void _handleDragEnd(DragEndDetails details) {
    final velocity = details.primaryVelocity ?? 0;
    final dragOffset =
        _slideController.value * MediaQuery.sizeOf(context).height;
    final shouldDismiss =
        dragOffset > _dismissDragThreshold ||
        velocity > _dismissVelocityThreshold;

    if (!shouldDismiss) return _animateSlideTo(0);
    if (widget.onDismiss != null) return widget.onDismiss!();
    _animateSlideTo(1);
  }

  void _handleDragCancel() {
    _animateSlideTo(widget.isVisible ? 0 : 1);
  }

  @override
  void didUpdateWidget(covariant MBFloatingBottomMenu oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isVisible != oldWidget.isVisible) {
      _animateSlideTo(widget.isVisible ? 0 : 1);
    }
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !widget.isVisible,
      child: AnimatedOpacity(
        opacity: widget.isVisible ? 1 : 0,
        duration: widget.duration,
        curve: widget.curve,
        child: AnimatedBuilder(
          animation: _slideController,
          builder: (context, _) {
            final screenHeight = MediaQuery.sizeOf(context).height;

            return Stack(
              children: [
                Positioned.fill(
                  child: GestureDetector(
                    onTap: widget.onDismiss,
                    behavior: HitTestBehavior.opaque,
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: ColoredBox(color: widget.barrierColor),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 90,
                  left: 50,
                  right: 50,
                  child: Transform.translate(
                    offset: Offset(0, screenHeight * _slideController.value),
                    child: GestureDetector(
                      onVerticalDragStart: _handleDragStart,
                      onVerticalDragUpdate: _handleDragUpdate,
                      onVerticalDragEnd: _handleDragEnd,
                      onVerticalDragCancel: _handleDragCancel,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            MBBottomsheetHandler(),
                            const SizedBox(height: 16),
                            Text(
                              'Menu',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Lexend',
                                fontWeight: FontWeight.w700,
                                color: Colors.grey[700],
                              ),
                            ),
                            widget.child,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
