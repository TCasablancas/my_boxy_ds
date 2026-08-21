import 'package:flutter/material.dart';
import 'mb_button_tokens.dart';

class MBFloatingCartButton extends StatelessWidget {
  final int? items;
  final VoidCallback? onPressed;

  const MBFloatingCartButton({super.key, this.items, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: MBButtonColors.primaryLight,
      borderRadius: BorderRadius.circular(100),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(100),
        child: Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            // boxShadow: const [
            //   BoxShadow(
            //     color: Color.fromRGBO(23, 149, 19, .3),
            //     offset: Offset(0, 4),
            //     blurRadius: 12,
            //   ),
            // ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.shopping_cart_outlined,
                size: 16,
                color: MBButtonColors.primary,
              ),
              const SizedBox(width: 8),
              Text(
                'Carrinho',
                style: mbButtonTextStyle(
                  fontSize: 16,
                  color: MBButtonColors.primaryDark,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (items != null && items! > 0) ...[
                const SizedBox(width: 8),
                Container(
                  width: 24,
                  height: 24,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: MBButtonColors.mainRed,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '$items',
                    style: mbButtonTextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
