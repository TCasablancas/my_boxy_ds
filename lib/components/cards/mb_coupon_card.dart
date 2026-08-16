import 'package:flutter/material.dart';

import '../buttons/mb_rounded_icon_btn.dart';

enum MBDiscountType { percentage, fixedAmount }

class MBCouponCard extends StatelessWidget {
  final String couponCode;
  final num discountValue;
  final MBDiscountType? type;
  final VoidCallback? onPressed;

  const MBCouponCard({
    super.key,
    required this.couponCode,
    required this.discountValue,
    this.type,
    this.onPressed,
  });

  String get _discount => switch (type) {
    MBDiscountType.fixedAmount => 'R\$${discountValue.toStringAsFixed(2)}',
    MBDiscountType.percentage => '$discountValue%',
    null => '',
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE0E0E0), width: 2),
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, .2),
            offset: Offset(0, 2),
            blurRadius: 12,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  couponCode,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _discount,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color(0xFF007AFF),
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Válido até 31/12/2024',
                  style: TextStyle(fontSize: 12, color: Color(0xFF999999)),
                ),
              ],
            ),
          ),
          MBRoundedIconButton(
            icon: const Icon(
              Icons.visibility_outlined,
              size: 16,
              color: Color(0xFF007AFF),
            ),
            onPressed: onPressed ?? () {},
          ),
          const SizedBox(width: 8),
          MBRoundedIconButton(
            icon: const Icon(Icons.check, size: 16, color: Color(0xFF1F6607)),
            backgroundColor: const Color(0xFFBFF578),
            onPressed: onPressed ?? () {},
          ),
        ],
      ),
    );
  }
}
