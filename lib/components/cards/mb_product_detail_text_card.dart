import 'package:flutter/material.dart';
import 'package:my_boxy_ds/ui/mb_design_tokens.dart';

class MBProductDetailTextCard extends StatelessWidget {
  final String title;
  final String description;

  const MBProductDetailTextCard({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(30),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13,
                fontFamily: 'Lexend',
                fontWeight: FontWeight.w700,
                // color: Colors.grey[500]!,
                color: AppColors.primary,
                letterSpacing: -0.2,
              )
            )
          ),
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Lexend',
              fontWeight: FontWeight.w300,
              // color: AppColors.focus,
              color: AppColors.primaryDark,
              letterSpacing: -0.5,
            )
          ),
        ]
      )
    );
  }
}