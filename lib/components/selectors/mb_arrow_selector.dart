import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:my_boxy_ds/components/containers/mb_main_view.dart';
import 'package:my_boxy_ds/ui/design_tokens/design_tokens.dart';

class MBArrowSelector extends StatelessWidget {

  const MBArrowSelector({
    super.key,
    required this.label,
    required this.icon,
    this.padding,
  });

  final String label;
  final IconData? icon;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: AppSizes.medium),
      child: Container(
        padding: const EdgeInsets.all(AppSizes.medium),
        decoration: BoxDecoration(
          // border: Border.all(color: AppColors.grey300),
          borderRadius: BorderRadius.circular(AppSizes.medium),
          color: AppColors.grey100
        ),
        child: Row(
          spacing: AppSizes.small,
          children: [
            Icon(icon ?? LucideIcons.x, size: 16, color: AppColors.grey600),
            Text(
              label,
              style: AppTextStyles.bodyMedium.copyWith(
                letterSpacing: -0.5,
                color: AppColors.grey700
              ),
            ),
            Spacer(),
            Icon(LucideIcons.chevron_right, size: 20, color: AppColors.grey600),
          ]
        ),
      )
    );
  }
}