import 'package:flutter/material.dart';

import 'mb_button_tokens.dart';

class MBRoundedIconButton extends StatelessWidget {
  final Widget icon;
  final int? quantity;
  final Color? backgroundColor;
  final bool? shadow;
  final VoidCallback onPressed;

  const MBRoundedIconButton({
    super.key,
    required this.icon,
    this.quantity,
    this.backgroundColor,
    this.shadow = false,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: (shadow ?? false) ? Colors.black.withValues(alpha: 0.1) : Colors.transparent,
                blurRadius: 8.0,
                spreadRadius: 2.0,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Material(
            color: backgroundColor ?? MBButtonColors.border,
            shape: const CircleBorder(),
            child: InkWell(
              onTap: onPressed,
              customBorder: const CircleBorder(),
              child: const SizedBox(width: 40, height: 40, child: Center()),
            ),
          )
        ),
        Positioned.fill(
          child: IgnorePointer(
            child: Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: Center(child: icon),
              ),
            ),
          ),
        ),
        if (quantity != null)
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 16,
              height: 16,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Text(
                '$quantity',
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'SFMono',
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
