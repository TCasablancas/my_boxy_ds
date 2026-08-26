import 'package:flutter/material.dart';
import 'package:my_boxy_ds/ui/mb_design_tokens.dart';

class MBSimpleProductRelatedCard extends StatelessWidget {
  final int? index;
  final String imageUrl;
  final String productName;
  final String productPrice;

  const MBSimpleProductRelatedCard({
    super.key,
    this.index,
    required this.imageUrl,
    required this.productName,
    required this.productPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
      margin: EdgeInsets.only(left: index == 0 ? 16.0 : 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            clipBehavior: Clip.hardEdge,
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            )
          ),
          const SizedBox(height: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                productName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13,
                  fontFamily: 'Lexend',
                  fontWeight: FontWeight.w400,
                  letterSpacing: -0.2,
                  color: AppColors.primaryDark
                ),
              ),
              Text(
                productPrice.toString(),
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Lexend',
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.2,
                  color: Colors.grey[500]
                ),
              )
            ]
          ),
        ]
      ),
    );
  }
}