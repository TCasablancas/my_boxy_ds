import 'package:flutter/material.dart';
import 'package:my_boxy_ds/ui/design_tokens/design_tokens.dart';

class MBCheckoutItemTile extends StatelessWidget {

  final IconData? icon;
  final String label;
  final String description;

  const MBCheckoutItemTile({
    super.key,
    this.icon,
    required this.label,
    required this.description
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (icon != null)
          Padding(
            padding: EdgeInsets.only(right: AppSizes.small, top: AppSizes.xs),
            child: Icon(icon, color: AppColors.primaryDark, size: 16),
          ),
        Column(
          spacing: 4.0,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                label,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.2,
                  color: AppColors.neutral900
                )
            ),
            Text(
                description,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontFamily: 'Lexend',
                  fontWeight: FontWeight.w300,
                  letterSpacing: -0.2,
                  height: 1.2,
                  color: AppColors.grey600,
                )
            )
          ],
        )
      ],
    );
  }
}