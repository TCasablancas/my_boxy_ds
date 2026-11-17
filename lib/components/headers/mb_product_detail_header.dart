import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:my_boxy_ds/components/containers/mb_store_image_container.dart';
import 'package:my_boxy_ds/components/containers/mb_simple_location_container.dart';
import 'package:my_boxy_ds/ui/design_tokens/design_tokens.dart';

class MBProductDetailHeader extends StatelessWidget {

  final String? storeImageURL;
  final String storeName;
  final double? rating;
  final VoidCallback? onTap;

  const MBProductDetailHeader({
    super.key,
    this.storeImageURL,
    required this.storeName,
    this.rating,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child:
        Row(
          spacing: 8,
          children: [
            MBStoreImageContainer(url: storeImageURL ?? '', size: .medium),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  storeName,
                  textAlign: TextAlign.left,
                  style: AppTextStyles.appBarTitle.copyWith(
                    letterSpacing: -0.5,
                    color: AppColors.grey900
                  )
                ),
                Row(
                  spacing: 2,
                  children: [
                    MBSimpleLocationContainer(location: 'Santos - SP  • '),
                    Icon(Icons.star_rounded, size: 10, color: AppColors.warning,),
                    Text(
                      '123',
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
            Icon(LucideIcons.chevron_right, size: 12, color: AppColors.grey400,)
          ],
        )
      ),
    );
  }
}