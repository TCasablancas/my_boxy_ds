import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_boxy_ds/components/buttons/mb_rounded_icon_btn.dart';
import 'package:my_boxy_ds/components/menus/mb_bottom_fixed_menu.dart';
import 'package:my_boxy_ds/components/menus/mb_collapsible_sidebar.dart';
import 'package:my_boxy_ds/ui/mb_typography.dart';
import 'package:my_boxy_ds/ui/mb_design_tokens.dart';

class MBMainView extends StatefulWidget {
  final String? viewTitle;
  final Widget? headerWidget;
  final bool? backButton;
  final Widget? header;
  final Widget child;
  final Color? backgroundColor;
  final List<MBSidebarItem>? sidebarItems;
  final List<Widget>? rightActions;
  final bool? hasAppBar;
  final bool? hasBottomMenu;
  final bool blurAppBarOnScroll;
  final VoidCallback? onNotificationsTap;
  final VoidCallback? onCartTap;
  final VoidCallback? onMenuTap;

  const MBMainView({
    super.key,
    this.viewTitle,
    this.headerWidget,
    this.backButton,
    this.header,
    required this.child,
    this.backgroundColor,
    this.sidebarItems,
    this.rightActions,
    this.hasAppBar,
    this.hasBottomMenu,
    this.blurAppBarOnScroll = false,
    this.onNotificationsTap,
    this.onCartTap,
    this.onMenuTap,
  });

  @override
  State<MBMainView> createState() => _MBMainViewState();
}

class _MBMainViewState extends State<MBMainView> {
  final sidebarController = MBSidebarController();
  bool _isAppBarScrolled = false;

  TextStyle _appBarStyle() {
    return AppTypography.body1Fn(Colors.grey[500]!, FontWeight.w700);
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (!widget.blurAppBarOnScroll ||
        notification.depth != 0 ||
        notification.metrics.axis != Axis.vertical) {
      return false;
    }

    final isScrolled = notification.metrics.pixels > 0;
    if (isScrolled != _isAppBarScrolled) {
      setState(() => _isAppBarScrolled = isScrolled);
    }

    return false;
  }

  Widget _blurredAppBarBackground(Color backgroundColor) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 240),
      curve: Curves.easeOut,
      tween: Tween<double>(begin: 0, end: _isAppBarScrolled ? 1 : 0),
      builder: (context, value, child) {
        return ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: value * 8, sigmaY: value * 8),
            child: ColoredBox(
              color: Color.lerp(
                backgroundColor,
                backgroundColor.withAlpha(179),
                value,
              )!,
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    sidebarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = widget.backgroundColor ?? AppColors.lightBackground;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: widget.hasAppBar ?? true
          ? AppBar(
              title: widget.viewTitle != null
                  ? Text(widget.viewTitle!, style: _appBarStyle())
                  : widget.headerWidget,
              automaticallyImplyLeading: false,
              leading: widget.backButton != false && widget.hasAppBar != false
                  ? Container(
                      margin: const EdgeInsets.only(left: 16.0),
                      alignment: Alignment.centerLeft,
                      child: MBRoundedIconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.grey[700]),
                        // buttonSize: MBRoundedIconButtonSize.small,
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    )
                  : const SizedBox.shrink(),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Row(children: widget.rightActions ?? []),
                ),
              ],
              backgroundColor: widget.blurAppBarOnScroll
                  ? Colors.transparent
                  : backgroundColor,
              elevation: widget.blurAppBarOnScroll ? 0 : null,
              scrolledUnderElevation: widget.blurAppBarOnScroll ? 0 : null,
              surfaceTintColor: widget.blurAppBarOnScroll
                  ? Colors.transparent
                  : null,
              forceMaterialTransparency: widget.blurAppBarOnScroll,
              flexibleSpace: widget.blurAppBarOnScroll
                  ? _blurredAppBarBackground(backgroundColor)
                  : null,
            )
          : null,
      resizeToAvoidBottomInset: true,
      backgroundColor: backgroundColor,
      body: NotificationListener<ScrollNotification>(
        onNotification: _handleScrollNotification,
        child: MBCollapsibleSidebar(
          controller: sidebarController,
          items: widget.sidebarItems ?? [],
          child: Stack(
            children: [
              SafeArea(
                child: Column(
                  children: [
                    widget.header ?? const SizedBox.shrink(),
                    // const SizedBox(height: 16),
                    Expanded(child: widget.child),
                  ],
                ),
              ),
              if (widget.hasBottomMenu ?? true)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: MBBottomFixedMenu(
                    onNotificationsTap: widget.onNotificationsTap,
                    onCartTap: widget.onCartTap,
                    onMenuTap: widget.onMenuTap ?? sidebarController.toggle,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
