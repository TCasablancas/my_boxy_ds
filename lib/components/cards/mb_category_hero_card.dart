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
      child: Stack(
        children: [
          Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: AppRadius.allXLarge,
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
                opacity: 0.5
              ),
            ),
            child: SizedBox()
          ),
          Positioned(
            top: 16, left: 16, bottom: 16, right: 16,
            child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    spacing: 16.0,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage('https://mir-s3-cdn-cf.behance.net/project_modules/max_632_webp/a952e564478599.5ad423b4b3883.jpg'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(AppRadius.lg)
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title, style: AppTypography.h2Fn(Colors.white).copyWith(
                            fontFamily: 'Gloock',
                            fontSize: 28,
                            letterSpacing: 0.2
                          )),
                          SizedBox(
                            width: 170,
                            child: Text(subtitle, style: AppTypography.descriptionFn(AppColors.white)),
                          ),
                        ],
                      )
                    ],
                  ),
                  const Spacer(),
                  _badge(badgeText)
                ],
              )
            ),
          )
        ],
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
