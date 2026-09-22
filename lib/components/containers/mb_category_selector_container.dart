import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:my_boxy_ds/ui/design_tokens/design_tokens.dart';

class MBCategorySelectorContainer extends StatefulWidget {

  const MBCategorySelectorContainer({
    super.key,
    this.actionIcon,
    required this.label,
    this.value,
    this.background,
    this.onTap,
  });

  final IconData? actionIcon;
  final String label;
  final String? value;
  final Color? background;
  final VoidCallback? onTap;

  @override
  State<MBCategorySelectorContainer> createState() => _MBCategorySelectorContainerState();
}

class _MBCategorySelectorContainerState extends State<MBCategorySelectorContainer> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          height: 52,
          padding: EdgeInsets.symmetric(horizontal: AppSizes.small, vertical: AppSizes.sm),
          decoration: BoxDecoration(
              color: widget.background ?? AppColors.grey300,
              borderRadius: BorderRadius.circular(AppSizes.md),
              border: Border.all(
                  color: AppColors.grey300,
                  width: 3
              )
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.label,
                      style: AppTextStyles.snackbar(AppColors.grey500),
                    ),
                    const Spacer(),
                    Text(
                      widget.value ?? '',
                      softWrap: true,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.bodyLarge.copyWith(
                          letterSpacing: -0.5
                      ),
                    )
                  ],
                ),
              ),
              Icon(widget.actionIcon ?? LucideIcons.plus, size: 16,)
            ],
          ),
        )
      ),
    );
  }
}