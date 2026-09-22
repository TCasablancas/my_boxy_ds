import 'package:flutter/material.dart';

class MBBoxRoundedContainer extends StatelessWidget {

  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsetsGeometry? margin;
  final Color? background;
  final Border? border;

  const MBBoxRoundedContainer({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.background,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.symmetric(horizontal:  16, vertical: 8),
      margin: margin ?? EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: background ?? Colors.grey[200],
        borderRadius: BorderRadius.circular(16),
        border: border
      ),
      child: child
    );  
  }
}