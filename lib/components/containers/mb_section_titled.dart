import 'package:flutter/material.dart';
import 'package:my_boxy_ds/my_boxy_ds.dart';

class MBSectionTitled extends StatelessWidget {
  final String title;
  final String? text;
  final Widget? child;
  final EdgeInsets? padding;
  final bool? paddingH;
  final IconData? actionIcon;
  final String? actionTitle;
  final VoidCallback? actionLink;

  const MBSectionTitled({
    super.key,
    required this.title,
    this.text,
    this.child,
    this.padding,
    this.paddingH,
    this.actionIcon,
    this.actionTitle,
    this.actionLink,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: paddingH == true ? 16.0 : 0.0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: AppTextStyles.bodyMediumStrong.copyWith(
                      color: AppColors.primaryDark,
                      letterSpacing: -0.5
                    )
                  )
                ),
                if (actionTitle != null || actionIcon != null) ...[
                  Spacer(),
                  Expanded(
                    child: MBTextButton(
                      icon: actionIcon,
                      title: actionTitle,
                      textColor: AppColors.focus,
                      onPressed: actionLink,
                      horizontalAlign: .end,
                      size: .small,
                    )
                  )
                ]
              ],
            )
          ),
          SizedBox(height: child != null ? 8.0 : 4.0),
          // Sem child e sem texto, fica só o título (antes quebrava no `child!`).
          if (child != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: child,
            )
          else if (text?.isNotEmpty ?? false)
            Text(
              text!,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
                letterSpacing: -0.3
              )
            ),
        ],
      )
    );
  }
}