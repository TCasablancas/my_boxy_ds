import 'package:flutter/material.dart';

import 'mb_button_tokens.dart';

class MBOutlinedRoundBtn extends StatelessWidget {
  final Widget icon;
  final String text;
  final Color? backgroundColor;
  final Color textColor;
  final bool showBorder;
  final VoidCallback? onPressed;

  const MBOutlinedRoundBtn({
    super.key,
    required this.icon,
    required this.text,
    this.backgroundColor,
    this.textColor = const Color(0xFF9E9E9E), // Colors.grey[500]
    this.showBorder = true,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor ?? Colors.transparent,
      borderRadius: BorderRadius.circular(100),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(100),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            border: showBorder ? Border.all(color: MBButtonColors.border) : null,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              icon,
              const SizedBox(width: 8),
              Text(
                text,
                style: mbButtonTextStyle(fontSize: 13, color: textColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
