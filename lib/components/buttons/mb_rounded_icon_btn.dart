import 'package:flutter/material.dart';
import 'mb_button_tokens.dart';

enum MBRoundedIconButtonSize { small, medium, large }

class MBRoundedIconButton extends StatelessWidget {
  final Widget icon;
  final int? quantity;
  final Color? backgroundColor;
  final bool? shadow;
  final MBRoundedIconButtonSize buttonSize;
  final VoidCallback onPressed;

  const MBRoundedIconButton({
    super.key,
    required this.icon,
    this.quantity,
    this.backgroundColor,
    this.shadow = false,
    this.buttonSize = MBRoundedIconButtonSize.medium,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {

    double size = 40.0;

    switch (buttonSize) {
      case MBRoundedIconButtonSize.small:
        size = 24.0;
        break;
      case MBRoundedIconButtonSize.medium:
        size = 36.0;
        break;
      case MBRoundedIconButtonSize.large:
        size = 48.0;
        break;
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: (shadow ?? false) ? Colors.black.withAlpha(25) : Colors.transparent,
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
                child: SizedBox(width: size, height: size, child: Center()),
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
