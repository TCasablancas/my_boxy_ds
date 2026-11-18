import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:my_boxy_ds/ui/design_tokens/design_tokens.dart';

import '../buttons/mb_text_btn.dart';

class MBShrinkContentView extends StatefulWidget {
  const MBShrinkContentView({
    super.key,
    required this.child,
    this.backgroundColor,
  });

  final Widget child;
  final Color? backgroundColor;

  @override
  State<MBShrinkContentView> createState() => _MBShrinkContentViewState();
}

class _MBShrinkContentViewState extends State<MBShrinkContentView> {
  static const _minHeight = 90.0;
  final _contentKey = GlobalKey();
  double _contentHeight = _minHeight;
  bool _isExpanded = false;

  void _updateContentHeight() {
    final height = _contentKey.currentContext?.size?.height;
    if (height != null && height != _contentHeight && mounted) {
      setState(() => _contentHeight = height);
    }
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        widget.backgroundColor ?? Theme.of(context).scaffoldBackgroundColor;
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateContentHeight());

    return TweenAnimationBuilder<double>(
      tween: Tween(
        begin: _isExpanded ? _minHeight : _contentHeight,
        end: _isExpanded ? _contentHeight : _minHeight,
      ),
      duration: const Duration(milliseconds: 240),
      curve: Curves.easeInOut,
      builder: (context, height, child) => SizedBox(
        height: height,
        child: Stack(
          children: [
            ClipRect(child: child),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: AppSizes.xxl,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      backgroundColor.withAlpha(0),
                      backgroundColor,
                      backgroundColor,
                    ],
                    stops: const [0, 1 / 2, 1],
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: MBTextButton(
                    icon: _isExpanded
                        ? LucideIcons.chevron_up
                        : LucideIcons.chevron_down,
                    title: _isExpanded ? 'Ver menos' : 'Ver mais',
                    textColor: AppColors.grey700,
                    size: .small,
                    onPressed: () => setState(() {
                      _isExpanded = !_isExpanded;
                    }),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      child: OverflowBox(
        alignment: Alignment.topLeft,
        minHeight: 0,
        maxHeight: double.infinity,
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            key: _contentKey,
            padding: EdgeInsets.only(bottom: AppSizes.large),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
