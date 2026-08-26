import 'package:flutter/material.dart';
import 'package:my_boxy_ds/ui/mb_design_tokens.dart';

class MBFullRightIconBtn extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback onPressed;

  const MBFullRightIconBtn({
    super.key,
    required this.text,
    this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.primaryLight,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Lexend',
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.2,
                  height: 1,
                  color: AppColors.primaryDark, 
                ),
              ),
              // const Spacer(),
              const SizedBox(width: 8),
              Icon(icon, color: AppColors.primaryDark, size: 16),
            ],
          ),
        ),
      )
    );
  }
}