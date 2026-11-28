import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:my_boxy_ds/components/containers/mb_store_image_container.dart';
import 'package:my_boxy_ds/components/containers/mb_simple_location_container.dart';
import 'package:my_boxy_ds/ui/design_tokens/design_tokens.dart';

class MBProductDetailHeader extends StatelessWidget {

  final String? imageURL;
  final String title;
  final String? rating;
  final String? location;
  final VoidCallback? onTap;

  const MBProductDetailHeader({
    super.key,
    this.imageURL,
    required this.title,
    this.rating,
    this.location,
    this.onTap,
  });

  /// Sem [location] e sem [rating] a linha de localização/nota some (ex.: cabeçalho
  /// só com foto e nome do produto). Sem [onTap] não mostra a seta.
  bool get _hasDetails => location != null || rating != null;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.sm, vertical: 0
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: AppRadius.allFull,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child:
          Row(
            spacing: 8,
            children: [
              MBStoreImageContainer(url: imageURL ?? '', size: .medium),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.left,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.appBarTitle.copyWith(
                        letterSpacing: -0.5,
                        color: AppColors.grey900
                      )
                    ),
                    if (_hasDetails) Row(
                      spacing: 2,
                      children: [
                        MBSimpleLocationContainer(location: '$location  • '),
                        Icon(Icons.star_rounded, size: 10, color: AppColors.warning,),
                        Text(
                          rating ?? '',
                          style: AppTextStyles.appBarTitle.copyWith(
                            letterSpacing: -0.5,
                            fontSize: 12,
                            height: 1.4,
                            color: AppColors.grey900
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              if (onTap != null) Icon(LucideIcons.chevron_right, size: 12, color: AppColors.grey400,)
            ],
          )
        ),
      ),
    );
  }
}