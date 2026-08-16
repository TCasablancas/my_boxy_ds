import 'package:flutter/material.dart';

import 'mb_product.dart';

class MBCarouselStoreProducts extends StatelessWidget {
  final MBProduct product;
  final VoidCallback? onPressed;

  const MBCarouselStoreProducts({
    super.key,
    required this.product,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: InkWell(
          onTap: product.onPressed ?? onPressed,
          borderRadius: BorderRadius.circular(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  product.imageUrl,
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) =>
                      const ColoredBox(color: Color(0xFFE5E7EB)),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                product.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  height: 16 / 14,
                  fontFamily: 'SFMono',
                  letterSpacing: -0.5,
                  color: Color(0xFF4C4C4C),
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'R\$ ',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'SFMono',
                        letterSpacing: -0.5,
                      ),
                    ),
                    TextSpan(
                      text: product.price,
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'SFMono',
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                  style: const TextStyle(
                    color: Color(0xFF6ABA02),
                    height: 20 / 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
