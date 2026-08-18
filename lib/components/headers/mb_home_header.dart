import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_boxy_ds/ui/mb_typography.dart';

class MBHomeHeader extends StatefulWidget {
  final String userName;
  final String userAlias;
  final List<Widget>? rightBtns;

  const MBHomeHeader({ 
    super.key,
    required this.userName,
    required this.userAlias,
    this.rightBtns,
  });

  @override
  State<MBHomeHeader> createState() => _MBHomeHeaderState();
}

class _MBHomeHeaderState extends State<MBHomeHeader> {

  @override
  Widget build(BuildContext context) {
    return(
      Padding(
        padding: const EdgeInsets.all(16),
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
                    Text('Olá, ', style: AppTypography.body1Fn(Colors.grey[600])),
                    Text(
                      widget.userName, 
                      style: AppTypography.body1Fn(Colors.grey[900], FontWeight.w700)
                    ),
                    Icon(Icons.arrow_drop_down)
                  ],
                ),
                Text(
                  '@${widget.userAlias}', 
                  style: AppTypography.captionFn(Colors.grey[500], 'SFMono')
                )
              ],
            ),
            Spacer(),
            ...widget.rightBtns ?? []
          ],
        ),
      )
    );
  }
}