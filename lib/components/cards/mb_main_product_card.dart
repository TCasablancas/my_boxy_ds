import 'package:flutter/material.dart';
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
    return InkWell(
      onTap: product.onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withAlpha(30),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MBProductCardHeader(
              storeImageURL: product.storeImageUrl,
              storeName: product.storeName,
              rating: 4.5,
            ),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3.0),
                  child: MBProductCardImageContainer(url: product.imageUrl),
                ),
                Positioned(
                  bottom: 8, right: 12,
                  child: MBFavoriteButton(
                    isActive: product.isFavorite,
                    defaultActive: product.isFavorite ?? false,
                    background: true,
                    onPressed: product.onFavoriteChanged,
                  ),
                ),
                // Positioned(
                //   bottom: 8, right: 8,
                //   child: MBAddToCartBtn(onPress: onAddToCart)
                // )
              ],
            ),
            MBProductCardLabel(
              title: product.title, price: product.price
            ),
          ],
        ),
      )
    );
  }
}
