import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_boxy_ds/components/tiles/mb_light_item_tile.dart';

void main() {
  testWidgets('handles taps across full available width', (tester) async {
    var tapCount = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 320,
            child: MBLightItemTile(
              label: 'Rolo da câmera',
              icon: Icons.photo_library_outlined,
              actionIcon: Icons.chevron_right,
              onTap: () => tapCount++,
            ),
          ),
        ),
      ),
    );

    final gesture = find.byType(GestureDetector);
    final rect = tester.getRect(gesture);
    await tester.tapAt(Offset(rect.right - 1, rect.center.dy));

    expect(tapCount, 1);
  });
}
