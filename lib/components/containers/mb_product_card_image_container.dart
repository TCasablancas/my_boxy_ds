import 'package:flutter/material.dart';

class MBProductCardImageContainer extends StatelessWidget {

  final String url;

  const MBProductCardImageContainer({
    super.key,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(8),
        topRight: Radius.circular(8),
      ),
      child: Image.network(
        url,
        width: double.infinity,
        height: 180,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => const SizedBox(
          height: 160,
          child: ColoredBox(color: Color(0xFFE5E7EB)),
        ),
      ),
    );
  }
}