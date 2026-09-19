import 'package:flutter/material.dart';
import 'package:my_boxy_ds/ui/design_tokens/design_tokens.dart';
import '../labels/mb_title_subtitled_label.dart';
import '../mb_separator.dart';
import '../tiles/mb_light_item_tile.dart';
import 'mb_box_rounded_container.dart';

class MBActionTiledListView extends StatelessWidget {

  const MBActionTiledListView({
    super.key,
    this.sectionTitle,
    required this.items,
    this.padding,
    this.onTap,
  });

  final String? sectionTitle;
  final List<MBLightItemTile> items;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppSizes.medium),
      child: Column(
        spacing: AppSizes.small,
        children: [
          MBTitleSubtitled(title: sectionTitle ?? ''),
          MBBoxRoundedContainer(
            padding: EdgeInsets.symmetric(vertical: AppSizes.md),
            child: Column(
              children: items.map(
                (item) => Column(
                  children: [
                    item,
                    if (item != items.last)
                      MBSeparator(color: AppColors.grey400,),
                  ],
                )
              ).toList()
            )
          )
        ],
      ),
    );
  }
}