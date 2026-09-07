import 'package:flutter/material.dart';
import 'package:my_boxy_ds/ui/design_tokens/design_tokens.dart';

class MBSeparator extends StatelessWidget {

  final double? margin;
  final Color? color;

  const MBSeparator({
    super.key,
    this.margin,
    this.color
  });

  @override
  Widget build(BuildContext context) {
    return
      Container(
        width: double.infinity, height: 1,
        margin: EdgeInsets.symmetric(vertical: margin ?? AppSizes.small),
        decoration: BoxDecoration(color: color ?? AppColors.grey200)
      );
  }
}