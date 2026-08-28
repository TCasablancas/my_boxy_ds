import 'package:flutter/material.dart';
import 'package:my_boxy_ds/my_boxy_ds.dart';

class MBSquareIconBtn extends StatelessWidget {

  final IconData icon;
  final String title;
  final bool? hasBackground;

  const MBSquareIconBtn({
    super.key,
    required this.icon,
    required this.title,
    this.hasBackground,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 8.0,
      children: [
        Container(
          padding: EdgeInsets.all(16.0),
          decoration: hasBackground == null ? BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: AppRadius.allXLarge
          ) : null,
          child: Icon(icon, size: 18, color: AppColors.primaryDark)
        ),
        Text(
          title,
          style: AppTextStyles.priceInstallment,
        )
      ]
    );
  }
}