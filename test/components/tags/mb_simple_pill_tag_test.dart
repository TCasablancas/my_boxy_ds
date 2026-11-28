import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_boxy_ds/components/tags/mb_simple_pill_tag.dart';
import 'package:my_boxy_ds/ui/design_tokens/design_tokens.dart';

Color? _background(WidgetTester tester, String title) {
  final container = tester.widget<AnimatedContainer>(
    find.ancestor(of: find.text(title), matching: find.byType(AnimatedContainer)),
  );
  return (container.decoration as BoxDecoration?)?.color;
}

Widget _app(Widget child) => MaterialApp(home: Scaffold(body: child));

void main() {
  testWidgets('toque alterna a seleção e troca o fundo', (tester) async {
    final changes = <bool>[];
    await tester.pumpWidget(_app(MBSimplePillTag(title: 'Cerâmica', onSelectedChanged: changes.add)));

    expect(_background(tester, 'Cerâmica'), AppColors.neutral100);

    await tester.tap(find.text('Cerâmica'));
    await tester.pumpAndSettle();
    expect(_background(tester, 'Cerâmica'), AppColors.primary);

    await tester.tap(find.text('Cerâmica'));
    await tester.pumpAndSettle();
    expect(_background(tester, 'Cerâmica'), AppColors.neutral100);
    expect(changes, [true, false]);
  });

  testWidgets('vários pills ficam selecionados ao mesmo tempo', (tester) async {
    await tester.pumpWidget(_app(const Row(children: [
      MBSimplePillTag(title: 'A'),
      MBSimplePillTag(title: 'B'),
      MBSimplePillTag(title: 'C'),
    ])));

    await tester.tap(find.text('A'));
    await tester.tap(find.text('C'));
    await tester.pumpAndSettle();

    expect(_background(tester, 'A'), AppColors.primary);
    expect(_background(tester, 'B'), AppColors.neutral100);
    expect(_background(tester, 'C'), AppColors.primary);
  });

  testWidgets('controlado: segue isSelected e só avisa o toque', (tester) async {
    bool? requested;
    await tester.pumpWidget(_app(MBSimplePillTag(
      title: 'A',
      isSelected: false,
      onSelectedChanged: (value) => requested = value,
    )));

    await tester.tap(find.text('A'));
    await tester.pumpAndSettle();

    expect(requested, isTrue);
    expect(_background(tester, 'A'), AppColors.neutral100);
  });
}
