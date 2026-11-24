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

  /// Borda opcional (ex.: verde para item já no carrinho). Sem ela, nada muda.
  final Color? borderColor;
  final VoidCallback? onTap;
  final double? width;
  final double? height;

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
    this.borderColor,
    this.onTap,
    this.width,
    this.height,
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
            width: width, height: height,
            padding: EdgeInsets.all(padding ?? 0.0),
            decoration: hasBackground == null ? BoxDecoration(
              color: backgroundColor ?? AppColors.primaryLight,
              borderRadius: radius ?? AppRadius.allXLarge,
              border: borderColor == null ? null : Border.all(color: borderColor!, width: 1.5),
            ) : borderColor == null ? null : BoxDecoration(
              borderRadius: radius ?? AppRadius.allXLarge,
              border: Border.all(color: borderColor!, width: 1.5),
            ),
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