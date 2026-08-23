import 'package:flutter/material.dart';
import 'package:my_boxy_ds/ui/mb_typography.dart';

class MBInstallmentPriceLabel extends StatelessWidget {
  final double price;
  final int installments;

  const MBInstallmentPriceLabel({
    super.key,
    required this.price,
    required this.installments,
  });

  List<String> separarValorReal(double valor) {
    String valorFormatado = valor.toStringAsFixed(2);
    return valorFormatado.split('.');
  }

  @override
  Widget build(BuildContext context) {
    List<String> partes = separarValorReal(price);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'ou ${installments}x',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.grey[500],
          ),
        ),
        Text(
          '${partes[0]},${partes[1]}',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            fontFamily: 'SFMono',
            letterSpacing: -0.5,
            color: Colors.black54,
          )
        ),
        Text(
          'no Crédito',
          style: AppTypography.captionFn(Colors.grey[500], 'Lexend').copyWith(letterSpacing: -0.2)
        ),
      ]
    );
  }
}