import 'package:flutter/material.dart';
import 'package:my_boxy_ds/components/containers/mb_main_view.dart';
import 'package:my_boxy_ds/components/containers/mb_checkout_tile_container.dart';
import 'package:my_boxy_ds/components/mb_separator.dart';
import 'package:my_boxy_ds/components/tiles/mb_checkout_item_tile.dart';
import 'package:my_boxy_ds/components/tiles/mb_checkout_product_tile.dart';
import 'package:my_boxy_ds/components/labels/mb_checkout_tile_value.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class CheckoutTileContainerView extends StatefulWidget {
  const CheckoutTileContainerView({ super.key });

  @override
  State<CheckoutTileContainerView> createState() => _CheckoutTileContainerViewState();

}

class _CheckoutTileContainerViewState extends State<CheckoutTileContainerView> {
  @override
  Widget build(BuildContext context) {
    return MBMainView(
      viewTitle: "Checkout Tile Container View",
      hasBottomMenu: false,
      child: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              spacing: 16.0,
              children: [
                MBCheckoutTileContainer(
                  title: 'Entrega',
                  iconAction: LucideIcons.square_pen,
                  onTapAction: () {},
                  children: [
                    MBCheckoutItemTile(
                        icon: LucideIcons.map_pin,
                        label: 'Casa - via Sedex',
                        description: 'Rua General Jardim, 120\nVila Buarque - São Paulo - SP\nCEP 01223-010'
                    )
                  ],
                ),
                MBCheckoutTileContainer(
                  title: 'Método de Pagamento',
                  iconAction: LucideIcons.square_pen,
                  onTapAction: () {},
                  children: [
                    MBCheckoutItemTile(
                        icon: LucideIcons.credit_card,
                        label: 'Cartão de Crédito',
                        description: 'MasterCard **** 4905'
                    )
                  ],
                ),
                MBSeparator(),
                MBCheckoutTileContainer(
                  title: 'Produtos',
                  iconAction: LucideIcons.square_pen,
                  onTapAction: () {},
                  children: [
                    MBCheckoutProductTile(),
                    MBCheckoutProductTile()
                  ],
                ),
                MBCheckoutTileContainer(
                  title: 'Valores',
                  iconAction: LucideIcons.square_pen,
                  onTapAction: () {},
                  children: [
                    MBCheckoutTileValue(title: 'Produtos', value: 144.56),
                    MBCheckoutTileValue(title: 'Descontos', value: 144.56),
                    MBCheckoutTileValue(title: 'Cupons', value: 144.56),
                    MBCheckoutTileValue(title: 'Taxas', value: 144.56),
                    MBCheckoutTileValue(title: 'Total', isMain: true, value: 144.56),
                  ],
                ),
              ],
            )
        ),
      )
    );
  }
}