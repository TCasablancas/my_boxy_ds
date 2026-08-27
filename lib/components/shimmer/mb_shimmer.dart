import 'package:flutter/material.dart';

/// Efeito de "respiração" (pulse) aplicado a qualquer subárvore de placeholders.
/// Um único AnimationController cobre todos os MBShimmerBox filhos — não crie
/// um MBShimmer por bloco, envolva a tela inteira uma vez só (ver MBHomeShimmerView).
class MBShimmer extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const MBShimmer({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 900),
  });

  @override
  State<MBShimmer> createState() => _MBShimmerState();
}

class _MBShimmerState extends State<MBShimmer> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  )..repeat(reverse: true);

  late final Animation<double> _opacity = Tween<double>(begin: 0.4, end: 1.0)
      .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(opacity: _opacity, child: widget.child);
  }
}
