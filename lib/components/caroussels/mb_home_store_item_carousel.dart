import 'package:flutter/material.dart';
import 'package:my_boxy_ds/components/buttons/mb_favorite_icon_btn.dart';
import 'package:my_boxy_ds/components/cards/mb_carousel_store_products.dart';
import 'package:my_boxy_ds/components/cards/mb_product.dart';
import 'package:my_boxy_ds/components/headers/mb_product_card_header.dart';

class MBHomeStoreItemCarousel extends StatelessWidget {
  final String storeName;
  final List<MBProduct> products;
  final bool? isStoreFavorite;
  final ValueChanged<String> onPressProduct;
  final ValueChanged<bool>? onToggleStoreFavorite;
  final void Function(String productId, bool nextActive)?
  onToggleProductFavorite;

  const MBHomeStoreItemCarousel({
    super.key,
    required this.storeName,
    required this.products,
    this.isStoreFavorite,
    required this.onPressProduct,
    this.onToggleStoreFavorite,
    this.onToggleProductFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final firstProduct = products.isNotEmpty ? products.first : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: MBProductCardHeader(
                  storeImageURL: firstProduct?.storeImageUrl,
                  storeName: storeName,
                  rating: firstProduct?.rating?.toDouble(),
                ),
              ),
              MBFavoriteIconButton(
                isActive: isStoreFavorite,
                defaultActive: isStoreFavorite ?? false,
                onPressed: onToggleStoreFavorite,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return MBCarouselStoreProducts(
                product: product,
                onPressed: () => onPressProduct(product.productId),
              );
            },
          ),
        ),
      ],
    );
  }
}
