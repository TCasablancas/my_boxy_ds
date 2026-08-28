import 'package:flutter/material.dart';
import 'package:my_boxy_ds/my_boxy_ds.dart';

enum StoreImageSize {
  small,
  medium,
  large,
}

class MBStoreImageContainer extends StatelessWidget {

  final String url;
  final StoreImageSize? size;

  const MBStoreImageContainer({
    super.key,
    required this.url,
    this.size = StoreImageSize.small,
  });

  @override
  Widget build(BuildContext context) {
    final basedSize = size == StoreImageSize.small 
      ? 20.0 : size == StoreImageSize.medium ? 36.0 : 60.0;
    final basedBorder = size == StoreImageSize.small ? AppRadius.allMedium 
      : size == StoreImageSize.medium ? AppRadius.allLarge : AppRadius.allLarge;

    return ClipRRect(
      borderRadius: basedBorder,
      child: SizedBox(
        width: basedSize,
        height: basedSize,
        child: Image.network(
          url,
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) => const ColoredBox(color: AppColors.errorBackground),
        ),
      )
    );
  }
}