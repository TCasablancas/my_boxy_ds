import 'package:flutter/material.dart';
import 'package:my_boxy_ds/components/containers/mb_store_image_container.dart';
import 'package:my_boxy_ds/components/containers/mb_simple_location_container.dart';
import 'package:my_boxy_ds/ui/mb_design_tokens.dart';

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
        child: Row(
          spacing: 8,
          children: [
            MBStoreImageContainer(url: storeImageURL ?? '', size: StoreImageSize.medium),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  storeName,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 13,
                    fontFamily: 'Lexend',
                    letterSpacing: -0.2,
                    color: AppColors.primaryDark,
                  ),
                ),
                const SizedBox(height: 4),
                MBSimpleLocationContainer(location: 'Santos - SP'),
              ],
            )
          ],
        )
      ),
    );
  }
}