import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_boxy_ds/components/bottomsheet/mb_main_bottomsheet.dart';

void main() {
  testWidgets('opens synchronously and returns the dismissal result', (
    tester,
  ) async {
    Future<String?>? result;
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) => TextButton(
            onPressed: () {
              result = MBMainBottomsheet.show<String>(
                context,
                child: Builder(
                  builder: (sheetContext) => TextButton(
                    onPressed: () => Navigator.pop(sheetContext, 'selected'),
                    child: const Text('Select'),
                  ),
                ),
              );
            },
            child: const Text('Open'),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Select'));
    await tester.pumpAndSettle();

    expect(await result, 'selected');
  });

  testWidgets('entrypoint runs once and builder handles loading and data', (
    tester,
  ) async {
    final completer = Completer<String>();
    var calls = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) => TextButton(
            onPressed: () => MBMainBottomsheet.show<void>(
              context,
              child: const Text('Static'),
              entrypoint: () {
                calls++;
                return completer.future;
              },
              asyncBuilder: (context, snapshot) => Text(
                snapshot.connectionState == ConnectionState.done
                    ? snapshot.data! as String
                    : 'Loading',
              ),
            ),
            child: const Text('Open'),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    expect(find.text('Loading'), findsOneWidget);
    expect(find.text('Static'), findsNothing);
    expect(calls, 1);

    completer.complete('Loaded');
    await tester.pumpAndSettle();
    expect(find.text('Loaded'), findsOneWidget);
    expect(calls, 1);
  });

  testWidgets('supports synchronous entrypoint and exposes errors', (
    tester,
  ) async {
    var fail = false;
    final navigatorKey = GlobalKey<NavigatorState>();
    await tester.pumpWidget(
      MaterialApp(
        navigatorKey: navigatorKey,
        home: Builder(
          builder: (context) => TextButton(
            onPressed: () => MBMainBottomsheet.show<void>(
              context,
              child: const SizedBox.shrink(),
              entrypoint: () {
                if (fail) throw StateError('failed');
                return 'Sync';
              },
              asyncBuilder: (context, snapshot) => Text(
                snapshot.hasError
                    ? 'Error: ${snapshot.error}'
                    : '${snapshot.data}',
              ),
            ),
            child: const Text('Open'),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    expect(find.text('Sync'), findsOneWidget);
    navigatorKey.currentState!.pop();
    await tester.pumpAndSettle();

    fail = true;
    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    expect(find.text('Error: Bad state: failed'), findsOneWidget);
  });

  testWidgets('can dismiss while entrypoint is pending', (tester) async {
    final completer = Completer<void>();
    final navigatorKey = GlobalKey<NavigatorState>();
    Future<String?>? result;
    await tester.pumpWidget(
      MaterialApp(
        navigatorKey: navigatorKey,
        home: Builder(
          builder: (context) => TextButton(
            onPressed: () {
              result = MBMainBottomsheet.show<String>(
                context,
                child: const SizedBox.shrink(),
                entrypoint: () => completer.future,
                asyncBuilder: (context, snapshot) => const Text('Loading'),
              );
            },
            child: const Text('Open'),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    navigatorKey.currentState!.pop('dismissed');
    await tester.pumpAndSettle();
    expect(await result, 'dismissed');
    completer.completeError(StateError('failed after dismissal'));
    await tester.pump();
    expect(tester.takeException(), isNull);
  });

  testWidgets('exposes asynchronous entrypoint errors', (tester) async {
    final completer = Completer<String>();
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) => TextButton(
            onPressed: () => MBMainBottomsheet.show<void>(
              context,
              child: const SizedBox.shrink(),
              entrypoint: () => completer.future,
              asyncBuilder: (context, snapshot) => Text(
                snapshot.hasError ? 'Error: ${snapshot.error}' : 'Loading',
              ),
            ),
            child: const Text('Open'),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    completer.completeError(StateError('failed'));
    await tester.pumpAndSettle();
    expect(find.text('Error: Bad state: failed'), findsOneWidget);
  });

  testWidgets('rejects an entrypoint without its builder', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) => TextButton(
            onPressed: () => MBMainBottomsheet.show<void>(
              context,
              child: const SizedBox.shrink(),
              entrypoint: () => null,
            ),
            child: const Text('Open'),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    expect(tester.takeException(), isA<ArgumentError>());
    expect(find.byType(MBMainBottomsheet), findsNothing);
  });
}
