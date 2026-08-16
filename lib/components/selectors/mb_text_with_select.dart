import 'package:flutter/material.dart';

import 'mb_main_selector.dart';

class MBTextWithSelect extends StatelessWidget {
  final String text;
  final String? value;
  final VoidCallback? onChange;

  const MBTextWithSelect({
    super.key,
    required this.text,
    this.value,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onChange,
        child: Row(
          children: [
            MBMainSelector(value: value ?? 'off'),
            const SizedBox(width: 8),
            Text(
              text,
              style: const TextStyle(
                fontSize: 13,
                fontFamily: 'Lexend',
                color: Color(0xFF111827),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
