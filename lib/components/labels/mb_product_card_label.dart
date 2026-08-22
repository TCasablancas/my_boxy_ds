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
      child: Container(
        height: 48,
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(8.0),
            bottomRight: Radius.circular(8.0),
          ),
          border: Border(
            bottom: BorderSide(
              color: Colors.grey[300]!, // Choose your border color
              width: 1.0,          // Choose your border thickness
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.captionFn(AppColors.textPrimary)
            ),
            MBPriceValueLabel(price: price)
          ],
        ),
      ),
    );
  }
}