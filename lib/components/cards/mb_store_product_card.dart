import 'package:flutter/material.dart';
import 'package:my_boxy_ds/components/containers/mb_product_card_image_container.dart';
import 'package:my_boxy_ds/components/labels/mb_product_card_label.dart';
import 'package:my_boxy_ds/my_boxy_ds.dart';

class MBStoreProductCard extends StatefulWidget {

  final String title;
  final String price;
  final String imageUrl;
  final bool isFavorite;
  final ValueChanged<bool>? onFavoriteTap;
  final VoidCallback? onTap;

  const MBStoreProductCard({
    super.key,
    required this.title,
    required this.price,
    required this.isFavorite,
    required this.imageUrl,
    this.onFavoriteTap,
    this.onTap,
  });

  @override
  State<StatefulWidget> createState() => _MBStoreProductCardState();
}


class _MBStoreProductCardState extends State<MBStoreProductCard> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: AppRadius.topSheet.topLeft, 
                    topRight: AppRadius.topSheet.topRight,
                  )
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(3.0, 3.0, 3.0, 0.0),
                  child: MBProductCardImageContainer(url: widget.imageUrl),
                ),
              ),
              Positioned(
                bottom: 8, right: 12,
                child: MBFavoriteButton(
                  isActive: widget.isFavorite,
                  defaultActive: widget.isFavorite,
                  background: true,
                  onPressed: widget.onFavoriteTap,
                ),
              ),
            ],
          ),
          MBProductCardLabel(
            title: widget.title, price: widget.price
          ),
        ],
      ),
    );
  }
}