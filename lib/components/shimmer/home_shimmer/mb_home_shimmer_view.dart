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
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) => const MBProductCardShimmer(),
                childCount: gridItemCount,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.7,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
