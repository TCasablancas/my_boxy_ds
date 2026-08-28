import 'package:flutter/material.dart';
import 'package:my_boxy_ds/ui/design_tokens/design_tokens.dart';
import 'mb_shimmer_box.dart';

class MBProductCardShimmer extends StatelessWidget {
  const MBProductCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.allMedium,
        boxShadow: AppShadows.card,
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
            child: MBShimmerBox(width: double.infinity, height: 158),
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
