import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_boxy_ds/components/containers/mb_section_titled.dart';

Widget _wrap(Widget child) => MaterialApp(home: Scaffold(body: child));

void main() {
  testWidgets('sem texto e sem child mostra só o título, sem erro', (tester) async {
    await tester.pumpWidget(_wrap(const MBSectionTitled(title: 'Observações')));

    expect(tester.takeException(), isNull);
    expect(find.text('Observações'), findsOneWidget);
  });

  testWidgets('texto vazio sem child também não quebra', (tester) async {
    await tester.pumpWidget(_wrap(const MBSectionTitled(title: 'Descrição', text: '')));

    expect(tester.takeException(), isNull);
  });

  testWidgets('mostra o texto quando não há child', (tester) async {
    await tester.pumpWidget(_wrap(const MBSectionTitled(title: 'Descrição', text: 'Vaso de cerâmica')));

    expect(find.text('Vaso de cerâmica'), findsOneWidget);
  });

  testWidgets('child tem prioridade sobre o texto', (tester) async {
    await tester.pumpWidget(_wrap(const MBSectionTitled(
      title: 'Seção',
      text: 'texto',
      child: Text('conteúdo'),
    )));

    expect(find.text('conteúdo'), findsOneWidget);
    expect(find.text('texto'), findsNothing);
  });
}
