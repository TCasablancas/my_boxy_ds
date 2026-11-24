import 'package:flutter/material.dart';
import 'package:my_boxy_ds/ui/design_tokens/design_tokens.dart';

class MBSimpleSquareIconBtn extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? description;
  final bool? shadow;
  final Color? backgroundColor;
  final VoidCallback? onPressed;

  const MBSimpleSquareIconBtn({
    super.key,
    required this.icon,
    required this.title,
    this.description,
    this.shadow,
    this.backgroundColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          height: 72,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: backgroundColor ?? AppColors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              if (shadow ?? true)
                BoxShadow(
                  color: AppColors.grey600.withAlpha(30),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(0, 2), // changes position of shadow
                ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: AppColors.grey400, size: AppSizes.medium),
              const Spacer(),
              Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  fontFamily: 'Lexend',
                  fontWeight: FontWeight.w400,
                  letterSpacing: -0.5,
                  color: AppColors.primary,
                  height: 1
                ),
              ),
              description != null ? Text(
                description ?? '',
                style: TextStyle(
                  fontSize: 12,
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