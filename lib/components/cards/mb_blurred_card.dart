import 'dart:ui';

import 'package:flutter/material.dart';

class MBBlurredCard extends StatelessWidget {
  final double width;
  final double height;
  final Widget child;

  const MBBlurredCard({
    super.key,
    required this.width,
    required this.height,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        // Sigma 200 custava muito no raster sem diferença visível sobre 20.
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: .1),
            border: Border.all(
              color: Colors.white.withValues(alpha: .2),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: child,
        ),
      ),
    );
  }
}
