import 'package:flutter/material.dart';
import 'package:my_boxy_ds/ui/design_tokens/design_tokens.dart';

class MBCheckoutTileValue extends StatelessWidget {

  final String title;
  final double value;
  final bool? isMain;
  final bool? isLast;

  const MBCheckoutTileValue({
    super.key,
    required this.title,
    required this.value,
    this.isMain,
    this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        border: isLast ?? false ? null : Border(
          bottom: BorderSide(
            color: AppColors.background,
            width: 1.0
          )
        )
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
              title,
              style: TextStyle(
                  fontFamily: 'Lexend',
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                  color: AppColors.grey500,
                  letterSpacing: -0.2
              )
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.only(
              bottom: isMain ?? false ? 2.0 : 1.0,
              right: 2.0
            ),
            child: Text(
                'R\$',
                style: TextStyle(
                    fontFamily: 'SFMono',
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: AppColors.grey500,
                    letterSpacing: -0.2
                )
            ),
          ),
          Text(
              value.toStringAsFixed(2),
              style: TextStyle(
                  fontFamily: 'SFMono',
                  fontWeight: FontWeight.w600,
                  fontSize: isMain ?? false ? 16 : 14,
                  color: isMain ?? false ? AppColors.focus : AppColors.grey500,
                  letterSpacing: -0.5
              )
          )
        ],
      ),
    );
  }
}