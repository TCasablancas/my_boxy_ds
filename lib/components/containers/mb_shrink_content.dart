import 'package:flutter/material.dart';
import 'package:my_boxy_ds/components/containers/mb_main_view.dart';
import 'package:my_boxy_ds/ui/design_tokens/design_tokens.dart';

class MBShrinkContentView extends StatelessWidget {

  const MBShrinkContentView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MBMainView(
      viewTitle: 'MBShrinkContentView',
      child: Center(
          child: Text('MBShrinkContentView')
      ),
    );
  }
}