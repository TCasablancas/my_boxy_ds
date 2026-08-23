import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:my_boxy_ds/components/buttons/mb_floating_cart_btn.dart';
import 'package:my_boxy_ds/components/buttons/mb_rounded_icon_btn.dart';
import 'package:my_boxy_ds/ui/icons/mb_icons_actions.dart';
import 'package:my_boxy_ds/ui/mb_design_tokens.dart';
// import 'package:gradient_blur/gradient_blur.dart';

class MBBottomFixedMenu extends StatelessWidget {
  final VoidCallback? onNotificationsTap;
  final VoidCallback? onCartTap;
  final VoidCallback? onMenuTap;

  const MBBottomFixedMenu({
    super.key,
    required this.onNotificationsTap,
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
            spacing: 12,
            children: [
              MBRoundedIconButton(
                icon: Icon(
                  Icons.notifications_none_outlined,
                  color: AppColors.primary,
                ),
                backgroundColor: Colors.white,
                shadow: true,
                quantity: 12,
                onPressed: () => onNotificationsTap?.call(),
              ),
              MBFloatingCartButton(
                items: 3,
                onPressed: () => onCartTap?.call(),
              ),
              MBRoundedIconButton(
                icon: MBIconsActions.squareFour(
                  strokeColor: AppColors.primary,
                  size: 20,
                ),
                backgroundColor: Colors.white,
                shadow: true,
                onPressed: () => onMenuTap?.call(),
              ),
            ],
          ), 
        ),
      ),
    );
  }
}