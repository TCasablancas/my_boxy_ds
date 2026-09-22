import 'package:flutter/material.dart';
import 'package:my_boxy_ds/ui/design_tokens/design_tokens.dart';

class MBColoredBoxLabelView extends StatelessWidget {

  const MBColoredBoxLabelView({
    super.key,
    required this.label,
    this.color,
  });

  final String label;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: AppSizes.sm,
          horizontal: AppSizes.small
      ),
      decoration: BoxDecoration(
        color: color?.withAlpha(20) ?? AppColors.focus.withAlpha(20),
        borderRadius: BorderRadius.circular(AppSizes.small),
      ),
      child: Text(
        label,
        style: AppTextStyles.priceInstallment.copyWith(
          color: color ?? AppColors.focus,
          letterSpacing: -0.5,
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
      ),
    );
  }
}