import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import '../../ui/design_tokens/design_tokens.dart';
import '../buttons/mb_square_icon_btn.dart';

class MBMainCounter extends StatelessWidget {
  final int count;
  final ValueChanged<int> onChanged;

  const MBMainCounter({
    super.key,
    required this.count,
    required this.onChanged
  }) : assert(count >= 0);

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: AppSizes.small,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MBSquareIconBtn(
          icon: LucideIcons.minus,
          padding: 10.0,
          iconSize: 10.0,
          radius: AppRadius.allLarge,
          backgroundColor: count <= 0 ? AppColors.grey200 : AppColors.primaryLight,
          onTap: count > 0 ? () => onChanged(count - 1) : null,
        ),
        Text(
          count.toString(),
          style: AppTextStyles.priceInstallment.copyWith(
            color: AppColors.grey500,
          ),
        ),
        MBSquareIconBtn(
          icon: LucideIcons.plus,
          padding: 10.0,
          iconSize: 10.0,
          radius: AppRadius.allLarge,
          onTap: () => onChanged(count + 1),
        ),
      ],
    );
  }
}
