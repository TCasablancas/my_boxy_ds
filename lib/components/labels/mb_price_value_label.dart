import 'package:flutter/material.dart';
import 'package:my_boxy_ds/ui/mb_design_tokens.dart';
import 'package:my_boxy_ds/ui/mb_typography.dart';

class MBPriceValueLabel extends StatelessWidget {
  final String price;

  const MBPriceValueLabel({super.key, required this.price});

  String get _formattedPrice {
    final normalized = price
        .replaceAll(RegExp(r'[^0-9,.]'), '')
        .replaceAll(',', '.');
        // .replaceAll('.', '')
    final value = num.tryParse(normalized);
    return value?.toStringAsFixed(2).replaceAll('.', ',') ?? price;
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'R\$',
            style: AppTypography.captionFn(AppColors.accent),
          ),
          TextSpan(
            text: _formattedPrice,
            style: AppTypography.body1Fn(Colors.blue, FontWeight.w700),
          ),
        ],
        style: TextStyle(
          color: Colors.blue,
          height: 20 / 16,
        ),
      ),
    );
  }
}