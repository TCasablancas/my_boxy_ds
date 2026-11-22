import 'package:flutter/material.dart';
import 'package:my_boxy_ds/ui/design_tokens/design_tokens.dart';

class MBCardStackView extends StatelessWidget {

  const MBCardStackView({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    const int blankCardsCount = 3;
    const double horizontalSpacing = 16.0;
    const double verticalSpacing = 6.0;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          for (int i = blankCardsCount; i >= 1; i--)
            Positioned(
              top: i * verticalSpacing + 10,
              bottom: -(i * verticalSpacing -12),
              left: i * horizontalSpacing,
              right: i * horizontalSpacing,
              child: _buildEmptyCardItem(
                1.0 - (i * 0.15),
                (255 * (1.0 - (i * 0.25))).toInt()
              ),
            ),

          child,
        ],
      ),
    );
  }
  
  Widget _buildEmptyCardItem(double opacity, int alpha) {
    return Opacity(
      opacity: opacity.clamp(0.0, 1.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.grey400.withAlpha(alpha),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
      ),
    );
  }
}