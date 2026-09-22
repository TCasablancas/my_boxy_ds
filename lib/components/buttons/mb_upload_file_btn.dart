import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:my_boxy_ds/ui/design_tokens/design_tokens.dart';

class MBUploadFileButton extends StatelessWidget {

  const MBUploadFileButton({
    super.key,
    this.icon,
    this.label,
    this.onTap,
  });

  final IconData? icon;
  final String? label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 70,
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: AppSizes.medium),
        decoration: BoxDecoration(
          color: AppColors.primaryLight.withAlpha(40),
          borderRadius: BorderRadius.circular(AppSizes.small),
          border: Border.fromBorderSide(
            AppBorders.sideOf(AppColors.primaryLight, width: 3),
          )
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon ?? LucideIcons.image_plus,
                color: AppColors.primary
              ),
              Text(
                label ?? '',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.grey500,
                  letterSpacing: -0.5
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}