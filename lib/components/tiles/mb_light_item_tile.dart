import 'package:flutter/material.dart';
import 'package:my_boxy_ds/ui/design_tokens/design_tokens.dart';

class MBLightItemTile extends StatelessWidget {

  const MBLightItemTile({
    super.key,
    this.label,
    this.description,
    this.actionIcon,
    this.iconColor,
    this.icon,
    this.iconSize,
    this.padding,
    this.onTap,
  });

  final String? label;
  final String? description;
  final Color? iconColor;
  final IconData? icon;
  final IconData? actionIcon;
  final double? iconSize;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: padding ?? EdgeInsets.symmetric(horizontal: AppSizes.medium),
        child: Row(
          spacing: AppSizes.medium,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: iconSize ?? 24, color: iconColor ?? AppColors.neutral900),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (label != null)
                  Text(label ?? '', style: AppTextStyles.snackbar(AppColors.grey400),),
                if (description != null)
                  Text(description ?? '', style: AppTextStyles.bodyLarge,)
              ],
            ),
            Spacer(),
            Icon(actionIcon, size: 14, color: AppColors.grey600,)
          ],
        ),
      ),
    );
  }
}