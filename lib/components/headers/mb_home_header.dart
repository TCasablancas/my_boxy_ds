import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_boxy_ds/components/buttons/buttons.dart';
import 'package:my_boxy_ds/components/buttons/mb_rounded_icon_btn.dart';
import 'package:my_boxy_ds/ui/mb_typography.dart';

class MBHomeHeader extends StatefulWidget {
  final String userName;
  final String userAlias;

  const MBHomeHeader({ 
    super.key,
    required this.userName,
    required this.userAlias,
  });

  @override
  State<MBHomeHeader> createState() => _MBHomeHeaderState();
}

class _MBHomeHeaderState extends State<MBHomeHeader> {

  @override
  Widget build(BuildContext context) {
    return(
      Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          spacing: 8,
          children: [
            SvgPicture.asset(
              './assets/images/mb_icon.svg',
              package: 'my_boxy_ds',
              width: 40, height: 40,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Olá, ${widget.userName}', style: AppTypography.body1),
                    Icon(Icons.arrow_drop_down)
                  ],
                ),
                Text('@${widget.userAlias}', style: AppTypography.caption)
              ],
            ),
            Spacer(),
            MBRoundedIconButton(
              icon: Icon(Icons.search), 
              onPressed: () => {}
            ),
          ],
        ),
      )
    );
  }
}