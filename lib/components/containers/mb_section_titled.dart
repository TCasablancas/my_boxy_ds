import 'package:flutter/material.dart';
import 'package:my_boxy_ds/ui/mb_design_tokens.dart';

class MBSectionTitled extends StatelessWidget {
  final String title;
  final String? text;
  final Widget? child;
  final bool? paddingH;

  const MBSectionTitled({
    super.key,
    required this.title,
    this.text,
    this.child,
    this.paddingH,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: paddingH == true ? 16.0 : 0.0,
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Lexend',
              color: AppColors.primary,
              letterSpacing: -0.5,
            ),
          )
        ),
        SizedBox(height: child != null ? 8.0 : 4.0),
        text != null && text!.isNotEmpty && child == null
          ? Text(
              text ?? '',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
                fontFamily: 'Lexend',
                color: Colors.black87,
              ),
            ) 
          : Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: child!,
            ),
      ],
    );
  }
}