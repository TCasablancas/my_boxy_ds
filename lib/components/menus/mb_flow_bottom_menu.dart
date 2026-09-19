import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:my_boxy_ds/components/containers/mb_box_rounded_container.dart';
import 'package:my_boxy_ds/my_boxy_ds.dart';

class MBFlowBottomMenu extends StatefulWidget {

  final bool isVisible;
  final Duration duration;
  final Curve curve;
  final Widget child;
  final VoidCallback? onDismiss;

  const MBFlowBottomMenu({
    super.key,
    required this.isVisible,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
    required this.child,
    this.onDismiss,
  });

  @override
  State<MBFlowBottomMenu> createState() => _MBFlowBottomMenuState();
}

class _MBFlowBottomMenuState extends State<MBFlowBottomMenu> with SingleTickerProviderStateMixin {

  late final AnimationController _slideController;
  static const _dismissDragThreshold = 100.0;
  static const _dismissVelocityThreshold = 300.0;

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
      (_slideController.value + details.delta.dy / screenHeight).clamp(0.0, 1.0);
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
  void didUpdateWidget(covariant MBFlowBottomMenu oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isVisible != oldWidget.isVisible) {
      _animateSlideTo(widget.isVisible ? 0 : 1);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _slideController.dispose();
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
            return _buildMenuBody();
          }
        )
      )
    );
  }

  Widget _buildMenuBody() {
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: widget.onDismiss,
            behavior: HitTestBehavior.opaque,
            onVerticalDragStart: _handleDragStart,
            onVerticalDragUpdate: _handleDragUpdate,
            onVerticalDragEnd: _handleDragEnd,
            onVerticalDragCancel: _handleDragCancel,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: ColoredBox(color: AppColors.grey900.withAlpha(200)),
            ),
          ),
        ),
        Positioned(
          bottom: 90, left: 50, right: 50,
          child: Transform.translate(
            offset: Offset(0, screenHeight * _slideController.value),
            child: GestureDetector(
              onVerticalDragStart: _handleDragStart,
              onVerticalDragUpdate: _handleDragUpdate,
              onVerticalDragEnd: _handleDragEnd,
              onVerticalDragCancel: _handleDragCancel,
              child: widget.child,
            ),
          ),
        ),
      ],
    );
  }
}