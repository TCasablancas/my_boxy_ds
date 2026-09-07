import 'package:flutter/material.dart';

import '../../ui/design_tokens/design_tokens.dart';
import '../buttons/mb_icon_btn.dart';
import '../counter/mb_main_counter.dart';
import '../labels/mb_cutted_price_label.dart';
import '../labels/mb_price_value_label.dart';
import '../mb_separator.dart';
import '../selectors/mb_main_selector.dart';

import 'package:flutter_lucide/flutter_lucide.dart';

class MBCartItemTile extends StatelessWidget {
  final String imgUrl;
  final String title;
  final double price;
  final double? oldPrice;
  final int count;
  final ValueChanged<int> onCountChanged;
  final VoidCallback? onTapMore;
  final bool isSelected;
  final ValueChanged<int> onSelectionChanged;

  const MBCartItemTile({
    super.key,
    required this.imgUrl,
    required this.title,
    required this.price,
    this.oldPrice,
    required this.count,
    required this.onCountChanged,
    this.onTapMore,
    required this.isSelected,
    required this.onSelectionChanged,
  }) : assert(count >= 0);

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSizes.small,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          margin: EdgeInsets.only(top: 8.0),
          child: GestureDetector(
            onTap: () => onSelectionChanged(count),
            child: Row(
              spacing: AppSizes.small,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: MBMainSelector(
                    value: isSelected ? 'on' : 'off',
                    onChange: () => onSelectionChanged(count),
                  ),
                ),
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: AppColors.grey500,
                    borderRadius: BorderRadius.circular(AppSizes.medium),
                  ),
                  child: Image.network(imgUrl, fit: BoxFit.cover),
                ),
                Expanded(
                  child: Column(
                    spacing: AppSizes.small,
                    children: [
                      Row(
                        spacing: AppSizes.medium,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.grey900,
                              ),
                            ),
                          ),
                          MBIconBtn(
                            icon: LucideIcons.ellipsis,
                            onTap: onTapMore,
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            spacing: AppSizes.small,
                            children: [
                              MBPriceValueLabel(price: price.toString()),
                              if (oldPrice != null)
                                MBCuttedPriceLabel(price: oldPrice ?? 0.0),
                            ],
                          ),
                          Spacer(),
                          MBMainCounter(
                            count: count,
                            onChanged: onCountChanged,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        MBSeparator(),
      ],
    );
  }
}
