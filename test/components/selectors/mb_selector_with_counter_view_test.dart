import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_boxy_ds/components/selectors/mb_selector_with_counter.dart';

void main() {
  testWidgets('selects radio card and disables its counter when unselected', (
    tester,
  ) async {
    bool? selected;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 250,
            child: MBSelectorWithCounterView(
              icon: Icons.inventory_2_outlined,
              label: 'Pronta entrega',
              description: 'Envio em até',
              counterLabel: 'dias úteis',
              count: 0,
              isSelected: false,
              type: MBSelectorWithCounterType.radio,
              onCountChanged: (_) {},
              onSelectionChanged: (value) => selected = value,
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Pronta entrega'));
    expect(selected, isTrue);

    expect(
      tester
          .widgetList<IgnorePointer>(find.byType(IgnorePointer))
          .any((widget) => widget.ignoring),
      isTrue,
    );
  });
}
