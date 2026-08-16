import 'package:flutter/material.dart';

class MBMainSelector extends StatelessWidget {
  final String? value;
  final VoidCallback? onChange;

  const MBMainSelector({super.key, this.value, this.onChange});

  bool get _isSelected => value == 'on';

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(6),
      child: InkWell(
        onTap: onChange,
        borderRadius: BorderRadius.circular(6),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 20,
          height: 20,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _isSelected ? const Color(0xFFBFF578) : Colors.transparent,
            border: Border.all(
              color: _isSelected
                  ? const Color(0xFF1F6607)
                  : const Color(0xFFE5E7EB),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(6),
          ),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: _isSelected ? 1 : 0,
            child: const Icon(Icons.check, size: 16, color: Color(0xFF1F6607)),
          ),
        ),
      ),
    );
  }
}
