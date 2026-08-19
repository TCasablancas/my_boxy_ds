import 'package:flutter/material.dart';
import 'package:my_boxy_ds/ui/mb_typography.dart';
import 'mb_button_tokens.dart';

enum MBMainInfoSquareButtonType {
  defaultType,
  light,
  dark,
  outlined,
  gray,
  disabled,
}

class MBMainInfoSquareButton extends StatelessWidget {
  final Widget icon;
  final String title;
  final String description;
  final MBMainInfoSquareButtonType type;
  final VoidCallback? onPressed;

  const MBMainInfoSquareButton({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    this.type = MBMainInfoSquareButtonType.defaultType,
    this.onPressed,
  });

  Color get _backgroundColor => switch (type) {
    MBMainInfoSquareButtonType.light => MBButtonColors.primaryLight,
    MBMainInfoSquareButtonType.dark => MBButtonColors.neutral800,
    MBMainInfoSquareButtonType.outlined => Colors.transparent,
    MBMainInfoSquareButtonType.gray => MBButtonColors.neutral200,
    MBMainInfoSquareButtonType.disabled => MBButtonColors.neutral100,
    MBMainInfoSquareButtonType.defaultType => MBButtonColors.primaryDark,
  };

  Color get _titleColor => switch (type) {
    MBMainInfoSquareButtonType.light => MBButtonColors.primaryDark,
    MBMainInfoSquareButtonType.dark => MBButtonColors.white,
    MBMainInfoSquareButtonType.outlined => MBButtonColors.mainBlue,
    MBMainInfoSquareButtonType.gray => MBButtonColors.textSecondary,
    MBMainInfoSquareButtonType.disabled => MBButtonColors.disabledText,
    MBMainInfoSquareButtonType.defaultType => MBButtonColors.white,
  };

  Color get _descriptionColor => switch (type) {
    MBMainInfoSquareButtonType.light => MBButtonColors.primary,
    MBMainInfoSquareButtonType.dark => MBButtonColors.white,
    MBMainInfoSquareButtonType.outlined ||
    MBMainInfoSquareButtonType.gray => MBButtonColors.textSecondary,
    MBMainInfoSquareButtonType.disabled => MBButtonColors.disabledText,
    MBMainInfoSquareButtonType.defaultType => MBButtonColors.primary,
  };

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _backgroundColor,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: type == MBMainInfoSquareButtonType.disabled ? null : onPressed,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 46, height: 46,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: icon,
                  ),
                  Icon(Icons.arrow_outward, size: 16, color: _titleColor),
                ],
              ),
              const SizedBox(height: 50),
              Text(
                title,
                style: mbButtonTextStyle(
                  fontSize: 16,
                  color: _titleColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                description,
                style: AppTypography.captionFn(_descriptionColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
