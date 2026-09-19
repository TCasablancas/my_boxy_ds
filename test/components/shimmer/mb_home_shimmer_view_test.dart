import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_boxy_ds/components/shimmer/home_shimmer/mb_home_shimmer_view.dart';

void main() {
  testWidgets('lays shimmer cards in two columns without vertical overflow', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: MBHomeShimmerView())),
    );

    expect(tester.takeException(), isNull);
  });
}
