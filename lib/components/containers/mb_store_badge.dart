import 'package:flutter/material.dart';

class MBStoreBadge extends StatelessWidget {
  final String storeImageUrl;
  final String storeName;

  const MBStoreBadge({
    super.key, 
    required this.storeImageUrl, 
    required this.storeName
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 2, right: 8, top: 2, bottom: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipOval(
            child: Image.network(
              storeImageUrl,
              width: 16,
              height: 16,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) =>
                  const ColoredBox(color: Color(0xFFCCCCCC)),
            ),
          ),
          const SizedBox(width: 4),
          Text(
            storeName,
            style: const TextStyle(
              fontSize: 10,
              fontFamily: 'SFMono',
              letterSpacing: -0.5,
              color: Color(0xFF4C4C4C),
            ),
          ),
        ],
      ),
    );
  }
}