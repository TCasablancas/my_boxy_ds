import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:my_boxy_ds/ui/design_tokens/design_tokens.dart';

class MBCategorySelectableTag extends StatefulWidget {
  const MBCategorySelectableTag({
    super.key,
    this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final IconData? icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  State<MBCategorySelectableTag> createState() =>
      _MBCategorySelectableTagViewState();
}

class _MBCategorySelectableTagViewState extends State<MBCategorySelectableTag> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.fromLTRB(
          AppSizes.small,
          AppSizes.small,
          AppSizes.md,
          AppSizes.small,
        ),
        decoration: BoxDecoration(
          color: widget.isSelected ? AppColors.primaryLight : AppColors.surface,
          border: Border.all(
            color: widget.isSelected ? AppColors.primary : AppColors.border,
            width: 2.0,
          ),
          borderRadius: AppRadius.allFull,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              widget.isSelected ? LucideIcons.check : widget.icon,
              size: AppSizes.medium,
              color: AppColors.primaryDark,
            ),
            const SizedBox(width: AppSizes.small),
            Text(
              widget.label,
              style: AppTextStyles.bodyMediumStrong.copyWith(
                color: widget.isSelected
                    ? AppColors.primaryDark
                    : AppColors.textPrimary,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
