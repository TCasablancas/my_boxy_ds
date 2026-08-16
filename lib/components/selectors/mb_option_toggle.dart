import 'package:flutter/material.dart';

class MBOptionToggle extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChange;
  final bool disabled;

  const MBOptionToggle({
    super.key,
    required this.label,
    required this.value,
    required this.onChange,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'SFMono',
                  letterSpacing: -0.5,
                  color: Color(0xFF6B7280),
                ),
              ),
            ),
          ),
          Switch(value: value, onChanged: disabled ? null : onChange),
        ],
      ),
    );
  }
}
