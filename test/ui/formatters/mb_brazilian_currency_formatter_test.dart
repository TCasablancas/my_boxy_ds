import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_boxy_ds/ui/formatters/mb_brazilian_currency_formatter.dart';

void main() {
  test('formats values in Brazilian currency', () {
    expect(MBBrazilianCurrencyFormatter.formatPrice('1200.00'), '1.200,00');
    expect(MBBrazilianCurrencyFormatter.formatPrice('1.200,00'), '1.200,00');
  });

  test('formats typed digits as Brazilian currency', () {
    expect(_format('', '1').text, '0,01');
    expect(_format('0,01', '0,012').text, '0,12');
    expect(_format('', '120000').text, '1.200,00');
  });

  test('removes last entered digit', () {
    expect(_format('1,00', '1,0').text, '0,10');
  });

  test('parses formatted currency as decimal value', () {
    expect(MBBrazilianCurrencyFormatter.parseFormattedPrice('1.200,00'), 1200);
  });
}

TextEditingValue _format(String oldText, String newText) {
  return const MBBrazilianCurrencyInputFormatter().formatEditUpdate(
    TextEditingValue(text: oldText),
    TextEditingValue(text: newText),
  );
}
