import 'package:flutter/material.dart';
import 'package:my_boxy_ds/ui/mb_typography.dart';

class MBTitleSubtitled extends StatelessWidget {
  final String title;
  final String description;

  const MBTitleSubtitled({
    super.key,
    required this.title,
    this.description = '',
  });

  @override
  Widget build(BuildContext context) {
    return (
      Column(
        children: [
          Text(
            title,
            style: AppTypography.h2Fn(Colors.grey[600]),
          ),
          Text(
            description,
            style: AppTypography.descriptionFn(Colors.grey[400]),
          )
        ]
      )
    );
  }
 }