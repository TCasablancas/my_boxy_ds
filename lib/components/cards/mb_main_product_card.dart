import 'package:flutter/material.dart';
import 'package:my_boxy_ds/components/buttons/mb_add_cart_btn.dart';
import 'package:my_boxy_ds/components/containers/mb_product_card_image_container.dart';
import 'package:my_boxy_ds/components/headers/mb_product_card_header.dart';
import 'package:my_boxy_ds/components/labels/mb_product_card_label.dart';
import '../buttons/mb_favorite_btn.dart';
import 'mb_product.dart';

class MBMainProductCard extends StatelessWidget {
  final MBProduct product;
  final VoidCallback? onAddToCart;

  const MBMainProductCard({ super.key, required this.product, this.onAddToCart });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: InkWell(
        onTap: product.onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Column(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MBProductCardHeader(
              storeImageURL: product.storeImageUrl,
              storeName: product.storeName,
              rating: 4.5,
            ),
            Stack(
              children: [
                MBProductCardImageContainer(url: product.imageUrl),
                Positioned(
                  top: 4, right: 8,
                  child: MBFavoriteButton(
                    isActive: product.isFavorite,
                    defaultActive: product.isFavorite ?? false,
                    onPressed: product.onFavoriteChanged,
                  ),
                ),
                Positioned(
                  bottom: 8, right: 8,
                  child: MBAddToCartBtn(onPress: () => {})
                )
              ],
            ),
            MBProductCardLabel(
              title: product.title, price: product.price
            ),
          ],
        ),
      ),
    );
  }
}
