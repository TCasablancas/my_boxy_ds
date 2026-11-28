import 'package:flutter/material.dart';
import 'package:my_boxy_ds/ui/design_tokens/design_tokens.dart';

class MBBoxRoundedContainer extends StatelessWidget {

  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsetsGeometry? margin;
  final Color? background;
  final Border? border;
  final BorderRadius? borderRadius;

  const MBBoxRoundedContainer({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.background,
    this.border,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.symmetric(
        horizontal: AppSizes.medium, vertical: AppSizes.small
      ),
      margin: margin ?? EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: background ?? AppColors.white,
        borderRadius: borderRadius ?? BorderRadius.circular(16),
        border: border
      ),
      child: child
    );  
  }
}