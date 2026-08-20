import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:my_boxy_ds/components/caroussels/mb_home_carousel_list_header.dart';

class MBTextBlurContainer extends StatelessWidget {
  final MBHomeCarouselItem item;

  const MBTextBlurContainer({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          color: Colors.white.withAlpha((0.08 * 255).toInt()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                child: Text(
                  item.title ?? '',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFFFBBF24),
                    fontSize: 22,
                    fontFamily: 'SFMono',
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                    height: 1.0,
                    shadows: [
                      Shadow(
                        color: Color.fromRGBO(0, 0, 0, 0.2),
                        offset: Offset(0, 2),
                        blurRadius: 12,
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(12, 0, 12, 8),
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                  style: TextStyle(
                    fontFamily: 'SFMono',
                    letterSpacing: -0.5,
                    color: Colors.white,
                    fontSize: 14,
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