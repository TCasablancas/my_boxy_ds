import 'package:flutter/material.dart';

class MBSectionTitled extends StatelessWidget {
  final String title;
  final String? text;
  final Widget? child;

  const MBSectionTitled({
    super.key,
    required this.title,
    this.text,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'SFMono',
            color: Colors.grey[500],
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 4),
        text != null && text!.isNotEmpty && child == null ?
          Text(
            text ?? '',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
              fontFamily: 'Lexend',
              color: Colors.black87,
            ),
          ) : child!,
      ],
    );
  }
}