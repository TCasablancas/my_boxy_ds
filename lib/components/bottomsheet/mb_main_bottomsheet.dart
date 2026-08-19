import 'dart:ui';

import 'package:flutter/material.dart';

enum MBBottomsheetHeightStyle { adaptive, full90 }

class MBMainBottomsheet extends StatefulWidget {
  final Widget child;
  final MBBottomsheetHeightStyle heightStyle;
  final Animation<double>? transitionAnimation;

  const MBMainBottomsheet({
    super.key,
    required this.child,
    this.heightStyle = MBBottomsheetHeightStyle.adaptive,
    this.transitionAnimation,
  });

  static Future<T?> show<T>(
    BuildContext context, {
    required Widget child,
    MBBottomsheetHeightStyle heightStyle = MBBottomsheetHeightStyle.adaptive,
  }) {
    return showGeneralDialog<T>(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (context, animation, secondaryAnimation) =>
          MBMainBottomsheet(
            heightStyle: heightStyle,
            transitionAnimation: animation,
            child: child,
          ),
      transitionBuilder: (context, animation, secondaryAnimation, child) =>
          child,
    );
  }

  @override
  State<MBMainBottomsheet> createState() => _MBMainBottomsheetState();
}

class _MBMainBottomsheetState extends State<MBMainBottomsheet> {
  double _dragExtent = 0;
  bool _dragging = false;

  static const double _dismissDragThreshold = 100;
  static const double _dismissVelocityThreshold = 300;

  void _close() => Navigator.of(context).maybePop();

  void _handleDragStart(DragStartDetails details) {
    setState(() => _dragging = true);
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    setState(() {
      _dragExtent = (_dragExtent + details.delta.dy).clamp(
        0.0,
        double.infinity,
      );
    });
  }

  void _handleDragEnd(DragEndDetails details) {
    final velocity = details.primaryVelocity ?? 0;
    final shouldClose =
        _dragExtent > _dismissDragThreshold ||
        velocity > _dismissVelocityThreshold;
    setState(() {
      _dragging = false;
      if (!shouldClose) _dragExtent = 0;
    });
    if (shouldClose) _close();
  }

  @override
  Widget build(BuildContext context) {
    final maxHeight = MediaQuery.sizeOf(context).height * 0.9;
    final bottomSafeArea = MediaQuery.paddingOf(context).bottom;
    final animation =
        widget.transitionAnimation ?? const AlwaysStoppedAnimation(1.0);

    return GestureDetector(
      onTap: _close,
      behavior: HitTestBehavior.opaque,
      child: Stack(
        children: [
          Positioned.fill(
            child: FadeTransition(
              opacity: animation,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                child: Container(color: const Color.fromRGBO(0, 0, 0, 0.6)),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: _dragging ? Duration.zero : const Duration(milliseconds: 250),
            curve: Curves.easeOut,
            left: 8, right: 8, bottom: 8 - _dragExtent,
            child: AnimatedBuilder(
              animation: animation,
              builder: (context, sheet) => Transform.translate(
                offset: Offset(0, (1 - animation.value) * maxHeight),
                child: sheet,
              ),
              child: GestureDetector(
                onTap: () {},
                behavior: HitTestBehavior.opaque,
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: maxHeight),
                  child: Container(
                    width: double.infinity,
                    height:
                        widget.heightStyle == MBBottomsheetHeightStyle.full90
                        ? maxHeight
                        : null,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                        bottom: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onVerticalDragStart: _handleDragStart,
                          onVerticalDragUpdate: _handleDragUpdate,
                          onVerticalDragEnd: _handleDragEnd,
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            alignment: Alignment.center,
                            child: Container(
                              width: 40, height: 4,
                              decoration: BoxDecoration(
                                color: const Color(0xFFE0E0E0),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                        ),
                        widget.heightStyle == MBBottomsheetHeightStyle.full90
                            ? Expanded(
                                child: SingleChildScrollView(
                                  padding: EdgeInsets.only(
                                    bottom: bottomSafeArea,
                                  ),
                                  child: widget.child,
                                ),
                              )
                            : Flexible(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    bottom: bottomSafeArea,
                                  ),
                                  child: widget.child,
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
