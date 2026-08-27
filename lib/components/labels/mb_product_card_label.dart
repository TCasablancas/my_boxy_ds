import 'package:flutter/material.dart';
import 'package:my_boxy_ds/components/buttons/mb_add_cart_btn.dart';
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
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(8.0),
            bottomRight: Radius.circular(8.0),
          ),
          border: Border(
            bottom: BorderSide(
              color: Colors.grey[300]!,
              width: 1.0,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.descriptionFn(AppColors.textPrimary).copyWith(
                fontWeight: FontWeight.w300,
                letterSpacing: -0.2,
              ),
              // style: TextStyle(
              //   fontSize: 14,
              //   fontFamily: 'Gloock-Regular',
              // ),
            ),
            const Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                MBPriceValueLabel(price: price),
                const Spacer(),
                MBAddToCartBtn(onPress: () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }
}