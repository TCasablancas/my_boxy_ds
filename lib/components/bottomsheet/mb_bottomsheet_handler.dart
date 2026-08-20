import 'package:flutter/material.dart';

class MBBottomsheetHandler extends StatelessWidget {

  const MBBottomsheetHandler({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      alignment: Alignment.center,
      child: Container(
        width: 40, height: 4,
        decoration: BoxDecoration(
          color: const Color(0xFFE0E0E0),
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}