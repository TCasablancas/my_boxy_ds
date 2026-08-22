import 'package:flutter/material.dart';

class MBCategoryButton extends StatelessWidget {
  final Widget icon;
  final String title;
  final VoidCallback onPressed;
  final bool isSelected;
  final Color activeBorderColor;

  const MBCategoryButton({
    super.key,
    required this.icon,
    required this.title,
    required this.onPressed,
    this.isSelected = false,
    this.activeBorderColor = const Color(0xFF2BAE66),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8.0, right: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: isSelected ? activeBorderColor : const Color(0xFFDADADA),
          width: 2,
        ),
      ),
      child: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 40, child: icon,),
            const SizedBox(width: 4),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
