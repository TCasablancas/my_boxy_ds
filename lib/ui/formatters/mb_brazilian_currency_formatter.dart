import 'package:flutter/services.dart';

class MBBrazilianCurrencyFormatter {
  static final _nonDigits = RegExp(r'\D');
  static final _hundred = BigInt.from(100);

  static String formatPrice(String value) {
    final sanitized = value.replaceAll(RegExp(r'[^0-9,.]'), '');
    final normalized = sanitized.contains(',')
        ? sanitized.replaceAll('.', '').replaceAll(',', '.')
        : sanitized;
    final amount = double.tryParse(normalized);
    if (amount == null) return value;
    return formatCents(BigInt.from((amount * 100).round()));
  }

  static String formatCents(BigInt cents) {
    final integerPart = cents ~/ _hundred;
    final decimalPart = (cents % _hundred).toString().padLeft(2, '0');
    final groupedInteger = integerPart.toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]}.',
    );
    return '$groupedInteger,$decimalPart';
  }

  static double parseFormattedPrice(String value) {
    final cents = BigInt.tryParse(value.replaceAll(_nonDigits, ''));
    return cents == null ? 0 : cents.toDouble() / 100;
  }
}

class MBBrazilianCurrencyInputFormatter extends TextInputFormatter {
  const MBBrazilianCurrencyInputFormatter();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) return TextEditingValue.empty;

    final oldCents = _toCents(oldValue.text);
    final isDeleting = newValue.text.length < oldValue.text.length;
    final cents = isDeleting && oldCents != null
        ? oldCents ~/ BigInt.from(10)
        : _toCents(newValue.text);

    if (cents == null || cents == BigInt.zero) return TextEditingValue.empty;

    final formatted = MBBrazilianCurrencyFormatter.formatCents(cents);
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  BigInt? _toCents(String value) {
    return BigInt.tryParse(
      value.replaceAll(MBBrazilianCurrencyFormatter._nonDigits, ''),
    );
  }
}
