import 'package:flutter/material.dart';
import 'package:my_boxy_ds/components/mb_separator.dart';
import '../../ui/design_tokens/design_tokens.dart';

class MBCheckoutTileContainer extends StatefulWidget {

  final String title;
  final List<Widget> children;
  final IconData? iconAction;
  final VoidCallback? onTapAction;

  const MBCheckoutTileContainer({
    super.key,
    required this.title,
    required this.children,
    this.iconAction,
    this.onTapAction
  });

  @override
  State<MBCheckoutTileContainer> createState() => _MBCheckoutTileContainerState();
}

class _MBCheckoutTileContainerState extends State<MBCheckoutTileContainer> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: AppSizes.medium),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: AppRadius.allXLarge,
        boxShadow: AppShadows.card
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.medium),
            child: Row(
              children: [
                Text(
                  widget.title,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.2,
                    color: AppColors.primaryDark
                  )
                ),
                const Spacer(),
                GestureDetector(
                  onTap: widget.onTapAction,
                  child: Icon(widget.iconAction, color: AppColors.grey600, size: 16),
                )
              ],
            ),
          ),
          MBSeparator(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.medium),
            child: Column(
              children: widget.children,
            )
          ),
        ],
      ),
    );
  }
}