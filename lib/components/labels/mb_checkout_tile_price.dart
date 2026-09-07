import 'package:flutter/material.dart';
import 'package:my_boxy_ds/ui/design_tokens/design_tokens.dart';

class MBCheckoutTilePrice extends StatelessWidget {

  final double price;


  const MBCheckoutTilePrice({
    super.key,
    required this.price,
  });

  List<String> separarValorReal(double valor) {
    String valorFormatado = valor.toStringAsFixed(2);
    return valorFormatado.split('.');
  }

  @override
  Widget build(BuildContext context) {
    int valMoeda = 1;
    List<String> partes = separarValorReal(price);
    int precoFormatado = partes.length - valMoeda;
    String parteInteira = partes[0].replaceRange(precoFormatado, precoFormatado, '.');

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Text(
            'R\$',
            style: AppTextStyles.description.copyWith(
              fontFamily: 'SFMono',
              letterSpacing: -0.5,
              color: Colors.grey[400]
            )
          ),
        ),
        Text(
          partes[0].length > 3 ? parteInteira : partes[0],
          style: AppTextStyles.titleSmall.copyWith(
            fontFamily: 'SFMono',
            letterSpacing: -0.5,
            color: AppColors.focus
          )
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 9),
          child: Text(
            ',${partes[1]}',
            style: AppTextStyles.description.copyWith(
              fontFamily: 'SFMono',
              letterSpacing: -0.5,
              color: AppColors.focus
            )
          ),
        ),
      ],
    );
  }
}