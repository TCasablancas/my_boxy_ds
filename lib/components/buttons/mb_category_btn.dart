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
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        width: 80,
        height: 60,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? activeBorderColor : const Color(0xFFDADADA),
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: Center(child: icon),
                ),
              ),
            ),
            const SizedBox(height: 4),
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
