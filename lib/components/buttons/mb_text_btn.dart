import 'package:flutter/material.dart';

import 'mb_button_tokens.dart';

enum MBTextButtonSize { small, medium, large, extraLarge }

class MBTextButton extends StatelessWidget {
  final String? title;
  final Color? textColor;
  final MBTextButtonSize size;
  final VoidCallback? onPressed;

  const MBTextButton({
    super.key,
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
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Text(
          title ?? '',
          style: mbButtonTextStyle(
            fontSize: _fontSize,
            color: textColor ?? MBButtonColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
