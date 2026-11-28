import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_boxy_ds/components/input/mb_text_input.dart';
import 'package:my_boxy_ds/ui/design_tokens/design_tokens.dart';

void main() {
  testWidgets('keeps fixed height and single line', (tester) async {
    final controller = TextEditingController();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MBTextInput(
            controller: controller,
            height: 64,
            hasBackground: false,
          ),
        ),
      ),
    );

    final input = tester.widget<TextField>(find.byType(TextField));
    final size = tester.getSize(find.byType(MBTextInput));

    // Campo com a altura pedida + margem do container (em cima e embaixo).
    expect(size.height, 64 + AppSizes.small * 2);
    expect(input.maxLines, 1);
    expect(input.keyboardType, TextInputType.text);
  });
}
