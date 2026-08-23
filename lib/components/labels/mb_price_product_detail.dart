import 'package:flutter/material.dart';
import 'package:my_boxy_ds/ui/mb_design_tokens.dart';
import 'package:my_boxy_ds/ui/mb_typography.dart';
// import 'package:intl/intl.dart';

class MBPriceProductDetail extends StatelessWidget {
  final double price;

  const MBPriceProductDetail({
    super.key,
    required this.price,
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

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text(
                  'R\$',
                  style: AppTypography.body1Fn(
                    Colors.grey[600]
                  ).copyWith(letterSpacing: -0.2)
                )
              ),
              const SizedBox(width: 4),
              Text(
                partes[0].length > 3 ? parteInteira : partes[0],
                style: AppTypography.h1.copyWith(
                  fontFamily: 'SFMono',
                  letterSpacing: -0.5,
                  color: AppColors.focus
                )
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  ',${partes[1]}',
                  style: AppTypography.body1.copyWith(
                    fontFamily: 'SFMono',
                    letterSpacing: -0.5,
                    color: Colors.blue
                  )
                ),
              ),
            ],
          ),
          Text(
            'À vista no PIX',
            style: AppTypography.captionFn(
              Colors.grey[500], 'Lexend'
            ).copyWith(letterSpacing: -0.2)
          ),
        ],
      )
    );
  }
}