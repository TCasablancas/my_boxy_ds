import 'package:flutter/material.dart';
import 'package:my_boxy_ds/my_boxy_ds.dart';
import 'package:my_boxy_ds/ui/design_tokens/design_tokens.dart';
// import 'package:my_boxy_ds/ui/mb_typography.dart';
// import 'package:intl/intl.dart';

class MBPriceProductDetail extends StatelessWidget {

  final double price;
  final double? priceSize;
  final String? description;

  const MBPriceProductDetail({
    super.key,
    required this.price,
    this.priceSize,
    this.description,
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
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(
                  'R\$',
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontFamily: 'SFMono',
                    letterSpacing: -0.5,
                    color: Colors.grey[400]
                  )
                ),
              ),
              Text(
                partes[0].length > 3 ? parteInteira : partes[0],
                style: AppTextStyles.titleLarge.copyWith(
                  fontSize: priceSize ?? 32,
                  fontFamily: 'SFMono',
                  letterSpacing: -0.5,
                  color: AppColors.focus
                )
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  ',${partes[1]}',
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontFamily: 'SFMono',
                    letterSpacing: -0.5,
                    color: Colors.blue
                  )
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