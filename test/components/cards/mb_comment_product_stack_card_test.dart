import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_boxy_ds/components/cards/mb_comment_product_stack_card.dart';

void main() {
  testWidgets('mostra comentário e dispara toque no card empilhado', (
    tester,
  ) async {
    var tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MBCommentProductStackCard(
            userName: 'Ana S.',
            userAlias: 'ana.ceramica',
            imageUrl: '',
            commentText: 'Lindo!',
            onTap: () => tapped = true,
          ),
        ),
      ),
    );

    expect(find.text('Lindo!'), findsOneWidget);

    await tester.tap(find.text('Lindo!'));

    expect(tapped, isTrue);
  });
}
