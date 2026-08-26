import 'package:flutter/material.dart';

class MBBottomMenuItemButton extends StatelessWidget {
  final IconData? icon;
  final String label;

  const MBBottomMenuItemButton({
    super.key,
    this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final color = Colors.grey[700];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        spacing: 8,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: icon != null
                ? Icon(icon, size: 16, color: Colors.grey[700])
                : null,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Lexend',
              fontWeight: FontWeight.w700,
              color: color
            )
          ),
          const Spacer(),
          Icon(
            Icons.arrow_forward_ios_rounded, 
            size: 16,
            color: Colors.grey[400]
          )
        ]
      )
    );
  }
}