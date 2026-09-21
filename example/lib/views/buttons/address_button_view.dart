import 'package:flutter/material.dart';
import 'package:my_boxy_ds/components/containers/mb_main_view.dart';
import 'package:my_boxy_ds/ui/design_tokens/design_tokens.dart';
import 'package:my_boxy_ds/components/buttons/mb_address_item_btn.dart';

class _AddressItem {
  const _AddressItem({
    required this.title,
    required this.address,
    required this.iconName,
  });

  final String title;
  final String address;
  final String iconName;
}

class AddressButtonView extends StatefulWidget {
  const AddressButtonView({super.key});

  @override
  State<AddressButtonView> createState() => _AddressButtonViewState();
}

class _AddressButtonViewState extends State<AddressButtonView> {
  int _selectedIndex = 0;

  final List<_AddressItem> _listItems = const [
    _AddressItem(
      title: 'Casa - Principal',
      address: 'Rua Enguaguaçu, 137 - Ap 22 - Ponta da Praia\nSantos - SP - 11045-000',
      iconName: 'house',
    ),
    _AddressItem(
      title: 'Trabalho',
      address:
          'Av. Ana Costa, 123 - Sala 45 - Boqueirão\nSantos - SP - 11060-000',
      iconName: 'briefcase_business',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MBMainView(
      viewTitle: 'Botão de Endereço',
      hasBottomMenu: false,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.medium,
          vertical: AppSizes.medium,
        ),
        child: SingleChildScrollView(
          child: Column(
            spacing: AppSizes.medium,
            children: List.generate(_listItems.length, (index) {
              return MBAddressItemButton(
                title: _listItems[index].title,
                address: _listItems[index].address,
                iconName: _listItems[index].iconName,
                isSelected: _selectedIndex == index,
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              );
            }),
          ),
        ),
      ),
    );
  }
}
