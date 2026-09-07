import 'dart:ui';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:my_boxy_ds/ui/design_tokens/design_tokens.dart';
import 'mb_bottomsheet_handler.dart';
import 'package:my_boxy_ds/components/labels/mb_title_subtitled_label.dart';

enum MBBottomsheetHeightStyle { adaptive, full, expandable }

class MBMainBottomsheet extends StatefulWidget {
  final String? title;
  final String? description;
  final Widget child;
  final MBBottomsheetHeightStyle heightStyle;
  final TextAlign? textAlign;
  final Animation<double>? transitionAnimation;
  final List<Widget>? actions;

  const MBMainBottomsheet({
    super.key,
    this.title,
    this.description,
    required this.child,
    this.heightStyle = MBBottomsheetHeightStyle.adaptive,
    this.textAlign,
    this.transitionAnimation,
    this.actions,
  });

  static Future<T?> show<T>(BuildContext context, {
    String? title,
    String? description,
    required Widget child,
    MBBottomsheetHeightStyle heightStyle = MBBottomsheetHeightStyle.adaptive,
    List<Widget>? actions,
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
          actions: actions,
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
  static const double _halfScreenFraction = 0.6;
  static const double _fallbackAdaptiveHeight = 240;

  final GlobalKey _adaptiveProbeKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();

  double? _measuredAdaptiveHeight;
  int _snapIndex = 0;
  double _dragAccum = 0;

  bool get _isExpandable =>
      widget.heightStyle == MBBottomsheetHeightStyle.expandable;

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

  double _adaptiveHeight(double maxHeight) =>
      (_measuredAdaptiveHeight ?? _fallbackAdaptiveHeight).clamp(0.0, maxHeight);

  double _halfHeight(double screenHeight, double maxHeight) =>
      (screenHeight * _halfScreenFraction).clamp(0.0, maxHeight);

  void _measureAdaptiveHeight() {
    final renderBox =
        _adaptiveProbeKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null || !renderBox.hasSize) return;
    final measured = renderBox.size.height;
    if (_measuredAdaptiveHeight != measured) {
      setState(() => _measuredAdaptiveHeight = measured);
    }
  }

  double _heightForIndex(int index, double screenHeight, double maxHeight) {
    switch (index) {
      case 1:
        return _halfHeight(screenHeight, maxHeight);
      case 2:
        return maxHeight;
      default:
        return _adaptiveHeight(maxHeight);
    }
  }

  void _onResizeDragStart(DragStartDetails details) {
    _dragAccum = 0;
  }

  void _onResizeDragUpdate(DragUpdateDetails details) {
    _dragAccum += details.delta.dy;
  }

  /// Ignores where the finger let go — only the drag direction (past a
  /// threshold) matters, and it always steps exactly one position through
  /// the ordered stops: adaptive -> half -> full, and back down again.
  /// The displayed height is derived from [_snapIndex] alone (see build),
  /// so it is always a finite value — never interpolated from/to unbounded.
  void _onResizeDragEnd(DragEndDetails details) {
    final velocity = details.primaryVelocity ?? 0;
    final draggedUp =
        _dragAccum < -_dismissDragThreshold || velocity < -_dismissVelocityThreshold;
    final draggedDown =
        _dragAccum > _dismissDragThreshold || velocity > _dismissVelocityThreshold;

    if (draggedDown && _snapIndex == 0) {
      _close();
      return;
    }

    var nextIndex = _snapIndex;
    if (draggedUp) nextIndex = (_snapIndex + 1).clamp(0, 2);
    if (draggedDown) nextIndex = (_snapIndex - 1).clamp(0, 2);

    setState(() => _snapIndex = nextIndex);
  }

  bool get _contentScrollable => _snapIndex >= 1;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final screenHeight = screenSize.height;
    final maxHeight = screenHeight * 0.9;
    final animation = widget.transitionAnimation ?? const AlwaysStoppedAnimation(1.0);
    final expandableHeight = _isExpandable
      ? _heightForIndex(_snapIndex, screenHeight, maxHeight)
      : null;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        onTap: _close,
        onVerticalDragStart: _isExpandable ? null : _handleDragStart,
        onVerticalDragUpdate: _isExpandable ? null : _handleDragUpdate,
        onVerticalDragEnd: _isExpandable ? null : _handleDragEnd,
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
            if (_isExpandable)
              // Off-screen probe: lays out the real header + content at the
              // sheet's width, unconstrained height, purely to measure the
              // natural "adaptive" size. Never touches the animated height.
              Positioned(
                left: 8,
                width: screenSize.width - 16,
                child: Offstage(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      key: _adaptiveProbeKey,
                      mainAxisSize: MainAxisSize.min,
                      children: [_expandableHeaderContent(), widget.child],
                    ),
                  ),
                ),
              ),
            AnimatedPositioned(
              duration: _dragging ? Duration.zero : const Duration(milliseconds: 450),
              curve: Curves.fastOutSlowIn,
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
                  onVerticalDragStart: _isExpandable ? null : _handleDragStart,
                  onVerticalDragUpdate: _isExpandable ? null : _handleDragUpdate,
                  onVerticalDragEnd: _isExpandable ? null : _handleDragEnd,
                  behavior: HitTestBehavior.opaque,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: maxHeight),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 320),
                      curve: Curves.fastOutSlowIn,
                      width: double.infinity,
                      height: _isExpandable
                        ? expandableHeight
                        : widget.heightStyle == MBBottomsheetHeightStyle.full
                          ? maxHeight : null,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16),
                          bottom: Radius.circular(16),
                        ),
                      ),
                      child: _isExpandable
                        ? _buildExpandableContent()
                        : _buildBottomsheetContent(
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

  Widget _expandableHeaderContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const MBBottomsheetHandler(),
        if (widget.title != null || widget.description != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSizes.medium, AppSizes.small, AppSizes.medium, AppSizes.small,
            ),
            child: Row(
              children: [
                MBTitleSubtitled(
                  title: widget.title ?? '',
                  description: widget.description ?? '',
                  textAlign: widget.textAlign ?? TextAlign.center,
                ),
                Spacer(),
                if (widget.actions != null)
                  Container(
                    height: 20.0,
                    decoration: BoxDecoration(
                      color: AppColors.grey100,
                      borderRadius: BorderRadius.circular(AppRadius.xs),
                    ),
                    child: Row(
                      spacing: AppSizes.xs,
                      children: widget.actions!,
                    ),
                  )
              ],
            ),
          ),
        Container(
          height: 1, width: double.infinity,
          color: AppColors.divider,
        ),
      ],
    );
  }

  Widget _buildExpandableContent() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _measureAdaptiveHeight());

    final header = GestureDetector(
      behavior: HitTestBehavior.opaque,
      onVerticalDragStart: _onResizeDragStart,
      onVerticalDragUpdate: _onResizeDragUpdate,
      onVerticalDragEnd: _onResizeDragEnd,
      child: _expandableHeaderContent(),
    );

    return Column(
      children: [
        header,
        Expanded(
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: _contentScrollable
              ? const ClampingScrollPhysics()
              : const NeverScrollableScrollPhysics(),
            child: widget.child,
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
            child: widget.actions == null ? MBTitleSubtitled(
              title: title,
              description: description,
              textAlign: widget.textAlign ?? TextAlign.center,
            ) : Row(
              children: [
                Expanded(
                  child: MBTitleSubtitled(
                    title: title,
                    description: description,
                    textAlign: widget.textAlign ?? TextAlign.center,
                  )
                ),
                Spacer(),
                if (widget.actions != null)
                  Container(
                    height: 20.0,
                    decoration: BoxDecoration(
                      color: AppColors.grey100,
                      borderRadius: BorderRadius.circular(AppRadius.xs),
                    ),
                    child: Row(
                      spacing: AppSizes.medium,
                      children: widget.actions!,
                    ),
                  )
              ],
            )
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
