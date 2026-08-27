import 'package:flutter/material.dart';
import 'package:my_boxy_ds/ui/design_tokens/design_tokens.dart';
import 'mb_shimmer_box.dart';

/// Espelha o shape do MBMainProductCard: header (avatar + nome da loja),
/// imagem e label (título + preço + botão). Usado na grid da home enquanto
/// os produtos reais não chegaram.
class MBProductCardShimmer extends StatelessWidget {
  const MBProductCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.allMedium,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withAlpha(15),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              children: [
                MBShimmerBox(width: 20, height: 20, borderRadius: AppRadius.allFull),
                SizedBox(width: 6),
                Expanded(child: MBShimmerBox(height: 10)),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 3),
            child: MBShimmerBox(width: double.infinity, height: 160),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const MBShimmerBox(width: double.infinity, height: 10),
                  const SizedBox(height: 6),
                  const MBShimmerBox(width: 60, height: 10),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      MBShimmerBox(width: 50, height: 14),
                      MBShimmerBox(width: 24, height: 24, borderRadius: AppRadius.allFull),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
