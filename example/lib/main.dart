import 'package:example/views/buttons/square_buttons.dart';
import 'package:example/views/containers/containers_view.dart';
import 'package:example/views/tiles/cart_item_tile_view.dart';
import 'package:flutter/material.dart';
import 'package:my_boxy_ds/components/cards/mb_list_component_card.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'MyBoxy UI'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  void _pushView(BuildContext context, Widget view) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => view),
    );
  }

  @override
  Widget build(BuildContext context) {

    void _pushView(Widget view) {
      Navigator.push(
        context, MaterialPageRoute(builder: (context) => view),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildSection('Botões', [
              MBListComponentCard(
                title: 'Botão Principal',
                icon: Icons.input,
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder:),
                  // );
                },
              ),
              MBListComponentCard(
                  title: 'Botões Quadrados', icon: LucideIcons.a_arrow_up,
                  onTap: () => _pushView(SquareButtons())),
            ]),
            _buildSection('Inputs', [
              MBListComponentCard(
                title: 'Main Input',
                icon: Icons.input,
                onTap: () => {},
              ),
            ]),
            _buildSection('Containers', [
              MBListComponentCard(
                title: 'Checkout Tile Container',
                icon: Icons.input,
                onTap: () => _pushView(CheckoutTileContainerView()),
              ),
            ]),
            _buildSection('Tile Items', [
              MBListComponentCard(
                title: 'Cart Item Tile',
                icon: Icons.input,
                onTap: () => _pushView(CartItemTileView()),
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
          const EdgeInsets.only(left: 20, bottom: 20),
          child: Text(title),
        ),
        ...children,
      ],
    );
  }
}