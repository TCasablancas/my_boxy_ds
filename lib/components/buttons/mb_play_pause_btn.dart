import 'package:flutter/material.dart';

import 'mb_button_tokens.dart';

class MBPlayPauseButton extends StatelessWidget {
  final bool isPlaying;
  final VoidCallback onPressed;

  const MBPlayPauseButton({
    super.key,
    required this.isPlaying,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final label = isPlaying ? 'Parar' : 'Continuar';
    final icon = isPlaying ? Icons.stop : Icons.play_arrow;
    return Material(
      color: const Color.fromRGBO(0, 0, 0, .45),
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 26,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: mbButtonTextStyle(fontSize: 12, color: Colors.white),
              ),
              const SizedBox(width: 4),
              Icon(icon, size: 16, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
