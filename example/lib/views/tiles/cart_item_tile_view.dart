import 'package:flutter/material.dart';
import 'package:my_boxy_ds/components/containers/mb_main_view.dart';
import 'package:my_boxy_ds/components/tiles/mb_cart_item_tile.dart';

class CartItemTileView extends StatefulWidget {
  const CartItemTileView({super.key});

  @override
  State<CartItemTileView> createState() => _CartItemTileViewState();
}

class _CartItemTileViewState extends State<CartItemTileView> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return MBMainView(
      viewTitle: 'Célula de Lista - Carrinho',
      hasBottomMenu: false,
      child: SingleChildScrollView(
        child: Column(
        children: [
          MBCartItemTile(
            imgUrl: 'https://http2.mlstatic.com/D_NQ_NP_2X_698975-MLB113963761427_062026-F-vela-aromatica-perfumada-200g-flor-de-cerejeira-liriah.webp',
            title: 'Vela Aromática Decorativa Fragância Perfumada Premium 200g',
            count: _count,
            onCountChanged: (count) {
              setState(() {
                _count = count;
              });
            },
            price: 12.99, oldPrice: 10.99,
            isSelected: true,
            onSelectionChanged: (int value) {  },
          ),
          MBCartItemTile(
            imgUrl: '',
            title: 'Vela Aromática Decorativa Fragância Perfumada Premium 200g',
            count: _count,
            onCountChanged: (count) {
              setState(() {
                _count = count;
              });
            },
            price: 12.99, oldPrice: 10.99,
            isSelected: false,
            onSelectionChanged: (int value) {  },
          ),
          MBCartItemTile(
            imgUrl: '',
            title: 'Vela Aromática Decorativa Fragância Perfumada Premium 200g',
            count: _count,
            onCountChanged: (count) {
              setState(() {
                _count = count;
              });
            },
            price: 12.99, oldPrice: 10.99,
            isSelected: false,
            onSelectionChanged: (int value) {  },
          ),
        ])
      ),
    );
  }
}
