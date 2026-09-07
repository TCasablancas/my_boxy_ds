import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_boxy_ds/components/cards/mb_rating_stars.dart';
import 'package:my_boxy_ds/components/cards/mb_review_count_text.dart';

void main() {
  testWidgets('renders a half star for every non-zero decimal rating', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: MBRatingStars(rating: 3.9)),
    );

    expect(find.byIcon(Icons.star_rounded), findsNWidgets(3));
    expect(find.byIcon(Icons.star_half_rounded), findsOneWidget);
    expect(find.byIcon(Icons.star_outline_rounded), findsOneWidget);

    await tester.pumpWidget(
      const MaterialApp(home: MBRatingStars(rating: 3.1)),
    );

    expect(find.byIcon(Icons.star_rounded), findsNWidgets(3));
    expect(find.byIcon(Icons.star_half_rounded), findsOneWidget);
  });

  testWidgets('formats thousands with one truncated decimal', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: MBReviewCountText(reviews: 6899)),
    );

    expect(find.text('6.8k Reviews'), findsOneWidget);
  });
}
