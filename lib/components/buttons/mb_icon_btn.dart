import 'package:flutter/material.dart';
import 'package:my_boxy_ds/my_boxy_ds.dart';

class MBIconBtn extends StatelessWidget {
  const MBIconBtn({
    super.key,
    required this.icon,
    this.onTap,
    this.size = 20.0,
    this.color = AppColors.grey500,
  });

  final IconData icon;
  final VoidCallback? onTap;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(icon, size: size, color: color),
    );
  }
}