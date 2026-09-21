import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:my_boxy_ds/components/buttons/mb_square_icon_btn.dart';
import 'package:my_boxy_ds/components/mb_separator.dart';
import 'package:my_boxy_ds/ui/design_tokens/design_tokens.dart';

class MBAddressItemButton extends StatelessWidget {
  const MBAddressItemButton({
    super.key,
    required this.title,
    required this.address,
    required this.isSelected,
    this.iconName = 'house',
    this.icon,
    this.onTap,
    this.onTapEdit,
    this.onTapDelete,
  });

  final String title;
  final String address;
  final bool isSelected;
  final String iconName;
  final IconData? icon;
  final VoidCallback? onTap;
  final VoidCallback? onTapEdit;
  final VoidCallback? onTapDelete;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(
          AppSizes.medium, AppSizes.md, AppSizes.md, AppSizes.md
        ),
        decoration: BoxDecoration(
          color: AppColors.grey100,
          borderRadius: BorderRadius.circular(AppSizes.medium),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.grey200,
            width: 3,
          ),
        ),
        child: Row(
          spacing: AppSizes.small,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: AppSizes.small,
                children: [
                  Row(
                    spacing: AppSizes.small,
                    children: [
                      Icon(
                        icon ?? MBAddressLucideIcons.fromName(iconName),
                        color: AppColors.primary,
                        size: 16,
                      ),
                      Text(
                        title,
                        style: AppTextStyles.bodyLarge.copyWith(
                          letterSpacing: -0.5,
                          color: AppColors.primaryDark,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                  Text(
                    address,
                    style: AppTextStyles.appBarTitle.copyWith(letterSpacing: -0.5),
                  ),
                ],
              )
            ),
            Column(
              spacing: AppSizes.small,
              children: [
                MBSquareIconBtn(
                  icon: LucideIcons.pen_line,
                  iconColor: AppColors.primary,
                  iconSize: 12,
                  padding: 12,
                  radius: BorderRadius.circular(14.0),
                  backgroundColor: AppColors.grey200,
                  onTap: onTapEdit,
                ),
                MBSquareIconBtn(
                  icon: LucideIcons.trash,
                  iconColor: AppColors.error,
                  iconSize: 12,
                  padding: 12,
                  radius: BorderRadius.circular(14.0),
                  backgroundColor: AppColors.grey200,
                  onTap: onTapDelete,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

abstract final class MBAddressLucideIcons {
  static IconData fromName(String name) {
    return switch (name
        .trim()
        .toLowerCase()
        .replaceAll('-', '_')
        .replaceFirst('lucideicons.', '')) {
      'house' => LucideIcons.house,
      'building_2' => LucideIcons.building,
      'briefcase_business' => LucideIcons.briefcase_business,
      'landmark' => LucideIcons.landmark,
      'map_pin' => LucideIcons.map_pin,
      'map_pinned' => LucideIcons.map_pinned,
      _ => throw ArgumentError.value(
        name,
        'name',
        'Unsupported address Lucide icon.',
      ),
    };
  }
}
