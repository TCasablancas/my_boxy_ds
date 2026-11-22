import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_boxy_ds/components/containers/mb_shrink_content.dart';
import 'package:my_boxy_ds/ui/design_tokens/design_tokens.dart';

// Conteúdo de 240 + respiro inferior do componente (AppSizes.large).
const _expandedHeight = 240 + AppSizes.large;

void main() {
  testWidgets('starts collapsed and expands to content height', (tester) async {
    final childKey = GlobalKey();

    await tester.pumpWidget(
      MaterialApp(
        home: Align(
          alignment: Alignment.topCenter,
          child: MBShrinkContentView(
            child: SizedBox(
              key: childKey,
              height: 240,
              child: const Text('Conteúdo'),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Ver mais'), findsOneWidget);
    expect(
      tester.getSize(find.byType(TweenAnimationBuilder<double>)).height,
      90,
    );
    final childTop = tester.getTopLeft(find.byKey(childKey)).dy;

    await tester.tap(find.text('Ver mais'));
    await tester.pump(const Duration(milliseconds: 120));
    expect(tester.getTopLeft(find.byKey(childKey)).dy, childTop);
    await tester.pumpAndSettle();

    expect(find.text('Ver menos'), findsOneWidget);
    expect(
      tester.getSize(find.byType(TweenAnimationBuilder<double>)).height,
      _expandedHeight,
    );

    await tester.tap(find.text('Ver menos'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 120));
    expect(
      tester.getSize(find.byType(TweenAnimationBuilder<double>)).height,
      greaterThan(90),
    );
    expect(
      tester.getSize(find.byType(TweenAnimationBuilder<double>)).height,
      lessThan(_expandedHeight),
    );
  });
}
