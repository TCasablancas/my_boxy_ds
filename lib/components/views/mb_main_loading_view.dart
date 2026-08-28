import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:my_boxy_ds/ui/design_tokens/design_tokens.dart';

import '../../ui/design_tokens/app_colors.dart';
import '../../ui/design_tokens/app_radius.dart';
import '../../ui/design_tokens/app_shadows.dart';

class MBMainLoadingView extends StatefulWidget {
  const MBMainLoadingView({super.key, this.controller});

  final MBMainLoadingViewController? controller;

  static Future<void> trigger<T>(
    BuildContext context, {
    required Future<T> Function() request,
    required Widget Function(BuildContext context, T result) nextView,
  }) async {
    final navigator = Navigator.of(context);
    final controller = MBMainLoadingViewController();

    final loadingRoute = PageRouteBuilder(
      opaque: false,
      barrierColor: AppColors.transparent,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, animation, secondaryAnimation) =>
          MBMainLoadingView(controller: controller),
    );
    navigator.push(loadingRoute);

    final result = await request();

    navigator.push(
      MaterialPageRoute(builder: (context) => nextView(context, result)),
    );
    await controller.dismiss();
    navigator.removeRoute(loadingRoute);
  }

  @override
  State<MBMainLoadingView> createState() => _MBMainLoadingViewState();
}

/// Lets [MBMainLoadingView.trigger] drive the exit animation before popping.
class MBMainLoadingViewController {
  _MBMainLoadingViewState? _state;

  Future<void> dismiss() => _state?._playExit() ?? Future.value();
}

class _MBMainLoadingViewState extends State<MBMainLoadingView>
    with TickerProviderStateMixin {
  static const double _containerHeight = 120.0;

  late final AnimationController _fadeController;
  late final AnimationController _slideController;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    widget.controller?._state = this;

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _fade = CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut);
    _slide = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeInOutCubic));

    _fadeController.forward();
    _slideController.forward();
  }

  Future<void> _playExit() {
    return Future.wait([
      _slideController.reverse(),
      _fadeController.reverse(),
    ]);
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.transparent,
      body: SizedBox.expand(
        child: Stack(
          children: [
            Positioned.fill(
              child: FadeTransition(
                opacity: _fade,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                  child: Container(color: AppColors.black.withAlpha(89)),
                ),
              ),
            ),
            Positioned(
              bottom: 40, left: 16, right: 16,
              child: Align(
                alignment: Alignment.bottomCenter,
                heightFactor: 60,
                child: SlideTransition(
                  position: _slide,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 36.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: AppRadius.allXLarge,
                      boxShadow: AppShadows.bottomSheet,
                    ),
                    child: Row(
                      children: [
                        Text('Carregando', style: AppTextStyles.bodyMediumStrong,),
                        const Spacer(),
                        CircularProgressIndicator(color: AppColors.primary),
                      ]
                    ),
                  ),
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}
