import 'package:flutter/material.dart';
import 'package:my_boxy_ds/components/sidebar/mb_collapsible_sidebar.dart';
import 'package:my_boxy_ds/ui/mb_design_tokens.dart';

class MBMenuSliderBtn extends StatelessWidget {
  final MBSidebarItem item;
  final Color? background;

  const MBMenuSliderBtn({
    super.key,
    required this.item,
    this.background,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: item.onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: background != null ? (background ?? Colors.grey[600]) : null,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (item.icon != null) ...[
              item.icon!,
              const SizedBox(width: 8),
            ],
            Text(
              item.title,
              style: TextStyle(
                fontFamily: 'SFMono',
                fontSize: 22,
                fontWeight: FontWeight.w900,
                letterSpacing: -0.5,
                color: background != null ? AppColors.focus : AppColors.primaryLight,
              ),
            )
          ],
        ),
      ),
    );
  }
}