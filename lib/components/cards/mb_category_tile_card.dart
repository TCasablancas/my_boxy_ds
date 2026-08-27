import 'package:flutter/material.dart';
import 'package:my_boxy_ds/ui/design_tokens/design_tokens.dart';
import 'package:my_boxy_ds/ui/mb_typography.dart';

/// Card pequeno pra usar em pares lado a lado (ex: duas coleções em destaque).
/// Mesma linguagem visual do MBCategoryHeroCard, só menor e sem subtítulo/badge.
class MBCategoryTileCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final VoidCallback? onTap;

  const MBCategoryTileCard({
    super.key,
    required this.title,
    required this.imageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.allXLarge,
      child: Container(
        height: 140,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppRadius.allXLarge,
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                title,
                style: AppTypography.h3Fn(AppColors.textPrimary, FontWeight.w700),
              ),
            ),
            Positioned(
              right: -4,
              top: -12,
              bottom: 0,
              child: Image.network(
                imageUrl,
                width: 110,
                fit: BoxFit.contain,
                alignment: Alignment.bottomCenter,
                errorBuilder: (_, _, _) => const SizedBox(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
