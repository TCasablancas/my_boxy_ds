import 'package:flutter/material.dart';
import 'package:my_boxy_ds/ui/design_tokens/design_tokens.dart';
import 'mb_shimmer_box.dart';

/// Espelha o espaço do MBHomeCarouselListHeader (altura 240) enquanto
/// o carrossel real não carrega.
class MBCarouselShimmer extends StatelessWidget {
  const MBCarouselShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: MBShimmerBox(
        width: double.infinity,
        height: 240,
        borderRadius: AppRadius.allLarge,
      ),
    );
  }
}
