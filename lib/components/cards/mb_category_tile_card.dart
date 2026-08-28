import 'package:flutter/material.dart';
import 'package:my_boxy_ds/ui/design_tokens/design_tokens.dart';
import 'package:my_boxy_ds/ui/mb_typography.dart';

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
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: AppRadius.allXLarge,
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
              opacity: 0.5,
              alignment: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              title,
              style: AppTypography.h3Fn(AppColors.white, FontWeight.w700),
            ),
          ),
        )
      ),
    );
  }
}
