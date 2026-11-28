import 'package:flutter/material.dart';
import 'package:my_boxy_ds/my_boxy_ds.dart';

class MBSquareIconBtn extends StatefulWidget {
  final IconData icon;
  final String? title;
  final double? padding;
  final double? iconSize;
  final BorderRadiusGeometry? radius;
  final bool? hasBackground;
  final Color? iconColor;
  final Color? backgroundColor;

  /// Borda opcional (ex.: verde para item já no carrinho). Sem ela, nada muda.
  final Color? borderColor;

  /// Anima a borda e ignora o toque enquanto carrega.
  final bool isLoading;
  final VoidCallback? onTap;
  final double? width;
  final double? height;

  const MBSquareIconBtn({
    super.key,
    required this.icon,
    this.title,
    this.padding,
    this.iconSize,
    this.radius,
    this.hasBackground,
    this.iconColor,
    this.backgroundColor,
    this.borderColor,
    this.isLoading = false,
    this.onTap,
    this.width,
    this.height,
  });

  @override
  State<MBSquareIconBtn> createState() => _MBSquareIconBtnState();
}

class _MBSquareIconBtnState extends State<MBSquareIconBtn>
    with SingleTickerProviderStateMixin {
  late final AnimationController _loadingBorderController;

  @override
  void initState() {
    super.initState();
    _loadingBorderController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );
    if (widget.isLoading) {
      _loadingBorderController.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant MBSquareIconBtn oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isLoading && !oldWidget.isLoading) {
      _loadingBorderController.repeat();
    } else if (!widget.isLoading && oldWidget.isLoading) {
      _loadingBorderController
        ..stop()
        ..value = 1;
    }
  }

  @override
  void dispose() {
    _loadingBorderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.isLoading ? null : widget.onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 8.0,
        children: [
          _buildButton(context),
          if (widget.title != null)
            Text(widget.title!, style: AppTextStyles.priceInstallment),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    final borderRadius = (widget.radius ?? AppRadius.allXLarge).resolve(
      Directionality.of(context),
    );
    final activeBorderColor =
        widget.borderColor ?? (widget.isLoading ? AppColors.primary : null);

    return AnimatedBuilder(
      animation: _loadingBorderController,
      builder: (context, child) {
        return CustomPaint(
          foregroundPainter: widget.isLoading
              ? _LoadingBorderPainter(
                  progress: _loadingBorderController.value,
                  color: activeBorderColor!,
                  borderRadius: borderRadius,
                )
              : null,
          child: child,
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: widget.width,
        height: widget.height,
        padding: EdgeInsets.all(widget.padding ?? 0.0),
        decoration: widget.hasBackground == null || activeBorderColor != null
            ? BoxDecoration(
                color: widget.hasBackground == null
                    ? widget.backgroundColor ?? AppColors.primaryLight
                    : null,
                borderRadius: borderRadius,
                border: activeBorderColor == null || widget.isLoading
                    ? null
                    : Border.all(color: activeBorderColor, width: 1.5),
                boxShadow: activeBorderColor == null
                    ? null
                    : [
                        BoxShadow(
                          color: activeBorderColor.withAlpha(70),
                          blurRadius: 8,
                          spreadRadius: 1,
                        ),
                      ],
              )
            : null,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 220),
          switchInCurve: Curves.easeOut,
          switchOutCurve: Curves.easeIn,
          transitionBuilder: (child, animation) {
            final position = Tween<Offset>(
              begin: const Offset(-1, 0),
              end: Offset.zero,
            ).animate(animation);
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(position: position, child: child),
            );
          },
          child: Icon(
            widget.icon,
            key: ValueKey(widget.icon),
            size: widget.iconSize ?? 18,
            color: widget.iconColor ?? AppColors.primaryDark,
          ),
        ),
      ),
    );
  }
}

class _LoadingBorderPainter extends CustomPainter {
  const _LoadingBorderPainter({
    required this.progress,
    required this.color,
    required this.borderRadius,
  });

  final double progress;
  final Color color;
  final BorderRadius borderRadius;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final rrect = borderRadius.toRRect(rect).deflate(1.25);
    final path = Path()..addRRect(rrect);
    final metric = path.computeMetrics().first;
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(metric.extractPath(0, metric.length * progress), paint);
  }

  @override
  bool shouldRepaint(_LoadingBorderPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.color != color ||
        oldDelegate.borderRadius != borderRadius;
  }
}
