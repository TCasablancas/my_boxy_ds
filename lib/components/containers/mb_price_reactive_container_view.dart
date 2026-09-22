import 'package:flutter/material.dart';
import 'package:my_boxy_ds/ui/design_tokens/design_tokens.dart';
import '../labels/mb_price_value_label.dart';

class MBPriceReactiveContainerView extends StatelessWidget {

  const MBPriceReactiveContainerView({
    super.key,
    required this.label,
    required this.price,
    this.background,
    this.labelColor,
    this.priceColor,
    this.child,
  });

  final String label;
  final String price;
  final Color? background;
  final Color? labelColor;
  final Color? priceColor;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: AppSizes.md,
      ),
      decoration: BoxDecoration(
        color: background ?? AppColors.grey100,
        borderRadius: BorderRadius.circular(AppSizes.md),
      ),
      child: Column(
        children: [
          Text(label, style: AppTextStyles.appBarTitle.copyWith(
            color: labelColor ?? AppColors.grey500,
            letterSpacing: -0.5
          )),
          child ??
            MBPriceValueLabel(
              price: price,
              alignment: .center,
              size: .medium,
              color: priceColor ?? AppColors.focus,
            )
        ],
      ),
    );
  }
}