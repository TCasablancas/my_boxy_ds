import 'package:flutter/material.dart';

import '../../ui/design_tokens/design_tokens.dart';

/// Barras com a quantidade de avaliações por nota, de 5 a 1.
/// Tocar numa barra emite a nota em [onRatingTap]; notas em [selectedRatings]
/// ficam destacadas (uso típico: filtro da lista de comentários).
class MBRatingDistributionCard extends StatelessWidget {
  /// Quantidade por nota (1 a 5). Nota ausente conta como 0.
  final Map<int, int> counts;
  final Set<int> selectedRatings;
  final ValueChanged<int>? onRatingTap;
  final Color barColor;

  const MBRatingDistributionCard({
    super.key,
    required this.counts,
    this.selectedRatings = const {},
    this.onRatingTap,
    this.barColor = AppColors.warning,
  });

  @override
  Widget build(BuildContext context) {
    final total = counts.values.fold<int>(0, (sum, c) => sum + c);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var rating = 5; rating >= 1; rating--)
          _RatingBar(
            rating: rating,
            count: counts[rating] ?? 0,
            fraction: total == 0 ? 0 : (counts[rating] ?? 0) / total,
            selected: selectedRatings.contains(rating),
            dimmed: selectedRatings.isNotEmpty && !selectedRatings.contains(rating),
            color: barColor,
            onTap: onRatingTap == null ? null : () => onRatingTap!(rating),
          ),
      ],
    );
  }
}

class _RatingBar extends StatelessWidget {
  final int rating;
  final int count;
  final double fraction;
  final bool selected;
  final bool dimmed;
  final Color color;
  final VoidCallback? onTap;

  const _RatingBar({
    required this.rating,
    required this.count,
    required this.fraction,
    required this.selected,
    required this.dimmed,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = selected ? AppColors.textPrimary : AppColors.textSecondary;
    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.allSmall,
      child: Opacity(
        opacity: dimmed ? 0.4 : 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSizes.sm),
          child: Row(
            spacing: AppSizes.small,
            children: [
              Text('$rating', style: AppTextStyles.labelSmallOf(textColor)),
              Icon(Icons.star_rounded, size: AppSizes.medium, color: color),
              Expanded(
                child: ClipRRect(
                  borderRadius: AppRadius.allSmall,
                  child: LinearProgressIndicator(
                    value: fraction,
                    minHeight: AppSizes.small,
                    color: color,
                    backgroundColor: AppColors.neutral100,
                  ),
                ),
              ),
              SizedBox(
                width: AppSizes.xl,
                child: Text(
                  '$count',
                  textAlign: TextAlign.end,
                  style: AppTextStyles.labelSmallOf(textColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
