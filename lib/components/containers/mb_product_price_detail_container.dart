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
  final VoidCallback? onFretePressed;

  const MBProductPriceDetailContainer({
    super.key,
    this.margin,
    this.onFretePressed,
  });

  @override
  Widget build(BuildContext context) {
    return MBBoxRoundedContainer(
      margin: margin,
      child: Column(
        children: [
          Row(
            children: [
              _mainPrice(),
              Spacer(),
              _reviews()
            ],
          ),
          MBSeparator(color: AppColors.grey300),
          Row(
            children: [
              _installmentText(),
              Spacer(),
              _freteBtn()
            ],
          ),
        ],
      ),
    );
  }

  Widget _mainPrice() {
    return Column(
      // spacing: -4,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MBCuttedPriceLabel(price: 54.0),
        MBPriceProductDetail(price: 25.0, partDesc: 'no Pix',)
      ]
    );
  }

  Widget _reviews() {
    return Column(
      spacing: AppSizes.small,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        MBRatingBadge(rating: 4.5),
        Row(
          spacing: AppSizes.sm,
          children: [
            Text('128', style: AppTextStyles.bodyMediumStrong.copyWith(letterSpacing: -0.5)),
            Text('Reviews', style: AppTextStyles.bodyMedium.copyWith(letterSpacing: -0.5))
          ],
        )
      ],
    );
  }

  Widget _installmentText() {
    final textStyle = AppTextStyles.labelSmall.copyWith(letterSpacing: -0.5);

    return Row(
      children: [
        Text('até ', style: textStyle),
        Text('12x de ', style: textStyle),
        Text('R\$ 2,08 ', style: AppTextStyles.bodyMedium.copyWith(letterSpacing: -0.5)),
        Text('no Crédito', style: textStyle),
      ],
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