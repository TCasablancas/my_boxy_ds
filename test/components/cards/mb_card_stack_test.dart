import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_boxy_ds/components/cards/mb_card_stack.dart';
import 'package:my_boxy_ds/components/cards/mb_comment_product_card.dart';

void main() {
  testWidgets('mostra comentário e dispara toque no card empilhado', (
    tester,
  ) async {
    var tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: MBCardStackView(
              child: MBCommentProductCard(
                userName: 'Ana S.',
                userAlias: 'ana.ceramica',
                createdAt: '2 dias atrás',
                imageUrl: '',
                commentText: 'Lindo!',
                onTap: () => tapped = true,
              ),
            ),
          ),
        ),
      ),
    );

    expect(find.text('Lindo!'), findsOneWidget);

    await tester.tap(find.text('Lindo!'));

    expect(tapped, isTrue);
  });
}
