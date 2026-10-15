import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:my_boxy_ds/my_boxy_ds.dart';
// import 'package:my_boxy_ds/ui/mb_design_tokens.dart';
// import 'package:gradient_blur/gradient_blur.dart';

class MBBottomFixedMenu extends StatelessWidget {
  final IconData? extraActionIcon;
  final VoidCallback? onExtraActionTap;
  final VoidCallback? onCartTap;
  final VoidCallback? onMenuTap;

  const MBBottomFixedMenu({
    super.key,
    this.extraActionIcon,
    required this.onExtraActionTap,
    required this.onCartTap,
    required this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 3.0, sigmaY: 3.0,
        ),
        child: Container(
          width: 240.0,
          height: 80,
          padding: const EdgeInsets.only(bottom: 16.0),
          // decoration: BoxDecoration(
          //   color: AppColors.surface,
          //   borderRadius: BorderRadius.circular(8),
          // ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: AppSizes.small,
            children: [
              MBRoundedIconButton(
                // icon: Icon(
                //   extraActionIcon ?? Icons.notifications_none_outlined,
                //   color: AppColors.primary,
                // ),
                icon: LucideIcons.bell_off,
                backgroundColor: Colors.white,
                width: 50, height: 50,
                // shadow: false,
                // quantity: 12,
                onPressed: () => onExtraActionTap?.call(),
              ),
              MBFloatingCartButton(
                items: 3,
                onPressed: () => onCartTap?.call(),
              ),
              MBRoundedIconButton(
                // icon: MBIconsActions.squareFour(
                //   strokeColor: AppColors.primary,
                //   size: 20,
                // ),
                icon: LucideIcons.text_align_justify,
                width: 50, height: 50,
                backgroundColor: Colors.white,
                // shadow: false,
                onPressed: () => onMenuTap?.call(),
              ),
            ],
          ), 
        ),
      ),
    );
  }
}