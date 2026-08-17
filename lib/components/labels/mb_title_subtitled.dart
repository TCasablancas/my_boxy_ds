import 'package:flutter/material.dart';
import 'package:my_boxy_ds/ui/mb_typography.dart';

class MBTitleSubtitled extends StatelessWidget {
  final String title;
  final String description;
  final TextAlign textAlign;

  const MBTitleSubtitled({
    super.key,
    required this.title,
    this.description = '',
    this.textAlign = TextAlign.left,
  });

  @override
  Widget build(BuildContext context) {
    return (
      Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Text(
              title,
              textAlign: textAlign,
              style: AppTypography.h2Fn(Colors.grey[800], FontWeight.w800),
            )
          ),
          SizedBox(
            width: double.infinity,
            child: Text(
              description,
              textAlign: textAlign,
              style: AppTypography.descriptionFn(Colors.grey[400]),
            )
          )
        ]
      )
    );
  }
 }