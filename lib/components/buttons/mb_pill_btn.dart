import 'package:flutter/material.dart';
import 'package:my_boxy_ds/ui/mb_typography.dart';

class MBPillBtn extends StatelessWidget {
  final String text;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final VoidCallback onPressed;

  const MBPillBtn({
    super.key,
    required this.text,
    this.color,
    this.textColor,
    this.borderColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        decoration: BoxDecoration(
          color: color ?? Colors.grey[300],
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: borderColor ?? Colors.grey[400]!,
            width: 1.0,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor ?? Colors.white,
            fontFamily: AppTypography.fontFamily,
            letterSpacing: -0.2,
          ),
        ),
      ),
    );
  }
}