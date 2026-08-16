import 'package:flutter/material.dart';
import 'package:my_boxy_ds/components/buttons/mb_main_btn.dart';
import 'package:my_boxy_ds/components/cards/mb_list_component_card.dart';
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

  @override
  Widget build(BuildContext context) {
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
            ]),
            _buildSection('Inputs', [
              MBListComponentCard(
                title: 'Main Input',
                icon: Icons.input,
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder:),
                  // );
                },
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