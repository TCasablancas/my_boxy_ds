import 'package:flutter/material.dart';

class MBRatingBadge extends StatelessWidget {
  final double rating;

  const MBRatingBadge({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 4, right: 8, top: 2, bottom: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star, size: 16, color: Color(0xFFFBBF24)),
          const SizedBox(width: 2),
          Text(
            '$rating',
            style: const TextStyle(
              fontSize: 14,
              fontFamily: 'SFMono',
              fontWeight: FontWeight.w400,
              letterSpacing: -0.75,
              color: Color(0xFF007BFF),
            ),
          ),
        ],
      ),
    );
  }
}