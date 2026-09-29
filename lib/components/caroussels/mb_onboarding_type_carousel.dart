import 'package:flutter/material.dart';

import '../../ui/design_tokens/app_colors.dart';
import '../../ui/design_tokens/app_radius.dart';
import '../../ui/design_tokens/app_sizes.dart';
import '../../ui/design_tokens/app_text_styles.dart';

class MBOnboardingCarouselItem<T> {
  final String? title;
  final T data;

  const MBOnboardingCarouselItem({this.title, required this.data});
}

enum MBOnboardingCarouselDisplay { fullWidth, peek }

typedef MBOnboardingBottomWidgetsBuilder<T> = List<Widget> Function(
  BuildContext context,
  MBOnboardingCarouselItem<T> item,
  int index,
  Future<void> Function() onNext,
  Future<void> Function() onPrevious,
  VoidCallback onExit,
);

class MBOnboardingTypeCarousel<T> extends StatefulWidget {
  final List<MBOnboardingCarouselItem<T>> items;
  final Widget Function(
    BuildContext context,
    MBOnboardingCarouselItem<T> item,
    int index,
  )
  itemBuilder;
  final MBOnboardingBottomWidgetsBuilder<T>? bottomWidgetsBuilder;
  final ValueChanged<MBOnboardingCarouselItem<T>>? onCompleted;
  final void Function(BuildContext context)? onExit;
  final Duration transitionDuration;
  final Curve transitionCurve;
  final EdgeInsetsGeometry padding;
  final bool? isSwippable;
  final MBOnboardingCarouselDisplay display;
  final bool? showProgressBar;

  const MBOnboardingTypeCarousel({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.bottomWidgetsBuilder,
    this.onCompleted,
    this.onExit,
    this.transitionDuration = const Duration(milliseconds: 450),
    this.transitionCurve = Curves.easeOutCubic,
    this.padding = const EdgeInsets.all(AppSizes.large),
    this.isSwippable,
    this.display = MBOnboardingCarouselDisplay.fullWidth,
    this.showProgressBar,
  }) : assert(
     transitionDuration <= const Duration(seconds: 1),
     'transitionDuration must not exceed one second.',
   );

  @override
  State<MBOnboardingTypeCarousel<T>> createState() =>
      _MBOnboardingTypeCarouselState<T>();
}

class _MBOnboardingTypeCarouselState<T>
    extends State<MBOnboardingTypeCarousel<T>> {
  late PageController _pageController;
  int _activeIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = _createPageController();
  }

  @override
  void didUpdateWidget(covariant MBOnboardingTypeCarousel<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.display == widget.display) {
      return;
    }

    _pageController.dispose();
    _pageController = _createPageController(initialPage: _activeIndex);
  }

  PageController _createPageController({int initialPage = 0}) {
    return PageController(
      initialPage: initialPage,
      viewportFraction: widget.display == MBOnboardingCarouselDisplay.peek
          ? .88
          : 1,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _nextPage() async {
    final item = widget.items[_activeIndex];
    if (_activeIndex == widget.items.length - 1) {
      widget.onCompleted?.call(item);
      _exit();
      return;
    }

    await _pageController.nextPage(
      duration: widget.transitionDuration,
      curve: widget.transitionCurve,
    );
  }

  Future<void> _previousPage() {
    if (_activeIndex == 0) {
      return Future<void>.value();
    }

    return _pageController.previousPage(
      duration: widget.transitionDuration,
      curve: widget.transitionCurve,
    );
  }

  void _exit() {
    if (widget.onExit != null) {
      widget.onExit!(context);
    } else if (mounted && Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) {
      return const SizedBox.shrink();
    }

    final item = widget.items[_activeIndex];
    final bottomWidgets =
        widget.bottomWidgetsBuilder?.call(
          context,
          item,
          _activeIndex,
          _nextPage,
          _previousPage,
          _exit,
        ) ??
        const <Widget>[];
    final resolvedPadding = widget.padding.resolve(Directionality.of(context));

    return Column(
      // spacing: AppSizes.medium,
      children: [
        if (widget.showProgressBar ?? false)
          Padding(
            padding: EdgeInsets.only(
              // top: resolvedPadding.top,
              left: resolvedPadding.left,
              right: resolvedPadding.right,
            ),
            child: FractionallySizedBox(
              widthFactor: .5,
              child: _ProgressBars(
                count: widget.items.length,
                activeIndex: _activeIndex,
              ),
            ),
          ),
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            physics: widget.isSwippable ?? true ? const PageScrollPhysics() : const NeverScrollableScrollPhysics(),
            itemCount: widget.items.length,
            onPageChanged: (index) => setState(() => _activeIndex = index),
            itemBuilder: (context, index) => _CarouselPage<T>(
              controller: _pageController,
              index: index,
              title: widget.items[index].title ?? '',
              display: widget.display,
              child: widget.itemBuilder(context, widget.items[index], index),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: AppSizes.medium,
            left: resolvedPadding.left,
            right: resolvedPadding.right,
            bottom: AppSizes.medium,
          ),
          child: Column(
            children: [
              AnimatedSwitcher(
                duration: widget.transitionDuration,
                switchInCurve: Curves.easeOut,
                switchOutCurve: Curves.easeIn,
                transitionBuilder: (child, animation) => ClipRect(
                  child: FadeTransition(
                    opacity: animation,
                    child: SizeTransition(
                      sizeFactor: animation,
                      alignment: Alignment.topCenter,
                      child: child,
                    ),
                  ),
                ),
                child: bottomWidgets.isEmpty
                  ? const SizedBox(key: ValueKey('no-bottom-widgets'))
                  : Column(
                      key: ValueKey(
                        Object.hashAll(
                          bottomWidgets.map((widget) => widget.key ?? widget.runtimeType),
                        ),
                      ),
                      children: [
                        for (final bottomWidget in bottomWidgets)
                          bottomWidget,
                      ],
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CarouselPage<T> extends StatelessWidget {
  final PageController controller;
  final int index;
  final String title;
  final MBOnboardingCarouselDisplay display;
  final Widget child;

  const _CarouselPage({
    required this.controller,
    required this.index,
    required this.title,
    required this.display,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      child: child,
      builder: (context, child) {
        final page = controller.hasClients
            ? controller.page ?? index.toDouble()
            : index.toDouble();
        final distance = (page - index).abs().clamp(0.0, 1.0);

        return Opacity(
          opacity: 1 - distance,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.titleMedium),
              Expanded(child: child!),
            ],
          ),
        );
      },
    );
  }
}

class _ProgressBars extends StatelessWidget {
  final int count;
  final int activeIndex;

  const _ProgressBars({required this.count, required this.activeIndex});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        count,
        (index) => Expanded(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: AppSizes.sm,
            margin: EdgeInsets.only(
              right: index == count - 1 ? 0 : AppSizes.small,
            ),
            decoration: BoxDecoration(
              color: index == activeIndex ? AppColors.primary
                  : index <= activeIndex ? AppColors.primaryLight : AppColors.neutral200,
              borderRadius: BorderRadius.circular(AppRadius.full),
            ),
          ),
        ),
      ),
    );
  }
}
