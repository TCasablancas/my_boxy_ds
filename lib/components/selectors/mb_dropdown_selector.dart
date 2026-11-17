import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:my_boxy_ds/ui/design_tokens/design_tokens.dart';

class MBDropdownItem<T> {
  final T value;
  final String label;

  const MBDropdownItem({required this.value, required this.label});
}

class MBDropdownSelector<T> extends StatelessWidget {
  final String label;
  final String placeholder;
  final List<MBDropdownItem<T>> items;
  final T? value;
  final ValueChanged<T?>? onChanged;

  const MBDropdownSelector({
    super.key,
    required this.label,
    required this.items,
    this.placeholder = 'Selecione',
    this.value,
    this.onChanged,
  });

  bool get _enabled => onChanged != null && items.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final hasValue = value != null;
    final borderColor = hasValue ? AppColors.primary : AppColors.grey400;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.fromLTRB(
        AppSizes.small,
        AppSizes.sm,
        AppSizes.small,
        0,
      ),
      decoration: BoxDecoration(
        color: _enabled ? AppColors.white : AppColors.grey300,
        border: Border.all(color: borderColor, width: 1.5),
        borderRadius: AppRadius.allLg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyles.snackbar(
              hasValue ? AppColors.primary : AppColors.grey500,
            ),
          ),
          DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: value,
              isExpanded: true,
              isDense: true,
              padding: const EdgeInsets.only(bottom: AppSizes.small),
              borderRadius: AppRadius.allXLarge,
              dropdownColor: AppColors.white,
              icon: const Icon(
                LucideIcons.chevron_down,
                size: AppSizes.medium,
                color: AppColors.grey600,
              ),
              hint: Text(
                placeholder,
                style: AppTextStyles.bodyLarge.copyWith(
                  fontSize: 14,
                  color: AppColors.grey500,
                ),
              ),
              style: AppTextStyles.bodyLarge.copyWith(
                fontSize: 14,
                letterSpacing: -0.5,
                color: AppColors.textPrimary,
              ),
              onChanged: _enabled ? onChanged : null,
              items: items
                  .map(
                    (item) => DropdownMenuItem<T>(
                      value: item.value,
                      child: Text(item.label),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
