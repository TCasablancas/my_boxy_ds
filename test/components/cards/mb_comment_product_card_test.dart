import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_boxy_ds/components/cards/mb_comment_product_card.dart';

void main() {
  testWidgets('mostra alias, nota, fotos e curtidas recebidos', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: MBCommentProductCard(
          userName: 'Ana S.',
          userAlias: 'ana.ceramica',
          createdAt: '2 dias atrás',
          imageUrl: '',
          commentText: 'Lindo!',
          rating: '5',
          photosCount: 3,
          likesCount: 12,
        ),
      ),
    ));

    expect(find.text('ana.ceramica'), findsOneWidget);
    expect(find.text('5'), findsOneWidget);
    expect(find.text('3'), findsOneWidget);
    expect(find.text('12'), findsOneWidget);
  });
}
