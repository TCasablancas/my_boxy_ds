import 'dart:ui';
import 'dart:io';
import 'package:flutter/material.dart';
import 'mb_bottomsheet_handler.dart';
import 'package:my_boxy_ds/components/labels/mb_title_subtitled_label.dart';

enum MBBottomsheetHeightStyle { adaptive, full }

class MBMainBottomsheet extends StatefulWidget {
  final String? title;
  final String? description;
  final Widget child;
  final MBBottomsheetHeightStyle heightStyle;
  final TextAlign? textAlign;
  final Animation<double>? transitionAnimation;

  const MBMainBottomsheet({
    super.key,
    this.title,
    this.description,
    required this.child,
    this.heightStyle = MBBottomsheetHeightStyle.adaptive,
    this.textAlign,
    this.transitionAnimation,
  });

  static Future<T?> show<T>(BuildContext context, {
    String? title,
    String? description,
    required Widget child,
    MBBottomsheetHeightStyle heightStyle = MBBottomsheetHeightStyle.adaptive,
    TextAlign? textAlign,
  }) {
    return showGeneralDialog<T>(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (context, animation, secondaryAnimation) =>
        MBMainBottomsheet(
          title: title,
          description: description,
          heightStyle: heightStyle,
          textAlign: textAlign,
          transitionAnimation: animation,
          child: child,
        ),
      transitionBuilder: (context, animation, secondaryAnimation, child) => child,
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
    final animation = widget.transitionAnimation ?? const AlwaysStoppedAnimation(1.0);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        onTap: _close,
        onVerticalDragStart: _handleDragStart,
        onVerticalDragUpdate: _handleDragUpdate,
        onVerticalDragEnd: _handleDragEnd,
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
              left: 8, right: 8, 
              bottom: Platform.isAndroid ? 8 - _dragExtent : -_dragExtent,
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
                      height: widget.heightStyle == MBBottomsheetHeightStyle.full
                        ? maxHeight : null,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16),
                          bottom: Radius.circular(16),
                        ),
                      ),
                      child: _buildBottomsheetContent(
                        widget.title ?? '', widget.description ?? ''
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }

  Widget _buildBottomsheetContent(String title, String description) {
    final EdgeInsets padding = EdgeInsets.only(bottom: MediaQuery.paddingOf(context).bottom);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MBBottomsheetHandler(),
        widget.heightStyle == MBBottomsheetHeightStyle.full
          ? Expanded(
              child: SingleChildScrollView(
                padding: Platform.isAndroid ? padding : const EdgeInsets.only(bottom: 16.0),
                child: _buildContentWithText(title, description),
              ),
            )
          : Flexible(
              child: Padding(
                padding: Platform.isAndroid ? padding : const EdgeInsets.only(bottom: 16.0),
                child: _buildContentWithText(title, description),
              ),
            ),
      ],
    );
  }

  Widget _buildContentWithText(String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
            child: MBTitleSubtitled(
              title: title,
              description: description,
              textAlign: widget.textAlign ?? TextAlign.center,
            ),
          ),
          Container(
            height: 1, width: double.infinity,
            decoration: BoxDecoration(color: Colors.grey[200]),
          ),
          widget.child,
        ],
      ),
    );
  }
}
