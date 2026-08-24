import 'package:flutter/material.dart';
import 'package:my_boxy_ds/ui/mb_design_tokens.dart';

class MBSimpleSquareIconBtn extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? description;
  final VoidCallback onPressed;

  const MBSimpleSquareIconBtn({
    super.key,
    required this.icon,
    required this.title,
    this.description,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 80,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.grey[300]!,
            width: 1,
          )
        ),
        child: GestureDetector(
          onTap: onPressed,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, color: AppColors.primaryDark, size: 24),
                  const Spacer(),
                  Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey[400], size: 12),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Lexend',
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                  color: AppColors.primary,
                  height: 1
                ),
              ),
              description != null ? Text(
                description ?? '',
                style: TextStyle(
                  fontSize: 13,
                  fontFamily: 'Lexend',
                  fontWeight: FontWeight.w300,
                  letterSpacing: -0.5,
                  color: Colors.grey[500],
                ),
              ) : const SizedBox.shrink(),
            ]
          ),
        )
      )
    );
  }
}