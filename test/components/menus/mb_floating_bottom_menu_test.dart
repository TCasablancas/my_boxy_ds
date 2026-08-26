import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_boxy_ds/components/menus/mb_floating_bottom_menu.dart';

void main() {
  testWidgets('fades child and disables taps while hidden', (tester) async {
    var taps = 0;
    var isVisible = false;

    await tester.pumpWidget(
      MaterialApp(
        home: StatefulBuilder(
          builder: (context, setState) {
            return Scaffold(
              body: Stack(
                children: [
                  TextButton(
                    onPressed: () => setState(() => isVisible = !isVisible),
                    child: const Text('Toggle menu'),
                  ),
                  MBFloatingBottomMenu(
                    isVisible: isVisible,
                    child: ElevatedButton(
                      key: const Key('menu-button'),
                      onPressed: () => taps++,
                      child: const Text('Menu'),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );

    expect(
      tester.widget<AnimatedOpacity>(find.byType(AnimatedOpacity)).opacity,
      0,
    );
    await tester.tap(find.byKey(const Key('menu-button')), warnIfMissed: false);
    expect(taps, 0);

    await tester.tap(find.text('Toggle menu'));
    await tester.pump();

    expect(
      tester.widget<AnimatedOpacity>(find.byType(AnimatedOpacity)).opacity,
      1,
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('menu-button')));
    expect(taps, 1);
  });

  testWidgets('slides in and dismisses after dragging down', (tester) async {
    var isVisible = false;
    var dismissals = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: StatefulBuilder(
          builder: (context, setState) {
            return Scaffold(
              body: Stack(
                children: [
                  TextButton(
                    onPressed: () => setState(() => isVisible = true),
                    child: const Text('Show menu'),
                  ),
                  MBFloatingBottomMenu(
                    isVisible: isVisible,
                    onDismiss: () {
                      dismissals++;
                      setState(() => isVisible = false);
                    },
                    child: const Text('Menu content'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );

    await tester.tap(find.text('Show menu'));
    await tester.pump();
    await tester.pumpAndSettle();

    await tester.drag(find.text('Menu content'), const Offset(0, 120));
    await tester.pump();

    expect(dismissals, 1);
  });
}
