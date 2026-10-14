import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:my_boxy_ds/components/buttons/buttons.dart';
import 'package:my_boxy_ds/ui/design_tokens/design_tokens.dart';

class MBRemovableTile extends StatefulWidget {
  const MBRemovableTile({
    super.key,
    this.icon,
    required this.title,
    required this.description,
    required this.onRemove,
    this.backgroundColor,
    this.foregroundColor,
  });

  final IconData? icon;
  final String title;
  final String description;
  final VoidCallback onRemove;
  final Color? backgroundColor;
  final Color? foregroundColor;

  @override
  State<MBRemovableTile> createState() => _MBRemovableTileState();
}

class _MBRemovableTileState extends State<MBRemovableTile>
    with SingleTickerProviderStateMixin {
  late final AnimationController _removeController;
  late final CurvedAnimation _removeAnimation;

  @override
  void initState() {
    super.initState();
    _removeController =
        AnimationController(
          duration: const Duration(milliseconds: 300),
          vsync: this,
        )..addStatusListener((status) {
          if (status == AnimationStatus.completed) widget.onRemove();
        });
    _removeAnimation = CurvedAnimation(
      parent: _removeController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _removeController.dispose();
    super.dispose();
  }

  void _remove() {
    if (!_removeController.isAnimating) _removeController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final foregroundColor = widget.foregroundColor ?? AppColors.primaryDark;

    return FadeTransition(
      opacity: ReverseAnimation(_removeAnimation),
      child: SizeTransition(
        sizeFactor: ReverseAnimation(_removeAnimation),
        axis: Axis.horizontal,
        alignment: AlignmentDirectional.centerStart,
        child: Padding(
          padding: const EdgeInsets.only(
            top: AppSizes.small,
            right: AppSizes.small,
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: AppSizes.xxl,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.medium,
                ),
                decoration: BoxDecoration(
                  color: widget.backgroundColor ?? AppColors.primaryLight,
                  borderRadius: AppRadius.allLarge,
                  border: Border.all(
                    color: AppColors.primary,
                    width: 2.0,
                  ),
                ),
                child: Row(
                  spacing: AppSizes.md,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      widget.icon,
                      size: AppSizes.medium,
                      color: foregroundColor,
                    ),
                    Text(
                      widget.title,
                      style: AppTextStyles.bodyMediumStrong.copyWith(
                        color: foregroundColor,
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                top: -AppSizes.small,
                right: -AppSizes.small,
                child: MBRoundedIconButton(
                  buttonSize: MBRoundedIconButtonSize.small,
                  backgroundColor: AppColors.grey200,
                  icon: LucideIcons.x,
                  onPressed: _remove,
                  shadow: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
