import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:my_boxy_ds/components/buttons/mb_header_action_btn.dart';
import 'package:my_boxy_ds/components/buttons/mb_rounded_icon_btn.dart';
import 'package:my_boxy_ds/components/menus/mb_bottom_fixed_menu.dart';
import 'package:my_boxy_ds/components/menus/mb_collapsible_sidebar.dart';
import 'package:my_boxy_ds/components/menus/mb_floating_bottom_menu.dart';
import 'package:my_boxy_ds/my_boxy_ds.dart';
// import 'package:my_boxy_ds/ui/mb_typography.dart';
// import 'package:my_boxy_ds/ui/mb_design_tokens.dart';

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
  final Widget? floatingBottomMenu;
  final MBFloatingMenuController? floatingMenuController;
  final List<Widget>? footerActions;

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
    this.floatingBottomMenu,
    this.floatingMenuController,
    this.footerActions,
  });

  @override
  State<MBMainView> createState() => _MBMainViewState();
}

class _MBMainViewState extends State<MBMainView> {
  final sidebarController = MBSidebarController();
  late final MBFloatingMenuController _floatingMenuController =
      widget.floatingMenuController ?? MBFloatingMenuController();
  bool _isAppBarScrolled = false;
  bool _displayBottomDisclaimer = false;

  // TextStyle _appBarStyle() {
  //   return AppTypography.body1Fn(Colors.grey[500]!, FontWeight.w700);
  // }

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

    final reachedBottom = notification.metrics.atEdge;
    if (reachedBottom != _displayBottomDisclaimer) {
      setState(() {
        _displayBottomDisclaimer = reachedBottom;
      });
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
    if (widget.floatingMenuController == null) {
      _floatingMenuController.dispose();
    }
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
                  ? Text(widget.viewTitle!, style: AppTextStyles.appBarTitle)
                  : widget.headerWidget,
              automaticallyImplyLeading: false,
              leading: widget.backButton != false && widget.hasAppBar != false
                  ? Container(
                      margin: const EdgeInsets.only(left: 16.0),
                      alignment: Alignment.centerLeft,
                      child: MBHeaderActionBtn(
                        icon: Icons.arrow_back, 
                        onTap: () => Navigator.of(context).pop()
                      ),
                      // MBRoundedIconButton(
                        // icon: Icon(Icons.arrow_back, color: Colors.grey[700]),
                        // buttonSize: MBRoundedIconButtonSize.small,
                        // onPressed: () => Navigator.of(context).pop(),
                      // ),
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
                    Expanded(child: widget.child),
                    // Container(
                    //   width: double.infinity,
                    //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    //   margin: EdgeInsets.only(bottom: 24),
                    //   decoration: BoxDecoration(
                    //     border: BoxBorder.all(
                    //       width: 1,
                    //       color: AppColors.border
                    //     ),
                    //   ),
                    //   child: Text(
                    //     'Você viu todos os itens desta loja...',
                    //     style: AppTextStyles.labelSmall.copyWith(
                    //       color: AppColors.border
                    //     )
                    //   )
                    // ),
                  ],
                ),
              ),
              if (widget.floatingBottomMenu != null)
                Positioned.fill(
                  child: ValueListenableBuilder<bool>(
                    valueListenable: _floatingMenuController,
                    builder: (context, isVisible, child) {
                      return MBFloatingBottomMenu(
                        isVisible: isVisible,
                        onDismiss: _floatingMenuController.close,
                        child: child!,
                      );
                    },
                    child: widget.floatingBottomMenu!,
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
                    onMenuTap: widget.onMenuTap ?? _floatingMenuController.toggle,
                  ),
                ),
            ],
          ),
        ),
      ),
      persistentFooterButtons: widget.footerActions != null
          ? [Column(
              spacing: 16,
              crossAxisAlignment: CrossAxisAlignment.center, 
              children: widget.footerActions!
            )]
          : null,
      persistentFooterDecoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(30),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, -2), // changes position of shadow
          ),
        ],
      ),
    );
  }
}
