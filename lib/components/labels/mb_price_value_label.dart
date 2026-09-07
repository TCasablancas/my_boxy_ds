import 'package:flutter/material.dart';
import 'package:my_boxy_ds/ui/design_tokens/design_tokens.dart';
// import 'package:my_boxy_ds/ui/mb_typography.dart';

enum MBPriceValueLabelSize {
  small, medium, large
}

enum MBPriceValueLabelAlignment {
  left, center, right
}

class MBPriceValueLabel extends StatelessWidget {

  final String price;
  final MBPriceValueLabelSize? size;
  final Color? color;
  final MBPriceValueLabelAlignment? alignment;

  const MBPriceValueLabel({
    super.key,
    required this.price,
    this.size = .small,
    this.color,
    this.alignment = .right,
  });

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

    double? _currencySize(MBPriceValueLabelSize? size) {
      return switch (size) {
        MBPriceValueLabelSize.small => 11,
        MBPriceValueLabelSize.medium => 14,
        MBPriceValueLabelSize.large => 18,
        null => 14,
      };
    }

    double? _fontSize(MBPriceValueLabelSize? size) {
      return switch (size) {
        MBPriceValueLabelSize.small => 13,
        MBPriceValueLabelSize.medium => 18,
        MBPriceValueLabelSize.large => 24,
        null => 14,
      };
    }

    MainAxisAlignment _axisAlignment(MBPriceValueLabelAlignment? alignment) {
      return switch (alignment) {
        MBPriceValueLabelAlignment.left => MainAxisAlignment.start,
        MBPriceValueLabelAlignment.center => MainAxisAlignment.center,
        MBPriceValueLabelAlignment.right => MainAxisAlignment.end,
        null => MainAxisAlignment.end,
      };
    }

    CrossAxisAlignment _crossAxisAlignment(MBPriceValueLabelAlignment? alignment) {
      return switch (alignment) {
        MBPriceValueLabelAlignment.left => CrossAxisAlignment.start,
        MBPriceValueLabelAlignment.center => CrossAxisAlignment.center,
        MBPriceValueLabelAlignment.right => CrossAxisAlignment.end,
        null => CrossAxisAlignment.end,
      };
    }

    return Row(
      spacing: 2.0,
      mainAxisAlignment: _axisAlignment(alignment),
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 1),
          child: Text(
            'R\$',
            style: AppTextStyles.price.copyWith(
              fontSize: _currencySize(size),
              fontWeight: FontWeight.w400,
              letterSpacing: -0.5,
              color: color?.withAlpha(180) ?? AppColors.focus.withAlpha(180),
            ),
          ),
        ),
        Text(
          _formattedPrice,
          textAlign: TextAlign.left,
          style: AppTextStyles.price.copyWith(
            fontSize: _fontSize(size),
            fontWeight: FontWeight.w700,
            color: color ?? AppColors.focus,
            letterSpacing: -0.5
          ),
        ),
      ],
    );
  }
}