import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_boxy_ds/components/headers/mb_home_header.dart';

Widget _wrap(Widget child, {double width = 360}) => MaterialApp(
      home: Scaffold(body: SizedBox(width: width, child: child)),
    );

void main() {
  testWidgets('mostra nome, @alias e local', (tester) async {
    await tester.pumpWidget(_wrap(const MBHomeHeader(
      userName: 'Ana Souza',
      userAlias: 'ana.souza',
      location: 'Santos - SP',
    )));

    expect(find.textContaining('Ana Souza', findRichText: true), findsOneWidget);
    expect(find.text('@ana.souza'), findsOneWidget);
    expect(find.text('Santos - SP'), findsOneWidget);
  });

  testWidgets('visitante: sem alias e com saudação própria', (tester) async {
    await tester.pumpWidget(_wrap(const MBHomeHeader(
      greeting: 'Olá! ',
      userName: 'Bora descobrir?',
    )));

    expect(find.textContaining('Bora descobrir?', findRichText: true), findsOneWidget);
    expect(find.textContaining('@'), findsNothing);
    expect(find.byIcon(Icons.location_pin), findsNothing);
  });

  testWidgets('nome e alias longos truncam sem estourar o layout', (tester) async {
    await tester.pumpWidget(_wrap(
      MBHomeHeader(
        userName: 'Maria ${'Aparecida ' * 10}Souza',
        userAlias: 'alias.muito.comprido.${'x' * 40}',
        location: 'São José dos Campos - SP',
        rightBtns: const [SizedBox(width: 36, height: 36)],
      ),
      width: 320,
    ));

    expect(tester.takeException(), isNull);
  });

  testWidgets('local com toque e convite', (tester) async {
    var taps = 0;
    await tester.pumpWidget(_wrap(MBHomeHeader(
      userName: 'Ana',
      userAlias: 'ana',
      location: 'Informar localização',
      locationAction: 'Cadastrar endereço',
      onLocationTap: () => taps++,
    )));

    await tester.tap(find.text('Informar localização'));
    expect(taps, 1);
    expect(find.text('Cadastrar endereço'), findsOneWidget);
  });

  testWidgets('carregando mostra skeleton e nenhum texto', (tester) async {
    await tester.pumpWidget(_wrap(const MBHomeHeader(userName: 'Ana', userAlias: 'ana', isLoading: true)));

    expect(find.textContaining('Ana', findRichText: true), findsNothing);
    expect(find.text('@ana'), findsNothing);
  });
}
