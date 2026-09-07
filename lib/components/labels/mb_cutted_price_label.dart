import 'package:flutter/material.dart';
import 'package:my_boxy_ds/components/mb_separator.dart';

class MBCuttedPriceLabel extends StatelessWidget {

  final double price;

  const MBCuttedPriceLabel({ super.key, required this.price });

  @override
  Widget build(BuildContext context) {
    return Text(
      'R\$${price.toStringAsFixed(2)}',
      style: TextStyle(
        fontFamily: 'SFMono',
        fontWeight: FontWeight.w600,
        fontSize: 13,
        color: Colors.grey,
        letterSpacing: -0.6,
        decoration: TextDecoration.lineThrough,
        decorationColor: Colors.grey,
        height: 1.2
      )
    );
  }
}