import 'package:flutter/material.dart';
import 'package:my_boxy_ds/ui/design_tokens/design_tokens.dart';

class MBProductDetailTextCard extends StatelessWidget {
  final String title;
  final String description;
  final bool? shadow;

  const MBProductDetailTextCard({
    super.key,
    required this.title,
    required this.description,
    this.shadow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.md, vertical: AppSizes.small
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          if (shadow == true)
            BoxShadow(
              color: Colors.grey.withAlpha(30),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: Text(
              description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.bodyMedium.copyWith(
                letterSpacing: -0.5,
                color: AppColors.primary
              )
            )
          ),
          Text(
            title,
            style: AppTextStyles.labelSmall.copyWith(
              letterSpacing: -0.3
            )
          ),
        ]
      )
    );
  }
}