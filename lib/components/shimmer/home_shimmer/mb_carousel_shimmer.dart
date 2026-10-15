import 'package:flutter/material.dart';
import 'package:my_boxy_ds/ui/design_tokens/design_tokens.dart';
import 'mb_shimmer_box.dart';

/// Espelha o MBHomeCarouselListHeader enquanto ele não carrega: card central
/// de 240 de altura com as bordas dos vizinhos aparecendo nas laterais.
class MBCarouselShimmer extends StatelessWidget {
  const MBCarouselShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final cardWidth = width * 0.85;
        final peek = (width - cardWidth) / 2 - AppSizes.small;
        return SizedBox(
          height: 240,
          child: OverflowBox(
            maxWidth: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: AppSizes.small,
              children: [
                MBShimmerBox(width: peek, height: 240, borderRadius: AppRadius.allLarge),
                MBShimmerBox(width: cardWidth, height: 240, borderRadius: AppRadius.allLarge),
                MBShimmerBox(width: peek, height: 240, borderRadius: AppRadius.allLarge),
              ],
            ),
          ),
        );
      },
    );
  }
}
