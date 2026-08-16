import 'package:flutter/foundation.dart';

class MBProduct {
  final String productId;
  final String title;
  final String price;
  final String imageUrl;
  final String storeName;
  final String storeImageUrl;
  final num? rating;
  final bool? isFavorite;
  final VoidCallback? onPressed;
  final ValueChanged<bool>? onFavoriteChanged;

  const MBProduct({
    required this.productId,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.storeName,
    required this.storeImageUrl,
    this.rating,
    this.isFavorite,
    this.onPressed,
    this.onFavoriteChanged,
  });
}
