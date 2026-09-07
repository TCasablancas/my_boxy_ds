import 'package:flutter/material.dart';
import 'package:my_boxy_ds/components/labels/mb_checkout_tile_price.dart';
import 'package:my_boxy_ds/components/labels/mb_price_product_detail.dart';
import 'package:my_boxy_ds/components/mb_separator.dart';
import 'package:my_boxy_ds/ui/design_tokens/design_tokens.dart';
import '../labels/mb_cutted_price_label.dart';

class MBCheckoutProductTile extends StatelessWidget {

  const MBCheckoutProductTile({ super.key });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: AppSizes.xs),
          child: Row(
            spacing: AppSizes.medium,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40, height: 40,
                decoration: BoxDecoration(
                  color: AppColors.grey200,
                  borderRadius: AppRadius.allMedium
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Vela Aromática Decorativa 200g',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: AppColors.textPrimary,
                        letterSpacing: -0.2
                      ),
                    ),
                    Text(
                      'Lavanda - 200g - Decoração',
                      style: AppTextStyles.description,
                    ),
                  ],
                )
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  MBCuttedPriceLabel(price: 239.90),
                  MBCheckoutTilePrice(price: 72.28)
                ],
              ),
            ]
          ),
        ),
        MBSeparator()
      ],
    );
  }
}