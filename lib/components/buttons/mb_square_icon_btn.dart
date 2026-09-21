import 'package:flutter/material.dart';
import 'package:my_boxy_ds/my_boxy_ds.dart';

class MBSquareIconBtn extends StatelessWidget {

  final IconData icon;
  final String? title;
  final double? padding;
  final double? iconSize;
  final BorderRadiusGeometry? radius;
  final bool? hasBackground;
  final Color? iconColor;
  final Color? backgroundColor;
  final VoidCallback? onTap;

  const MBSquareIconBtn({
    super.key,
    required this.icon,
    this.title,
    this.padding,
    this.iconSize,
    this.radius,
    this.hasBackground,
    this.iconColor,
    this.backgroundColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 8.0,
        children: [
          Container(
            padding: EdgeInsets.all(padding ?? 16.0),
            decoration: hasBackground == null ? BoxDecoration(
              color: backgroundColor ?? AppColors.primaryLight,
              borderRadius: radius ?? AppRadius.allXLarge
            ) : null,
            child: Icon(icon, size: iconSize ?? 18, color: iconColor ?? AppColors.primaryDark)
          ),
          if (title != null)
            Text(
              title ?? '',
              style: AppTextStyles.priceInstallment,
            )
        ]
      ),
    );
  }
}