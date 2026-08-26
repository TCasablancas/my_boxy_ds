import 'package:flutter/material.dart';
import 'mb_button_tokens.dart';

enum MBTextButtonSize { small, medium, large, extraLarge }

class MBTextButton extends StatelessWidget {
  final IconData? icon;
  final String? title;
  final Color? textColor;
  final MBTextButtonSize size;
  final VoidCallback? onPressed;

  const MBTextButton({
    super.key,
    this.icon,
    this.title,
    this.textColor,
    this.size = MBTextButtonSize.medium,
    this.onPressed,
  });

  double get _fontSize => switch (size) {
    MBTextButtonSize.small => 12,
    MBTextButtonSize.medium => 14,
    MBTextButtonSize.large => 16,
    MBTextButtonSize.extraLarge => 24,
  };

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(
                icon, size: _fontSize,
                color: textColor ?? MBButtonColors.textSecondary,
              ),
              const SizedBox(width: 4)],
            Text(
              title ?? '',
              style: mbButtonTextStyle(
                fontSize: _fontSize,
                color: textColor ?? MBButtonColors.textSecondary,
              ),
            )
          ]
        )
      ),
    );
  }
}
