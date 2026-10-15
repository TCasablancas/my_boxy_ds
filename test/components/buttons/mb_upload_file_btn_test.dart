import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_boxy_ds/components/buttons/mb_upload_file_btn.dart';

void main() {
  late File imageFile;

  setUpAll(() async {
    imageFile = File(
      '${Directory.systemTemp.path}/mb_upload_file_btn_test.png',
    );
    await imageFile.writeAsBytes(
      Uint8List.fromList(<int>[
        137,
        80,
        78,
        71,
        13,
        10,
        26,
        10,
        0,
        0,
        0,
        13,
        73,
        72,
        68,
        82,
        0,
        0,
        0,
        1,
        0,
        0,
        0,
        1,
        8,
        6,
        0,
        0,
        0,
        31,
        21,
        196,
        137,
        0,
        0,
        0,
        13,
        73,
        68,
        65,
        84,
        8,
        215,
        99,
        248,
        207,
        192,
        240,
        31,
        0,
        5,
        0,
        1,
        255,
        137,
        153,
        61,
        29,
        0,
        0,
        0,
        0,
        73,
        69,
        78,
        68,
        174,
        66,
        96,
        130,
      ]),
    );
  });

  tearDownAll(() => imageFile.delete());

  testWidgets('shows selected image controls and deletes image', (
    tester,
  ) async {
    var wasDeleted = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MBUploadFileButton(
            label: 'Sua logo',
            imagePath: imageFile.path,
            onDelete: () => wasDeleted = true,
            onTap: () {},
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byType(MBUploadFileButton));
    await tester.pumpAndSettle();

    expect(find.text('Apagar'), findsOneWidget);
    expect(find.text('Escolher outra imagem'), findsOneWidget);

    await tester.tap(find.text('Apagar'));
    await tester.pumpAndSettle();

    expect(wasDeleted, isTrue);
  });

  testWidgets('uses upload action to replace selected image', (tester) async {
    var replacementWasRequested = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MBUploadFileButton(
            imagePath: imageFile.path,
            onTap: () => replacementWasRequested = true,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byType(MBUploadFileButton));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Escolher outra imagem'));
    await tester.pumpAndSettle();

    expect(replacementWasRequested, isTrue);
  });
}
