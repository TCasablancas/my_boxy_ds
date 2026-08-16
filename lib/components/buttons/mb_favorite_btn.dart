import 'package:flutter/material.dart';

import 'mb_button_tokens.dart';
import 'mb_favorite_icon_btn.dart';

class MBFavoriteButton extends StatelessWidget {
  final bool? isActive;
  final bool background;
  final bool defaultActive;
  final ValueChanged<bool>? onPressed;

  const MBFavoriteButton({
    super.key,
    this.isActive,
    this.background = false,
    this.defaultActive = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: background ? MBButtonColors.backgroundAlt : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: MBFavoriteIconButton(
        isActive: isActive,
        defaultActive: defaultActive,
        onPressed: onPressed,
      ),
    );
  }
}
