import 'package:flutter/material.dart';

class MBSearchListTileLabel extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;

  const MBSearchListTileLabel({
    super.key,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.history),
      title: Text(
        label,
        style: const TextStyle(
          fontSize: 16.0,
          fontFamily: 'Lexend',
          letterSpacing: -0.5,
        ),
      ),
      trailing: const Icon(Icons.arrow_outward),
      onTap: onTap,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
    );
  }
}