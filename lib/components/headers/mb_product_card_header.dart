import 'package:flutter/material.dart';
import 'package:my_boxy_ds/components/containers/mb_store_image_small_container.dart';

class MBProductCardHeader extends StatelessWidget {

  final String? storeImageURL;
  final String storeName;
  final double? rating;

  const MBProductCardHeader({
    super.key,
    this.storeImageURL,
    required this.storeName,
    this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 4,
      children: [
        MBStoreImageSmallContainer(url: storeImageURL ?? ''),
        Expanded(
          child: Text(
            storeName,
            style: const TextStyle(
              fontSize: 10,
              fontFamily: 'SFMono',
              letterSpacing: -0.5,
              color: Color(0xFF111827),
            ),
          ),
        ),
        if (rating != null) ...[
          const Icon(
            Icons.star,
            size: 12,
            color: Color(0xFFFBBF24),
          ),
          Text(
            '$rating',
            style: const TextStyle(
              fontSize: 11,
              fontFamily: 'SFMono',
              letterSpacing: -0.5,
              color: Color(0xFF4C4C4C),
            ),
          ),
        ],
      ],
    );
  }
}