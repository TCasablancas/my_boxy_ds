import 'package:flutter/material.dart';

class MBProductCardImageContainer extends StatelessWidget {

  final String url;

  static const double _height = 180;

  const MBProductCardImageContainer({
    super.key,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      // borderRadius: BorderRadius.only(
      //   topLeft: Radius.circular(8),
      //   topRight: Radius.circular(8),
      // ),
      borderRadius: BorderRadius.circular(8),
      // Decodifica a foto no tamanho do card, não no tamanho original.
      child: LayoutBuilder(
        builder: (context, constraints) {
          final dpr = MediaQuery.devicePixelRatioOf(context);
          final maxWidth = constraints.maxWidth;
          // BoxFit.cover recorta e escala pelo lado que cobre o card: decodificar
          // pela maior dimensão evita borrar foto paisagem num card quase quadrado.
          final side = maxWidth.isFinite && maxWidth > _height ? maxWidth : _height;
          return Image.network(
            url,
            width: double.infinity,
            height: _height,
            fit: BoxFit.cover,
            cacheWidth: (side * dpr).round(),
            errorBuilder: (_, _, _) => const SizedBox(
              height: 160,
              child: ColoredBox(color: Color(0xFFE5E7EB)),
            ),
          );
        },
      ),
    );
  }
}