import 'package:example/common/navigation_service.dart';
import 'package:example/views/home/home_factory.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: NavigationService.instance.navigatorKey,
      home: HomeFactory.make(),
    );
  }
}


//   MBMainView(
//   viewTitle: 'MyBoxy UI',
//   backButton: false,
//   hasBottomMenu: false,
//   child: ListView(
//     padding: const EdgeInsets.all(16),
//     children: [
//       MBActionTiledListView(
//         sectionTitle: 'Containers',
//         items: [
//           MBLightItemTile(
//             icon: LucideIcons.box,
//             label: 'Containers',
//             actionIcon: LucideIcons.chevron_right,
//             onTap: () => _pushView(context, SizedBox()),
//           ),
//           MBLightItemTile(
//             icon: LucideIcons.box,
//             label: 'Containers',
//             actionIcon: LucideIcons.chevron_right,
//             onTap: () => _pushView(context, SizedBox()),
//           ),
//         ],
//       ),
//       _buildSection('Botões', [
//         MBListComponentCard(
//           title: 'Botão Principal',
//           icon: Icons.input,
//           onTap: () {
//             // Navigator.push(
//             //   context,
//             //   MaterialPageRoute(builder:),
//             // );
//           },
//         ),
//         MBListComponentCard(
//             title: 'Botões Quadrados', icon: LucideIcons.a_arrow_up,
//             onTap: () => _pushView(context, SquareButtons())),
//       ]),
//       _buildSection('Inputs', [
//         MBListComponentCard(
//           title: 'Main Input',
//           icon: Icons.input,
//           onTap: () => {},
//         ),
//       ]),
//       _buildSection('Containers', [
//         MBListComponentCard(
//           title: 'Checkout Tile Container',
//           icon: Icons.input,
//           onTap: () => _pushView(context, CheckoutTileContainerView()),
//         ),
//       ]),
//       _buildSection('Tile Items', [
//         MBListComponentCard(
//           title: 'Cart Item Tile',
//           icon: Icons.input,
//           onTap: () => _pushView(context, CartItemTileView()),
//         ),
//       ]),
//     ],
//   ),
// );