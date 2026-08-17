import 'package:flutter/material.dart';
import 'package:my_boxy_ds/ui/mb_typography.dart';

class MBCenterStripeText extends StatelessWidget {
  final String text;
  final double marginVertical;

  const MBCenterStripeText({
    super.key,
    required this.text,
    this.marginVertical = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 30,
      margin: EdgeInsets.symmetric(vertical: marginVertical),
      child: Row(
        children: [
          Expanded(
            child: Container(height: 1, color: Colors.grey[300]),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              text, style: AppTypography.descriptionFn(Colors.grey[600]),
            ),
          ),
          Expanded(
            child: Container(height: 1, color: Colors.grey[300]),
          ),
        ],
      ),
    );
  }
}
