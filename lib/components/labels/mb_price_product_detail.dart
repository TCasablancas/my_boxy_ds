import 'package:flutter/material.dart';
import 'package:my_boxy_ds/my_boxy_ds.dart';
import 'package:my_boxy_ds/ui/design_tokens/design_tokens.dart';
// import 'package:my_boxy_ds/ui/mb_typography.dart';
// import 'package:intl/intl.dart';

class MBPriceProductDetail extends StatelessWidget {

  final double price;
  final double? priceSize;
  final String? description;
  final String? partDesc;

  const MBPriceProductDetail({
    super.key,
    required this.price,
    this.priceSize,
    this.description,
    this.partDesc,
  });

  List<String> separarValorReal(double valor) {
    String valorFormatado = valor.toStringAsFixed(2);
    return valorFormatado.split('.');
  }

  @override
  Widget build(BuildContext context) {
    // var formatador = NumberFormat('#,##0.00', 'pt_BR');
    // String precoFormatado = formatador.format(price);

    int valMoeda = 1;
    List<String> partes = separarValorReal(price);
    int precoFormatado = partes.length - valMoeda;
    String parteInteira = partes[0].replaceRange(precoFormatado, precoFormatado, '.');

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 6, right: AppSizes.sm),
                child: Text(
                  'R\$',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.focus,
                    letterSpacing: -0.5
                  )
                ),
              ),
              Text(
                partes[0].length > 3 ? parteInteira : partes[0],
                style: AppTextStyles.titleLarge.copyWith(
                  letterSpacing: -0.5,
                  color: AppColors.focus
                )
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: AppSizes.small, left: AppSizes.xs
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ',${partes[1]}',
                      style: AppTextStyles.bodyLarge.copyWith(
                        letterSpacing: -0.5,
                        color: AppColors.focus,
                        height: 1.0
                      )
                    ),
                    Text(
                      partDesc ?? '',
                      style: AppTextStyles.snackbar(AppColors.grey400).copyWith(
                        letterSpacing: -0.5,
                        height: 1.0
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          if (description != null)
            Text(
              'À vista no PIX',
              style: AppTextStyles.labelSmall.copyWith(
                letterSpacing: -0.2
              )
            ),
        ],
      );
  }
}