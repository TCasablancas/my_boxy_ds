import 'package:flutter/material.dart';
import 'package:my_boxy_ds/components/buttons/mb_square_icon_btn.dart';
import '../../ui/design_tokens/design_tokens.dart';

class MBRowActionCard extends StatelessWidget {

  final IconData? icon;
  final Widget child;
  final VoidCallback? onEdit;
  final Color? background;
  
  const MBRowActionCard({
    super.key,
    this.icon,
    required this.child,
    this.onEdit,
    this.background,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppRadius.medium),
      decoration: AppDecorations.card(
        color: background ?? AppColors.surface, 
        radius: AppRadius.allXLarge, 
        shadow: AppShadows.card,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null)
            Container(
              padding: const EdgeInsets.all(4.0),
              margin: const EdgeInsets.only(right: AppRadius.sm),
              decoration: BoxDecoration(
                borderRadius: AppRadius.allMedium,
                border: Border.all(color: AppColors.border, width: 1.0),
              ),
              child: Icon(icon ?? Icons.location_on_outlined, size: 16, color: AppColors.disabledText),
            ),
          Expanded(child: child),
          if (onEdit != null)
            MBSquareIconBtn(
              icon: Icons.edit_outlined, hasBackground: false, padding: 8.0, onTap: onEdit
            ),
        ],
      ),
    );
  }
}