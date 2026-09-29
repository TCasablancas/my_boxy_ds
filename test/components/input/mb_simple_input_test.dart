import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_boxy_ds/components/input/mb_simple_input.dart';
import 'package:my_boxy_ds/ui/design_tokens/app_fonts.dart';

void main() {
  testWidgets('uses SFMono text style and grows primary line on focus', (
    tester,
  ) async {
    final focusNode = FocusNode();
    addTearDown(focusNode.dispose);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MBSimpleInputView(
            focusNode: focusNode,
            hintText: 'Digite aqui',
          ),
        ),
      ),
    );

    expect(
      tester.widget<TextField>(find.byType(TextField)).style!.fontFamily,
      AppFonts.mono,
    );

    final focusLine = find.byKey(const ValueKey('mb-simple-input-focus-line'));
    expect(tester.getSize(focusLine).width, 0);

    await tester.tap(find.byType(TextField));
    await tester.pumpAndSettle();

    expect(tester.getSize(focusLine).width, greaterThan(0));
  });
}
