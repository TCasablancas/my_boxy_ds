import 'package:flutter/material.dart';
import 'package:my_boxy_ds/ui/design_tokens/design_tokens.dart';

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

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.grey[100]?.withAlpha(150),
        borderRadius: BorderRadius.circular(20.0)
      ),
      child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        spacing: 12.0,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: AppShadows.floatingButton
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
              fontWeight: FontWeight.w400,
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
      )
    );
  }
}