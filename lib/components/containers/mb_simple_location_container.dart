import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:my_boxy_ds/ui/mb_typography.dart';

class MBSimpleLocationContainer extends StatelessWidget {
  final String location;

  const MBSimpleLocationContainer({
    super.key,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 2.0,
      children: [
        Icon(LucideIcons.map_pin, size: 10, color: Colors.grey[500]),
        Text(
          location, 
          style: AppTypography.captionFn(
            Colors.grey[500], 'Lexend'
          ).copyWith(letterSpacing: -0.2)
        ),
      ]
    );
  }
}

