import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_boxy_ds/components/caroussels/mb_onboarding_type_carousel.dart';

void main() {
  const items = [
    MBOnboardingCarouselItem(title: 'Primeiro passo', data: 'first'),
    MBOnboardingCarouselItem(title: 'Último passo', data: 'last'),
  ];

  testWidgets('moves between cards and completes on last card', (tester) async {
    var completedItem = '';
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MBOnboardingTypeCarousel<String>(
            items: items,
            itemBuilder: (context, item, index) => Text(item.data),
            bottomWidgetsBuilder:
                (context, item, index, onNext, onPrevious, onExit) => [
                  TextButton(
                    onPressed: onNext,
                    child: Text(
                      index == items.length - 1 ? 'Concluir' : 'Continuar',
                    ),
                  ),
                ],
            onCompleted: (item) => completedItem = item.data,
          ),
        ),
      ),
    );

    expect(find.text('Primeiro passo'), findsOneWidget);
    expect(find.text('first'), findsOneWidget);

    await tester.tap(find.text('Continuar'));
    await tester.pumpAndSettle();

    expect(find.text('Último passo'), findsOneWidget);
    expect(find.text('last'), findsOneWidget);

    await tester.tap(find.text('Concluir'));
    await tester.pump();

    expect(completedItem, 'last');
  });

  testWidgets('renders parent-managed widgets and preserves their status', (
    tester,
  ) async {
    final isEnabled = ValueNotifier<bool>(false);
    addTearDown(isEnabled.dispose);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MBOnboardingTypeCarousel<String>(
            items: items,
            itemBuilder: (context, item, index) => const SizedBox(),
            bottomWidgetsBuilder:
                (context, item, index, onNext, onPrevious, onExit) => [
                  ValueListenableBuilder<bool>(
                    valueListenable: isEnabled,
                    builder: (context, enabled, child) => TextButton(
                      onPressed: enabled ? onNext : null,
                      child: const Text('Continuar'),
                    ),
                  ),
                ],
          ),
        ),
      ),
    );

    expect(
      tester.widget<TextButton>(find.byType(TextButton)).onPressed,
      isNull,
    );

    isEnabled.value = true;
    await tester.pump();

    expect(
      tester.widget<TextButton>(find.byType(TextButton)).onPressed,
      isNotNull,
    );
  });

  testWidgets('centers half-width progress and supports peek display', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MBOnboardingTypeCarousel<String>(
            items: items,
            display: MBOnboardingCarouselDisplay.peek,
            itemBuilder: (context, item, index) => Text(item.data),
          ),
        ),
      ),
    );

    expect(
      tester
          .widget<FractionallySizedBox>(find.byType(FractionallySizedBox))
          .widthFactor,
      .5,
    );
    expect(
      tester
          .widget<PageView>(find.byType(PageView))
          .controller!
          .viewportFraction,
      .88,
    );
  });
}
