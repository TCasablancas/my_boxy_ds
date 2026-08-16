import 'package:flutter/material.dart';

import '../buttons/mb_favorite_btn.dart';
import 'mb_product.dart';

class MBMainProductCard extends StatelessWidget {
  final MBProduct product;
  final VoidCallback? onAddToCart;

  const MBMainProductCard({super.key, required this.product, this.onAddToCart});

  String get _formattedPrice {
    final normalized = product.price
        .replaceAll(RegExp(r'[^0-9,.]'), '')
        .replaceAll('.', '')
        .replaceAll(',', '.');
    final value = num.tryParse(normalized);
    return value?.toStringAsFixed(2).replaceAll('.', ',') ?? product.price;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: InkWell(
          onTap: product.onPressed,
          borderRadius: BorderRadius.circular(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 4, bottom: 4),
                child: Row(
                  children: [
                    ClipOval(
                      child: Image.network(
                        product.storeImageUrl,
                        width: 16,
                        height: 16,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) =>
                            const ColoredBox(color: Color(0xFFCCCCCC)),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        product.storeName,
                        style: const TextStyle(
                          fontSize: 10,
                          fontFamily: 'SFMono',
                          letterSpacing: -0.5,
                          color: Color(0xFF111827),
                        ),
                      ),
                    ),
                    if (product.rating != null) ...[
                      const Icon(
                        Icons.star,
                        size: 12,
                        color: Color(0xFFFBBF24),
                      ),
                      Text(
                        '${product.rating}',
                        style: const TextStyle(
                          fontSize: 11,
                          fontFamily: 'SFMono',
                          letterSpacing: -0.5,
                          color: Color(0xFF4C4C4C),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      product.imageUrl,
                      width: double.infinity,
                      height: 160,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => const SizedBox(
                        height: 160,
                        child: ColoredBox(color: Color(0xFFE5E7EB)),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: MBFavoriteButton(
                      isActive: product.isFavorite,
                      defaultActive: product.isFavorite ?? false,
                      onPressed: product.onFavoriteChanged,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              height: 1,
                              fontFamily: 'SFMono',
                              letterSpacing: -0.5,
                              color: Color(0xFF4C4C4C),
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: 'R\$',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'SFMono',
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                TextSpan(
                                  text: _formattedPrice,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'SFMono',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                              style: const TextStyle(
                                color: Color(0xFF007AFF),
                                height: 20 / 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Material(
                    color: const Color(0xFFBFF578),
                    borderRadius: BorderRadius.circular(8),
                    child: InkWell(
                      onTap: onAddToCart,
                      borderRadius: BorderRadius.circular(8),
                      child: const Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(
                          Icons.shopping_cart_outlined,
                          size: 16,
                          color: Color(0xFF6ABA02),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
