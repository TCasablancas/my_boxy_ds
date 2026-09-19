import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_boxy_ds/components/input/mb_main_input.dart';

void main() {
  Future<TextEditingController> pumpInput(
    WidgetTester tester,
    MBInputFieldType fieldType, {
    bool readOnly = false,
  }) async {
    final controller = TextEditingController();
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MBMainInput(
            label: 'Label',
            controller: controller,
            fieldType: fieldType,
            readOnly: readOnly,
          ),
        ),
      ),
    );
    return controller;
  }

  testWidgets('formats birthdate input', (tester) async {
    final controller = await pumpInput(tester, MBInputFieldType.birthdate);

    await tester.enterText(find.byType(TextField), '01011990');

    expect(controller.text, '01/01/1990');
  });

  testWidgets('formats CPF input', (tester) async {
    final controller = await pumpInput(tester, MBInputFieldType.cpf);

    await tester.enterText(find.byType(TextField), '12345678901');

    expect(controller.text, '123.456.789-01');
  });

  testWidgets('formats mobile and landline phone input', (tester) async {
    final controller = await pumpInput(tester, MBInputFieldType.phone);

    await tester.enterText(find.byType(TextField), '11987654321');
    expect(controller.text, '(11) 98765-4321');

    await tester.enterText(find.byType(TextField), '1134567890');
    expect(controller.text, '(11) 3456-7890');
  });

  testWidgets('disables read-only input interaction', (tester) async {
    await pumpInput(tester, MBInputFieldType.generic, readOnly: true);
    final input = tester.widget<TextField>(find.byType(TextField));
    final inputIgnorePointer = tester.widget<IgnorePointer>(
      find
          .ancestor(
            of: find.byType(TextField),
            matching: find.byType(IgnorePointer),
          )
          .first,
    );

    expect(input.readOnly, isTrue);
    expect(input.enabled, isFalse);
    expect(inputIgnorePointer.ignoring, isTrue);
  });
}
