import 'package:flutter/material.dart';
import 'package:my_boxy_ds/components/counter/mb_main_counter.dart';
import 'package:my_boxy_ds/ui/design_tokens/design_tokens.dart';

import 'mb_main_selector.dart';

enum MBSelectorWithCounterType { checkbox, radio }

class MBSelectorWithCounterView extends StatelessWidget {
  const MBSelectorWithCounterView({
    super.key,
    required this.icon,
    required this.label,
    required this.description,
    this.counterLabel,
    required this.count,
    required this.isSelected,
    required this.onCountChanged,
    required this.onSelectionChanged,
    this.type = MBSelectorWithCounterType.checkbox,
    this.child,
  });

  final IconData icon;
  final String label;
  final String description;
  final String? counterLabel;
  final int count;
  final bool isSelected;
  final ValueChanged<int> onCountChanged;
  final ValueChanged<bool> onSelectionChanged;
  final MBSelectorWithCounterType type;
  final Widget? child;

  void _select() {
    if (type == MBSelectorWithCounterType.radio && isSelected) return;
    onSelectionChanged(!isSelected);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.transparent,
      borderRadius: BorderRadius.circular(AppRadius.medium),
      child: InkWell(
        onTap: _select,
        borderRadius: BorderRadius.circular(AppRadius.medium),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          height: 160,
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.medium,
            vertical: AppSizes.md,
          ),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppRadius.xxl),
            border: Border.fromBorderSide(
              isSelected ? AppBorders.xThickLight : AppBorders.sideOf(AppColors.white),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon),
                  const Spacer(),
                  _SelectorIndicator(type: type, isSelected: isSelected),
                ],
              ),
              const Spacer(),
              Text(
                label,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
              Text(
                description,
                style: AppTextStyles.labelSmall.copyWith(letterSpacing: -0.5),
              ),
              if (child == null)
                IgnorePointer(
                  ignoring: !isSelected,
                  child: Opacity(
                    opacity: isSelected ? 1 : 0.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          counterLabel ?? '',
                          style: AppTextStyles.labelSmall.copyWith(
                            letterSpacing: -0.5,
                          ),
                        ),
                        MBMainCounter(
                          count: count,
                          counterSize: 24,
                          onChanged: onCountChanged,
                          alignment: .start,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SelectorIndicator extends StatelessWidget {
  const _SelectorIndicator({required this.type, required this.isSelected});

  final MBSelectorWithCounterType type;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return switch (type) {
      MBSelectorWithCounterType.checkbox => MBMainSelector(
        value: isSelected ? 'on' : 'off',
      ),
      MBSelectorWithCounterType.radio => AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        width: AppSizes.large,
        height: AppSizes.large,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.fromBorderSide(
            isSelected ? AppBorders.focusThick : AppBorders.thick,
          ),
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          width: AppSizes.small,
          height: AppSizes.small,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : AppColors.transparent,
            shape: BoxShape.circle,
          ),
        ),
      ),
    };
  }
}
