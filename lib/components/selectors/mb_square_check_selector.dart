import 'package:flutter/material.dart';
import 'package:my_boxy_ds/ui/design_tokens/design_tokens.dart';

import 'mb_main_selector.dart';

class MBSquareCheckSelector extends StatelessWidget {
  const MBSquareCheckSelector({
    super.key,
    required this.label,
    required this.isSelected,
    this.onTap,
    this.onSelectionChanged,
    this.background,
    this.border,
  });

  final String label;
  final bool isSelected;
  final VoidCallback? onTap;
  final ValueChanged<bool>? onSelectionChanged;
  final Color? background;
  final Border? border;

  void _toggleSelection() {
    onSelectionChanged?.call(!isSelected);
    onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.transparent,
      borderRadius: BorderRadius.circular(AppSizes.medium),
      child: InkWell(
        onTap: onSelectionChanged == null && onTap == null
          ? null : _toggleSelection,
        borderRadius: BorderRadius.circular(AppSizes.medium),
        child: Container(
          padding: EdgeInsets.all(AppSizes.md),
          decoration: BoxDecoration(
            color: background ?? AppColors.white,
            borderRadius: BorderRadius.circular(AppSizes.medium),
            border: border,
          ),
          child: Row(
            spacing: AppSizes.sm,
            children: [
              MBMainSelector(
                value: isSelected ? 'on' : 'off',
              ),
              Text(
                label,
                style: AppTextStyles.appBarTitle.copyWith(
                  color: AppColors.grey900,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
