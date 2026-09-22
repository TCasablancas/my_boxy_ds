import 'package:flutter/material.dart';
import 'package:my_boxy_ds/ui/design_tokens/design_tokens.dart';

class MBSimpleTitledContainer extends StatelessWidget {

  const MBSimpleTitledContainer({
    super.key,
    required this.child,
    this.label,
    this.height,
    this.padding,
    this.background,
  });

  final Widget child;
  final String? label;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final Color? background;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 110,
      padding: padding ?? EdgeInsets.symmetric(
        horizontal: AppSizes.small,
        vertical: AppSizes.medium
      ),
      decoration: BoxDecoration(
        color: background ?? AppColors.white,
        borderRadius: BorderRadius.circular(AppSizes.medium),
      ),
      child: Column(
        spacing: AppSizes.small,
        children: [
          if (label != null)
            Text(
              label ?? '',
              style: AppTextStyles.appBarTitle.copyWith(
                letterSpacing: -0.5
              )
            ),
          child
        ],
      ),
    );
  }
}