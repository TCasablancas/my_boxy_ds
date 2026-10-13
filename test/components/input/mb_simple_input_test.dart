import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_boxy_ds/components/input/mb_simple_input.dart';
import 'package:my_boxy_ds/ui/design_tokens/app_fonts.dart';

void main() {
  testWidgets('uses primary text style and grows focus line', (tester) async {
    final focusNode = FocusNode();
    addTearDown(focusNode.dispose);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MBSimpleInput(focusNode: focusNode, hintText: 'Digite aqui'),
        ),
      ),
    );

    expect(
      tester.widget<TextField>(find.byType(TextField)).style!.fontFamily,
      AppFonts.primary,
    );

    final focusLine = find.byKey(const ValueKey('mb-simple-input-focus-line'));
    expect(tester.getSize(focusLine).width, 0);

    await tester.tap(find.byType(TextField));
    await tester.pumpAndSettle();

    expect(tester.getSize(focusLine).width, greaterThan(0));
  });

  testWidgets('honors minimum lines and grows with text', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 300,
            child: MBSimpleInput(minLines: 3, maxLines: 5),
          ),
        ),
      ),
    );

    final input = find.byType(MBSimpleInput);
    final initialHeight = tester.getSize(input).height;
    final textField = find.byType(TextField);

    expect(tester.widget<TextField>(textField).minLines, 3);
    expect(tester.widget<TextField>(textField).maxLines, 5);

    await tester.enterText(textField, 'um\ndois\ntres\nquatro');
    await tester.pump();

    expect(tester.getSize(input).height, greaterThan(initialHeight));
  });
}
