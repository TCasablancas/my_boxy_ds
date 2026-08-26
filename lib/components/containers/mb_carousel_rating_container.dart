import 'package:flutter/material.dart';
import 'package:my_boxy_ds/components/containers/mb_rating_container.dart';

class MBCarouselRatingContainer extends StatelessWidget {

  final double rating;
  final int reviews;
  final VoidCallback? onTap;

  const MBCarouselRatingContainer({
    super.key,
    required this.rating,
    required this.reviews,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child:  Row(
        children: [ 
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadiusDirectional.only(
                topStart: Radius.circular(12),
                bottomStart: Radius.circular(12),
              )
            ),
            child: MBRatingBadge(rating: rating),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadiusDirectional.only(
                topEnd: Radius.circular(12),
                bottomEnd: Radius.circular(12),
              ),
            ),
            child: Row(
              spacing: 4,
              children: [
                Text(
                  '$reviews avaliações',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'SFMono',
                    fontWeight: FontWeight.w300,
                    letterSpacing: -0.75,
                    color: Colors.grey[700],
                  )
                ),
                Icon(Icons.arrow_forward_ios_rounded, size: 12, color: Colors.grey[600])
              ],
            )
          ),
        ],
      ),
    );
  }
}