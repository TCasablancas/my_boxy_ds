import 'package:example/common/navigation_service.dart';
import 'package:example/views/home/home_factory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('loads sections from package asset', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        navigatorKey: NavigationService.instance.navigatorKey,
        home: HomeFactory.make(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Botões'), findsOneWidget);
    expect(find.text('Botões Quadrados'), findsNWidgets(2));

    await tester.tap(find.text('Checkout Tile Container').first);
    await tester.pumpAndSettle();

    expect(find.text('Checkout Tile Container View'), findsOneWidget);
  });
}
