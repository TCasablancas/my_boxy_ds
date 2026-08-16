import 'package:flutter/material.dart';

import 'mb_button_tokens.dart';

class MBOutlinedSmallButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;

  const MBOutlinedSmallButton({super.key, required this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: MBButtonColors.backgroundAlt,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            border: Border.all(color: MBButtonColors.border),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: mbButtonTextStyle(
              fontSize: 12,
              color: MBButtonColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
