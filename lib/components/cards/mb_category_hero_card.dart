import 'package:flutter/material.dart';
import 'package:my_boxy_ds/ui/design_tokens/design_tokens.dart';
import 'package:my_boxy_ds/ui/mb_typography.dart';

/// Card grande em destaque: título + subtítulo + badge, com a imagem
/// "sangrando" pra fora do card (Stack sem clip). Referência: hero card
/// tipo "Shoes / 129 Products" de telas de coleção/loja.
class MBCategoryHeroCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String badgeText;
  final String imageUrl;
  final VoidCallback? onTap;

  const MBCategoryHeroCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.badgeText,
    required this.imageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.allXLarge,
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppRadius.allXLarge,
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: AppTypography.h2Fn(AppColors.textPrimary)),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: 170,
                        child: Text(subtitle, style: AppTypography.descriptionFn(AppColors.textSecondary)),
                      ),
                    ],
                  ),
                  _badge(badgeText),
                ],
              ),
            ),
            Positioned(
              right: 8,
              top: -18,
              bottom: 0,
              child: Image.network(
                imageUrl,
                width: 170,
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

  Widget _badge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.lightBackground,
        borderRadius: AppRadius.allFull,
      ),
      child: Text(
        text,
        style: AppTypography.captionFn(AppColors.textPrimary).copyWith(fontWeight: FontWeight.w500),
      ),
    );
  }
}
