import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_boxy_ds/components/buttons/mb_address_item_btn.dart';

void main() {
  testWidgets('renders Lucide icon resolved from model icon name', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: MBAddressItemButton(
            title: 'Work',
            address: '123 Main Street',
            iconName: 'LucideIcons.briefcase_business',
            isSelected: false,
          ),
        ),
      ),
    );

    expect(find.byIcon(LucideIcons.briefcase_business), findsOneWidget);
  });

  test('rejects unsupported model icon names', () {
    expect(
      () => MBAddressLucideIcons.fromName('not_an_address_icon'),
      throwsArgumentError,
    );
  });
}
