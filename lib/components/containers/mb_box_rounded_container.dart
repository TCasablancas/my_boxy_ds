import 'package:flutter/material.dart';

class MBBoxRoundedContainer extends StatelessWidget {

  final Widget child;
  final EdgeInsets? paddingH;

  const MBBoxRoundedContainer({
    super.key,
    required this.child,
    this.paddingH,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: paddingH ?? EdgeInsets.symmetric(horizontal:  16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(16)
      ),
      child: child
    );  
  }
}