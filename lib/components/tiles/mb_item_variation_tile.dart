import 'package:flutter/material.dart';
import 'package:my_boxy_ds/components/input/input.dart';
import 'package:my_boxy_ds/ui/design_tokens/design_tokens.dart';

import '../labels/mb_title_subtitled_label.dart';

class MBItemVariationTile extends StatelessWidget {

  const MBItemVariationTile({
    super.key,
    required this.index,
    this.label,
    this.placeholder,
    required this.desController,
    required this.qtyController,
    required this.prcController
  });

  final int index;
  final String? label;
  final String? placeholder;
  final TextEditingController desController;
  final TextEditingController qtyController;
  final TextEditingController prcController;

  @override
  Widget build(BuildContext context) {
    return Column(
      // spacing: AppSizes.xs,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          MBTitleSubtitled(
            title: label ?? '',
            color: AppColors.grey500,
          ),
        Row(
          spacing: AppSizes.small,
          children: [
            Expanded(
              flex: 4,
              child: MBSimpleInput(
                hintText: 'Item',
                controller: desController
              )
            ),
            Expanded(
              child: MBSimpleInput(
                hintText: 'Qtd',
                controller: qtyController,
                keyboardType: .number,
              )
            ),
            Expanded(
              child: MBSimpleInput(
                hintText: '+R\$',
                controller: prcController,
                keyboardType: .number
              )
            ),
          ],
        ),
      ],
    );
  }
}