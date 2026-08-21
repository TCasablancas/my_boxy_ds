import 'dart:ui';

import 'package:flutter/material.dart';

class MBSidebarController extends ValueNotifier<bool> {
  MBSidebarController() : super(false);

  void open() => value = true;
  void close() => value = false;
  void toggle() => value = !value;
}

class MBSidebarItem {
  final Icon? icon;
  final String title;
  final Color? color;
  final VoidCallback onTap;

  const MBSidebarItem({
    this.icon,
    required this.title,
    this.color,
    required this.onTap,
  });
}

class MBCollapsibleSidebar extends StatefulWidget {
  final MBSidebarController controller;
  final Widget child;
  final List<MBSidebarItem> items;

  const MBCollapsibleSidebar({
    super.key,
    required this.controller,
    required this.child,
    required this.items,
  });

  @override
  State<MBCollapsibleSidebar> createState() => _MBCollapsibleSidebarState();
}

class _MBCollapsibleSidebarState extends State<MBCollapsibleSidebar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 200),
  );
  late final Animation<Offset> _slide = Tween<Offset>(
    begin: const Offset(1, 0),
    end: Offset.zero,
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onToggle);
  }

  double _panelWidth = 0;

  void _onToggle() {
    widget.controller.value ? _controller.forward() : _controller.reverse();
  }

  void _onDragStart(DragStartDetails details) {
    _controller.stop();
  }

  void _onDragUpdate(DragUpdateDetails details) {
    final delta = (details.primaryDelta ?? 0) / _panelWidth;
    _controller.value = (_controller.value - delta).clamp(0.0, 1.0);
  }

  void _onDragEnd(DragEndDetails details) {
    final velocity = details.primaryVelocity ?? 0;
    final shouldOpen = velocity < -200
        ? true
        : velocity > 200
        ? false
        : _controller.value > 0.5;
    widget.controller.value = shouldOpen;
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onToggle);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.7;
    _panelWidth = width;

    return Stack(
      children: [
        widget.child,
        AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            final progress = _controller.value;
            if (progress == 0) return const SizedBox.shrink();

            return Positioned.fill(
              child: IgnorePointer(
                ignoring: progress == 0,
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 2 * progress, sigmaY: 2 * progress,
                  ),
                  child: GestureDetector(
                    onHorizontalDragStart: _onDragStart,
                    onHorizontalDragUpdate: _onDragUpdate,
                    onHorizontalDragEnd: _onDragEnd,
                    behavior: HitTestBehavior.opaque,
                    onTap: widget.controller.close,
                    child: Container(
                      color: Colors.black.withAlpha((0.7 * 255 * progress).toInt()),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.centerRight,
            child: SlideTransition(
              position: _slide,
              child: GestureDetector(
                onHorizontalDragStart: _onDragStart,
                onHorizontalDragUpdate: _onDragUpdate,
                onHorizontalDragEnd: _onDragEnd,
                behavior: HitTestBehavior.opaque,
                child: SizedBox(
                  width: width,
                  height: double.infinity,
                  child: Material(
                    color: Colors.grey[800],
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 60, 0, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              icon: Icon(Icons.close, color: Colors.grey[500]),
                              onPressed: widget.controller.close,
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {},
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: widget.items.map(_buildItem).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildItem(MBSidebarItem item) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        overlayColor: Colors.transparent,
      ),
      onPressed: item.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          spacing: 8,
          children: [
            item.icon ?? const SizedBox.shrink(),
            Text(
              item.title,
              style: TextStyle(
                fontFamily: 'Lexend',
                fontSize: 22,
                color: item.color ?? Colors.grey[500],
              ),
            )
          ],
        ),
      )
    );
  }
}
