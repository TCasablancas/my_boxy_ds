import 'package:flutter/material.dart';
import 'package:my_boxy_ds/ui/mb_design_tokens.dart';

class MBAddToCartBtn extends StatefulWidget {

  final VoidCallback? onPress;

  const MBAddToCartBtn({
    super.key,
    required this.onPress,
  });

  @override
  State<MBAddToCartBtn> createState() => _MBAddToCartBtnState();
}

class _MBAddToCartBtnState extends State<MBAddToCartBtn>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 100),
    lowerBound: 1,
    upperBound: 1.2,
  )..value = 1;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handlePress() {
    _controller.forward().then((_) => _controller.reverse());
    widget.onPress?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primaryLight.withAlpha(120),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: _handlePress,
        borderRadius: BorderRadius.circular(8),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ScaleTransition(
            scale: _controller,
            child: const Icon(
              Icons.shopping_cart_outlined,
              size: 16,
              color: AppColors.primary,
            ),
          ),
        ),
      ),
    );
  }
}