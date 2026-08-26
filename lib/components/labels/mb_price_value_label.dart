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
        // .replaceAll('.', '');
    final value = num.tryParse(normalized);
    return value?.toStringAsFixed(2).replaceAll('.', ',') ?? price;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 3.0),
          child: Text(
            'R\$',
            style: AppTypography.captionFn(AppColors.focus),
          ),
        ),
        Text(
          _formattedPrice,
          style: AppTypography.h3Fn(AppColors.focus, FontWeight.w400),
        ),
      ],
    );
  }
}

        // style: TextStyle(
        //   color: Colors.blueAccent,
        //   fontFamily: 'SFMono'
        // ),