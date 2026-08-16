import 'package:flutter/material.dart';
import '../../ui/mb_design_tokens.dart';
import '../../ui/mb_typography.dart';

class MBListComponentCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const MBListComponentCard({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 4),
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Material(
        elevation: 0,
        shadowColor: Colors.transparent,
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.sm),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadius.md),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              children: [
                Expanded(
                  child: Text(title, style: AppTypography.body1),
                ),
                const Icon(Icons.chevron_right, color: AppColors.textTertiary),
              ],
            ),
          ),
        ),
      ),
    );
  }
}