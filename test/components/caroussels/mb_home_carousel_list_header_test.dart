import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_boxy_ds/components/caroussels/mb_home_carousel_list_header.dart';

Widget _wrap(Widget child) => MaterialApp(home: Scaffold(body: child));

MBHomeCarouselItem _item(String id) => MBHomeCarouselItem(
      id: id,
      imageUrl: 'https://cdn.test/$id.webp',
      altText: 'Banner $id',
    );

void main() {
  testWidgets('usa o imageBuilder e expõe o texto alternativo', (tester) async {
    final semantics = tester.ensureSemantics();
    await tester.pumpWidget(_wrap(MBHomeCarouselListHeader(
      items: [_item('a')],
      imageBuilder: (context, item) => Text('img ${item.id}'),
    )));

    expect(find.text('img a'), findsOneWidget);
    expect(find.bySemanticsLabel(RegExp('Banner a')), findsOneWidget);
    semantics.dispose();
  });

  testWidgets('trocar a lista atualiza os cards', (tester) async {
    Widget carousel(List<MBHomeCarouselItem> items) => _wrap(MBHomeCarouselListHeader(
          items: items,
          imageBuilder: (context, item) => Text('img ${item.id}'),
        ));

    await tester.pumpWidget(carousel([_item('a')]));
    expect(find.text('img a'), findsOneWidget);

    await tester.pumpWidget(carousel([_item('b')]));
    expect(find.text('img a'), findsNothing);
    expect(find.text('img b'), findsOneWidget);
  });

  testWidgets('lista vazia não ocupa espaço', (tester) async {
    await tester.pumpWidget(_wrap(const MBHomeCarouselListHeader(items: [])));

    expect(find.byType(PageView), findsNothing);
  });

  testWidgets('toque no card avisa qual item', (tester) async {
    MBHomeCarouselItem? tapped;
    await tester.pumpWidget(_wrap(MBHomeCarouselListHeader(
      items: [_item('a')],
      imageBuilder: (context, item) => const SizedBox.expand(),
      onPressItem: (item) => tapped = item,
    )));

    await tester.tap(find.byType(GestureDetector).first);
    expect(tapped?.id, 'a');
  });
}
