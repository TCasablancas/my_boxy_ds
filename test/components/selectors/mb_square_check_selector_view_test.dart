import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_boxy_ds/components/selectors/mb_square_check_selector.dart';

void main() {
  testWidgets('reports inverted selection when tapped', (tester) async {
    bool? selected;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MBSquareCheckSelectorView(
            label: 'Pix',
            isSelected: false,
            onSelectionChanged: (value) => selected = value,
          ),
        ),
      ),
    );

    await tester.tap(find.text('Pix'));

    expect(selected, isTrue);
  });
}
