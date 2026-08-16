import 'package:flutter/material.dart';

import 'mb_button_tokens.dart';

class MBFavoriteIconButton extends StatefulWidget {
  final bool? isActive;
  final bool defaultActive;
  final ValueChanged<bool>? onPressed;

  const MBFavoriteIconButton({
    super.key,
    this.isActive,
    this.defaultActive = false,
    this.onPressed,
  });

  @override
  State<MBFavoriteIconButton> createState() => _MBFavoriteIconButtonState();
}

class _MBFavoriteIconButtonState extends State<MBFavoriteIconButton>
    with SingleTickerProviderStateMixin {
  late bool _internalActive = widget.defaultActive;
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 100),
    lowerBound: 1,
    upperBound: 1.2,
  )..value = 1;

  bool get _isActive => widget.isActive ?? _internalActive;

  @override
  void didUpdateWidget(covariant MBFavoriteIconButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.defaultActive != widget.defaultActive &&
        widget.isActive == null) {
      _internalActive = widget.defaultActive;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handlePressed() {
    final nextActive = !_isActive;
    if (widget.isActive == null) {
      setState(() => _internalActive = nextActive);
    }
    _controller.forward().then((_) => _controller.reverse());
    widget.onPressed?.call(nextActive);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _handlePressed,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ScaleTransition(
          scale: _controller,
          child: Opacity(
            opacity: _isActive ? 1 : .7,
            child: Icon(
              _isActive ? Icons.favorite : Icons.favorite_border,
              size: 24,
              color: _isActive
                  ? MBButtonColors.mainRed
                  : MBButtonColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
