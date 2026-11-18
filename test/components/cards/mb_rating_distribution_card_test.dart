import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_boxy_ds/components/cards/mb_rating_distribution_card.dart';

void main() {
  testWidgets('mostra 5 barras de 5 a 1 e emite a nota tocada', (tester) async {
    int? tapped;
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: MBRatingDistributionCard(
          counts: const {5: 3, 4: 1},
          onRatingTap: (r) => tapped = r,
        ),
      ),
    ));

    final bars = tester.widgetList<LinearProgressIndicator>(find.byType(LinearProgressIndicator)).toList();
    expect(bars, hasLength(5));
    expect(bars.first.value, 0.75);
    expect(bars.last.value, 0);

    await tester.tap(find.text('4'));
    expect(tapped, 4);
  });

  testWidgets('sem avaliações as barras ficam vazias', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(body: MBRatingDistributionCard(counts: {})),
    ));
    final bars = tester.widgetList<LinearProgressIndicator>(find.byType(LinearProgressIndicator));
    expect(bars.every((b) => b.value == 0), isTrue);
  });
}
