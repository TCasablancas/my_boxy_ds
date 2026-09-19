import 'package:flutter/material.dart';
import 'package:my_boxy_ds/my_boxy_ds.dart';

class MBSquareSelectionBtn extends StatefulWidget {
  const MBSquareSelectionBtn({
    super.key,
    required this.label,
    required this.name,
    required this.description,
    this.icon,
    this.descriptionIcon,
    this.bottomSheetContent,
    this.actions,
    this.onPressed,
  });

  final String label;
  final String name;
  final String description;
  final IconData? icon;
  final Widget? descriptionIcon;
  final Widget? bottomSheetContent;
  final List<Widget>? actions;
  final VoidCallback? onPressed;

  @override
  State<MBSquareSelectionBtn> createState() => _MBSquareSelectionBtnState();
}

class _MBSquareSelectionBtnState extends State<MBSquareSelectionBtn> {
  bool _isPressed = false;

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _isPressed = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _isPressed = false;
    });
  }

  void _handleTapCancel() {
    setState(() {
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onPressed;
        _buildBottomSheet(context);
      },
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppRadius.xxl),
          boxShadow: AppShadows.card
        ),
        padding: EdgeInsets.all(16.0),
        child: Column(
          spacing: AppSizes.xs,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  widget.label,
                  style: AppTextStyles.description.copyWith(
                    fontWeight: FontWeight.w400,
                    color: AppColors.grey500,
                    letterSpacing: -0.2,
                  ),
                ),
                Spacer(),
                Icon(widget.icon, size: AppSizes.medium, color: AppColors.grey500),
              ],
            ),
            const SizedBox(height: AppSizes.medium),
            Text(
              widget.name,
              style: AppTextStyles.button.copyWith(
                fontWeight: FontWeight.w600,
                letterSpacing: -0.2,
                color: AppColors.primary,
                height: 1,
              ),
            ),
            Row(
              spacing: AppSizes.xs,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (widget.icon != null) widget.descriptionIcon!,
                Text(
                  widget.description,
                  style: AppTextStyles.description.copyWith(color: AppColors.primaryDark),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }


  Future<dynamic> _buildBottomSheet(BuildContext context) {
    return MBMainBottomsheet.show(
      context,
      title: widget.label,
      textAlign: TextAlign.start,
      actions: widget.actions,
      child: widget.bottomSheetContent ?? SizedBox(height: 40),
    );
  }
}