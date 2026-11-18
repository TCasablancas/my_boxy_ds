import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:my_boxy_ds/components/buttons/buttons.dart';
import 'package:my_boxy_ds/components/containers/mb_box_rounded_container.dart';
import 'package:my_boxy_ds/components/containers/mb_rating_container.dart';
import 'package:my_boxy_ds/components/labels/mb_cutted_price_label.dart';
import 'package:my_boxy_ds/components/labels/mb_price_product_detail.dart';
import 'package:my_boxy_ds/components/mb_separator.dart';
import 'package:my_boxy_ds/ui/design_tokens/design_tokens.dart';

class MBProductPriceDetailContainer extends StatelessWidget {

  final EdgeInsets? margin;
  final double mainPrice;
  final double? discountValue;
  final String? reviews;
  final VoidCallback? onFretePressed;

  const MBProductPriceDetailContainer({
    super.key,
    this.margin,
    required this.mainPrice,
    this.reviews,
    this.discountValue,
    this.onFretePressed,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = AppTextStyles.labelSmall.copyWith(letterSpacing: -0.5);
    final bodyMediumStyle = AppTextStyles.bodyMediumStrong.copyWith(letterSpacing: -0.5);

    return MBBoxRoundedContainer(
      margin: margin,
      child: Column(
        children: [
          Row(
            children: [
              Column(
                // spacing: -4,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (discountValue != null)
                    MBCuttedPriceLabel(price: discountValue ?? 0.0),
                  MBPriceProductDetail(price: mainPrice, partDesc: 'no Pix',)
                ]
              ),
              Spacer(),
              Column(
                spacing: AppSizes.small,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  MBRatingBadge(rating: 4.5),
                  Row(
                    spacing: AppSizes.sm,
                    children: [
                      Text(reviews ?? '', style: bodyMediumStyle.copyWith(color: AppColors.focus)),
                      Text('Aval.', style: bodyMediumStyle.copyWith(color: AppColors.grey400)),
                      Icon(LucideIcons.chevron_right, size: AppSizes.medium, color: AppColors.grey400,)
                    ],
                  )
                ],
              )
            ],
          ),
          MBSeparator(color: AppColors.grey300),
          Row(
            children: [
              Row(
                children: [
                  Text('até ', style: textStyle),
                  Text('12x de ', style: textStyle),
                  Text('R\$ 2,08 ', style: bodyMediumStyle),
                  Text('no Crédito', style: textStyle),
                ],
              ),
              Spacer(),
              _freteBtn()
            ],
          ),
        ],
      ),
    );
  }

  Widget _freteBtn() {
    return SizedBox(
      height: 30,
      child: GestureDetector(
        onTap: onFretePressed,
        child: Row(
          spacing: AppSizes.small,
          children: [
            Icon(LucideIcons.truck, color: AppColors.focus, size: AppSizes.medium),
            Text(
              'Calcular frete',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.focus,
                letterSpacing: -0.5
              ),
            )
          ],
        ),
      ),
    );
  }
}