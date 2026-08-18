import 'package:flutter/material.dart';
import 'package:my_boxy_ds/ui/mb_design_tokens.dart';

class MBAddToCartBtn extends StatelessWidget {

  final VoidCallback? onPress;

  const MBAddToCartBtn({
    super.key,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primaryLight,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onPress,
        borderRadius: BorderRadius.circular(8),
        child: const Padding(
          padding: EdgeInsets.all(8),
          child: Icon(
            Icons.shopping_cart_outlined,
            size: 20,
            color: AppColors.primaryDark,
          ),
        ),
      ),
    );
  }
}