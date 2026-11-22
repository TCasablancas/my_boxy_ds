import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:my_boxy_ds/ui/design_tokens/design_tokens.dart';

import '../containers/mb_box_rounded_container.dart';
import '../labels/mb_price_value_label.dart';
import '../labels/mb_title_subtitled_label.dart';

class MBActionInfoBtn extends StatelessWidget {

  const MBActionInfoBtn({
    super.key,
    required this.title,
    this.descriptionType,
    this.value,
    this.icon,
    this.isValue = false,
    required this.onTap,
  });

  final String title;
  final String? descriptionType;
  final String? value;
  final IconData? icon;
  /// true: mostra [value] como preço (com [descriptionType] ao lado).
  /// false: mostra [value] e [descriptionType] como título e descrição.
  final bool isValue;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: MBBoxRoundedContainer(
        padding: const EdgeInsets.fromLTRB(
          AppSizes.small, AppSizes.small, AppSizes.medium, AppSizes.small,
        ),
        child: Row(
          spacing: AppSizes.small,
          children: [
            MBBoxRoundedContainer(
              background: AppColors.grey100,
              margin: const EdgeInsets.all(0),
              padding: const EdgeInsets.all(12.0),
              child: Icon(icon ?? LucideIcons.arrow_right, size: AppSizes.medium, color: AppColors.grey400),
            ),
            // Expanded dá largura limitada ao texto (o MBTitleSubtitled usa
            // width: double.infinity) e empurra a seta para a direita.
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.labelSmall.copyWith(
                      letterSpacing: -0.5,
                      color: AppColors.grey900,
                    ),
                  ),
                  isValue ? _buildValue() : _buildDescription(),
                ],
              ),
            ),
            Icon(LucideIcons.chevron_right, size: AppSizes.medium, color: AppColors.grey400),
          ],
        )
      ),
    );
  }

  Widget _buildValue() {
    return Row(
      spacing: AppSizes.small,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        MBPriceValueLabel(
          price: value ?? '0.00',
          size: .medium,
        ),
        Flexible(
          child: Text(
            descriptionType ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.labelSmall.copyWith(
              letterSpacing: -0.5,
              color: AppColors.grey400,
              height: 1.75,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return MBTitleSubtitled(
      title: value ?? '',
      description: descriptionType ?? '',
    );
  }
}
