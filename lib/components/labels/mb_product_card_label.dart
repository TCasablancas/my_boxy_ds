import 'package:flutter/material.dart';
import 'package:my_boxy_ds/components/labels/mb_price_value_label.dart';
import 'package:my_boxy_ds/ui/mb_design_tokens.dart';
import 'package:my_boxy_ds/ui/mb_typography.dart';

class MBProductCardLabel extends StatelessWidget {

  final String title;
  final String price;

  const MBProductCardLabel({
    super.key,
    required this.title,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.captionFn(AppColors.textTertiary)
          ),
          MBPriceValueLabel(price: price)
        ],
      ),
    );
  }
}