import 'package:flutter/material.dart';
import 'package:my_boxy_ds/ui/design_tokens/design_tokens.dart';

class MBHeaderActionBtn extends StatefulWidget {

  final IconData icon;
  final VoidCallback onTap;

  const MBHeaderActionBtn({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  State<StatefulWidget> createState() => _MBHeaderActionBtn();
}

class _MBHeaderActionBtn extends State<MBHeaderActionBtn> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 300),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.5).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn, 
        reverseCurve: Curves.bounceOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) => _controller.reverse(),
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          width: 36, height: 36,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: AppRadius.allLarge,
            boxShadow: AppShadows.cardStrong,
          ),
          child: Icon(widget.icon, size: 16, color: AppColors.grey500),
        ),
      ),
    );
  }
}