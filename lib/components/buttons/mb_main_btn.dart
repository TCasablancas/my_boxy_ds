import 'package:flutter/material.dart';
import 'mb_button_tokens.dart';

enum MBMainButtonType { normal, dark, light, disabled, custom, outlined }

class MBMainButton extends StatelessWidget {
  final String title;
  final String? text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final TextAlign textAlign;
  final MBMainButtonType buttonType;
  final Color? backgroundColor;
  final Color? textColor;
  final int? flex;

  const MBMainButton({
    super.key,
    String? title,
    this.text,
    this.onPressed,
    this.icon,
    this.textAlign = TextAlign.center,
    this.buttonType = MBMainButtonType.normal,
    this.backgroundColor,
    this.textColor,
    this.flex,
  }) : assert(title != null || text != null),
       title = title ?? text ?? '';

  Color get _backgroundColor => switch (buttonType) {
    MBMainButtonType.dark => MBButtonColors.primaryDark,
    MBMainButtonType.light => MBButtonColors.primaryLight,
    MBMainButtonType.disabled => const Color(0xFFD6D6D6),
    MBMainButtonType.custom => backgroundColor ?? MBButtonColors.primary,
    MBMainButtonType.outlined => Colors.transparent,
    MBMainButtonType.normal => MBButtonColors.primary,
  };

  Color get _textColor {
    if (buttonType == MBMainButtonType.disabled) return const Color(0xFF8A8A8A);
    if (buttonType == MBMainButtonType.normal) return Colors.white;
    if (buttonType == MBMainButtonType.light ||
        buttonType == MBMainButtonType.outlined) {
      return MBButtonColors.primaryDark;
    }

    return textColor ?? Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    final button = Material(
      color: _backgroundColor,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: buttonType == MBMainButtonType.disabled ? null : onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          height: 50,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: buttonType == MBMainButtonType.outlined
              ? Border.all(color: MBButtonColors.primary) : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  color: _textColor
                ), 
                const SizedBox(width: 8)
              ],
              Flexible(
                child: Text(
                  title,
                  textAlign: textAlign,
                  style: mbButtonTextStyle(fontSize: 16, color: _textColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    return flex == null ? button : Expanded(flex: flex!, child: button);
  }
}
