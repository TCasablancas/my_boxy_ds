import 'package:flutter/material.dart';

enum StoreImageSize {
  small,
  medium,
  large,
}

class MBStoreImageContainer extends StatelessWidget {

  final String url;
  final StoreImageSize? size;

  const MBStoreImageContainer({
    super.key,
    required this.url,
    this.size = StoreImageSize.small,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.network(
        url,
        width: size == StoreImageSize.small ? 20 : size == StoreImageSize.medium ? 36 : 60,
        height: size == StoreImageSize.small ? 20 : size == StoreImageSize.medium ? 36 : 60,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) =>
            const ColoredBox(color: Color(0xFFCCCCCC)),
      ),
    );
  }
}