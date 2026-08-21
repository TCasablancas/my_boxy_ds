import 'package:flutter/material.dart';
import 'package:my_boxy_ds/components/caroussels/mb_home_carousel_list_header.dart';
import 'package:my_boxy_ds/components/containers/mb_rating_container.dart';
import 'package:my_boxy_ds/ui/mb_design_tokens.dart';

class MBUserHomeCarouselCard extends StatelessWidget {
  final MBHomeCarouselItem item;
  final double gap;
  final VoidCallback onPressed;

  const MBUserHomeCarouselCard({
    super.key,
    required this.item,
    required this.gap,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: gap),
      child: GestureDetector(
        onTap: onPressed,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            color: AppColors.background,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  item.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) =>
                    const ColoredBox(color: Color(0xFFD8D8D8)),
                ),
                Container(
                  color: const Color.fromRGBO(0, 0, 0, 0.15),
                ),
                Positioned(
                  top: 16, right: 16,
                  child: item.rating != null
                      ? MBRatingBadge(rating: item.rating ?? 0.0)
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}