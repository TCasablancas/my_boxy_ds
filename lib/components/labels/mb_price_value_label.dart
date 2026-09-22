import 'package:flutter/material.dart';
import 'package:my_boxy_ds/ui/design_tokens/design_tokens.dart';
import 'package:my_boxy_ds/ui/formatters/mb_brazilian_currency_formatter.dart';

enum MBPriceValueLabelSize { small, medium, large }

enum MBPriceValueLabelAlignment { left, center, right }

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

  String get _formattedPrice => MBBrazilianCurrencyFormatter.formatPrice(price);

  @override
  Widget build(BuildContext context) {
    double? currencySize(MBPriceValueLabelSize? size) {
      return switch (size) {
        MBPriceValueLabelSize.small => 11,
        MBPriceValueLabelSize.medium => 14,
        MBPriceValueLabelSize.large => 18,
        null => 14,
      };
    }

    double? fontSize(MBPriceValueLabelSize? size) {
      return switch (size) {
        MBPriceValueLabelSize.small => 13,
        MBPriceValueLabelSize.medium => 18,
        MBPriceValueLabelSize.large => 24,
        null => 14,
      };
    }

    MainAxisAlignment axisAlignment(MBPriceValueLabelAlignment? alignment) {
      return switch (alignment) {
        MBPriceValueLabelAlignment.left => MainAxisAlignment.start,
        MBPriceValueLabelAlignment.center => MainAxisAlignment.center,
        MBPriceValueLabelAlignment.right => MainAxisAlignment.end,
        null => MainAxisAlignment.end,
      };
    }

    return Row(
      spacing: 2.0,
      mainAxisAlignment: axisAlignment(alignment),
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 1),
          child: Text(
            'R\$',
            style: AppTextStyles.price.copyWith(
              fontSize: currencySize(size),
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
            fontSize: fontSize(size),
            fontWeight: FontWeight.w700,
            color: color ?? AppColors.focus,
            letterSpacing: -0.5,
          ),
        ),
      ],
    );
  }
}
