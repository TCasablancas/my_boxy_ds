import 'package:flutter/material.dart';
import 'package:my_boxy_ds/components/containers/mb_store_image_container.dart';
import 'package:my_boxy_ds/ui/design_tokens/design_tokens.dart';

class MBProductCardHeader extends StatelessWidget {

  final String? storeImageURL;
  final String storeName;
  // final double? rating;

  const MBProductCardHeader({
    super.key,
    this.storeImageURL,
    required this.storeName,
    // this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Row(
        spacing: 4,
        children: [
          Text(
            'Por',
            style: AppTextStyles.description.copyWith(
              letterSpacing: -0.5,
              fontSize: 11
            )
          ),
          MBStoreImageContainer(
            size: .smaller,
            url: storeImageURL ?? ''
          ),
          Expanded(
            child: Text(
              storeName,
              style: AppTextStyles.description.copyWith(
                fontSize: 11,
                letterSpacing: -0.5,
              ),
            ),
          ),
          // if (rating != null) ...[
          //   const Icon(
          //     Icons.star,
          //     size: 12,
          //     color: Color(0xFFFBBF24),
          //   ),
          //   Text(
          //     '$rating',
          //     style: const TextStyle(
          //       fontSize: 11,
          //       fontFamily: 'SFMono',
          //       letterSpacing: -0.5,
          //       color: Color(0xFF4C4C4C),
          //     ),
          //   ),
          // ],
        ],
      )
    );
  }
}