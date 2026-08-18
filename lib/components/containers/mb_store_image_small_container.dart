import 'package:flutter/material.dart';

class MBStoreImageSmallContainer extends StatelessWidget {

  final String url;

  const MBStoreImageSmallContainer({
    super.key,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.network(
        url,
        width: 20, height: 20,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) =>
            const ColoredBox(color: Color(0xFFCCCCCC)),
      ),
    );
  }
}