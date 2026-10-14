import 'package:flutter/material.dart';
import 'package:my_boxy_ds/components/containers/mb_action_tiled_list_view.dart';
import 'package:my_boxy_ds/components/containers/mb_main_view.dart';
import 'package:my_boxy_ds/components/tiles/mb_light_item_tile.dart';
import 'package:my_boxy_ds/ui/design_tokens/design_tokens.dart';
import 'home_controller.dart';

class HomeView extends StatefulWidget {

  final HomeController controller;

  const HomeView({
    super.key,
    required this.controller,
  });

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final coordinator = widget.controller.coordinator;
  late final viewModel = widget.controller.viewModel;

  final itemPadding = EdgeInsets.symmetric(
    horizontal: AppSizes.medium,
    vertical: AppSizes.small,
  );

  @override
  void initState() {
    super.initState();
    viewModel.addListener(_onViewModelChanged);
    viewModel.fetchHomeListItems();
  }

  @override
  void dispose() {
    viewModel.removeListener(_onViewModelChanged);
    super.dispose();
  }

  void _onViewModelChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {

    return MBMainView(
      viewTitle: 'MyBoxyUI',
      backButton: false,
      hasBottomMenu: false,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: viewModel.listItems.map((item) {
          return MBActionTiledListView(
            sectionTitle: item.title,
            items: item.items.map((subItem) {
              return MBLightItemTile(
                padding: itemPadding,
                icon: subItem.icon,
                label: subItem.label,
                actionIcon: subItem.actionIcon,
                onTap: () => coordinator.navigate(subItem.path),
              );
            }).toList()
          );
        }).toList(),
      ),
    );
  }
}