import 'package:flutter/material.dart';

import '../mb_shimmer.dart';
import 'mb_carousel_shimmer.dart';
import 'mb_product_card_shimmer.dart';

/// Uso:
///   body: isLoading ? const MBHomeShimmerView() : conteúdoReal
class MBHomeShimmerView extends StatelessWidget {
  final int gridItemCount;

  const MBHomeShimmerView({super.key, this.gridItemCount = 6});

  @override
  Widget build(BuildContext context) {
    return MBShimmer(
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 8, bottom: 24),
              child: MBCarouselShimmer(),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList.builder(
              itemCount: (gridItemCount / 2).ceil(),
              itemBuilder: (context, rowIndex) {
                final firstIndex = rowIndex * 2;
                final hasSecondCard = firstIndex + 1 < gridItemCount;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Expanded(child: MBProductCardShimmer()),
                        const SizedBox(width: 16),
                        Expanded(
                          child: hasSecondCard
                              ? const MBProductCardShimmer()
                              : const SizedBox.shrink(),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
