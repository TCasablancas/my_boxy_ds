import 'package:flutter/material.dart';

import '../buttons/mb_favorite_btn.dart';

class MBUserFavoriteItem {
  final String id;
  final String imageUrl;
  final String name;
  final num price;

  const MBUserFavoriteItem({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.price,
  });
}

class MBUserFavoriteCard extends StatelessWidget {
  final MBUserFavoriteItem item;
  final String storeName;
  final bool? isFavorite;
  final ValueChanged<bool>? onFavoriteChanged;

  const MBUserFavoriteCard({
    super.key,
    required this.item,
    this.storeName = 'Loja de Plantas',
    this.isFavorite,
    this.onFavoriteChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              item.imageUrl,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => const SizedBox(
                width: 100,
                height: 100,
                child: ColoredBox(color: Color(0xFFEBEBEB)),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: SizedBox(
              height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          item.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            height: 16 / 14,
                            fontFamily: 'SFMono',
                            letterSpacing: -0.5,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                      ),
                      MBFavoriteButton(
                        isActive: isFavorite,
                        onPressed: onFavoriteChanged,
                      ),
                    ],
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: 'R\$',
                          style: TextStyle(
                            fontSize: 11,
                            fontFamily: 'SFMono',
                            fontWeight: FontWeight.normal,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                        TextSpan(
                          text: item.price.toStringAsFixed(2),
                          style: const TextStyle(
                            fontSize: 20,
                            fontFamily: 'SFMono',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                      style: const TextStyle(
                        color: Color(0xFF6ABA02),
                        height: 24 / 20,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Text(
                        'Por',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        storeName,
                        style: const TextStyle(
                          fontSize: 12,
                          fontFamily: 'SFMono',
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.5,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                      const Spacer(),
                      const DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                        child: SizedBox(width: 10, height: 10),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
