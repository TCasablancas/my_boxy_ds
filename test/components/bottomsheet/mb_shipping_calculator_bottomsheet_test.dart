import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_boxy_ds/components/bottomsheet/mb_shipping_calculator_bottomsheet.dart';
import 'package:my_boxy_ds/components/buttons/mb_main_btn.dart';

const _address = MBShippingAddress(
  title: 'Casa',
  description: 'Av. Almirante Wandenkolk, 1342 - Umarizal, Belém - PA',
);

void main() {
  Future<void> pumpSheet(
    WidgetTester tester, {
    MBShippingAddress? address,
    bool localDeliveryAvailable = false,
    VoidCallback? onAddAddress,
    ValueChanged<MBShippingOption>? onCalculate,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: MBShippingCalculatorBottomsheet(
              address: address,
              localDeliveryAvailable: localDeliveryAvailable,
              onAddAddress: onAddAddress ?? () {},
              onCalculate: onCalculate ?? (_) {},
            ),
          ),
        ),
      ),
    );
  }

  MBMainButtonType buttonType(WidgetTester tester) =>
      tester.widget<MBMainButton>(find.byType(MBMainButton)).buttonType;

  testWidgets('without address shows add CTA and disables button',
      (tester) async {
    var addTapped = false;
    await pumpSheet(tester, onAddAddress: () => addTapped = true);

    expect(buttonType(tester), MBMainButtonType.disabled);

    await tester.tap(find.text('Cadastrar endereço'));
    expect(addTapped, isTrue);
  });

  testWidgets('shows address and enables button', (tester) async {
    await pumpSheet(tester, address: _address);

    expect(find.text('Casa'), findsOneWidget);
    expect(find.text('Cadastrar endereço'), findsNothing);
    expect(buttonType(tester), MBMainButtonType.normal);
  });

  testWidgets('hides local options when not available', (tester) async {
    await pumpSheet(tester, address: _address);

    expect(find.text('Transportadora / Correios'), findsOneWidget);
    expect(find.text('Retirada pelo cliente'), findsNothing);
    expect(find.text('Entrega em mãos'), findsNothing);
  });

  testWidgets('calculates with standard by default', (tester) async {
    final results = <MBShippingOption>[];
    await pumpSheet(tester, address: _address, onCalculate: results.add);

    await tester.ensureVisible(find.byType(MBMainButton));
    await tester.tap(find.byType(MBMainButton));

    expect(results, [MBShippingOption.standard]);
  });

  testWidgets('calculates with selected local option', (tester) async {
    final results = <MBShippingOption>[];
    await pumpSheet(
      tester,
      address: _address,
      localDeliveryAvailable: true,
      onCalculate: results.add,
    );

    await tester.ensureVisible(find.text('Entrega em mãos'));
    await tester.tap(find.text('Entrega em mãos'));
    await tester.pump();
    await tester.ensureVisible(find.byType(MBMainButton));
    await tester.tap(find.byType(MBMainButton));

    expect(results, [MBShippingOption.handDelivery]);
  });

  testWidgets('falls back to standard when local delivery is revoked',
      (tester) async {
    final results = <MBShippingOption>[];
    await pumpSheet(
      tester,
      address: _address,
      localDeliveryAvailable: true,
      onCalculate: results.add,
    );
    await tester.ensureVisible(find.text('Retirada pelo cliente'));
    await tester.tap(find.text('Retirada pelo cliente'));
    await tester.pump();

    await pumpSheet(tester, address: _address, onCalculate: results.add);
    await tester.ensureVisible(find.byType(MBMainButton));
    await tester.tap(find.byType(MBMainButton));

    expect(results, [MBShippingOption.standard]);
  });
}
