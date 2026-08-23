import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_boxy_ds/ui/mb_typography.dart';
import 'package:my_boxy_ds/components/buttons/mb_pill_btn.dart';

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

  bool isCollapsed = true;

  @override
  Widget build(BuildContext context) {
    return(
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child:
            Row(
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
                          style: AppTypography.body1Fn(
                            Colors.grey[900], FontWeight.w700
                          ).copyWith(letterSpacing: -0.5)
                        ),
                        Icon(Icons.arrow_drop_down)
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          '@${widget.userAlias}', 
                          style: AppTypography.captionFn(
                            Colors.grey[500], 'Lexend'
                          ).copyWith(letterSpacing: -0.2)
                        ),
                        Container(
                          width: 8,
                          height: 16,
                          margin: const EdgeInsets.only(left: 8),
                          child: Icon(Icons.location_pin, size: 8, color: Colors.grey[500]),
                        ),
                        Text(
                          'Santos - SP', 
                          style: AppTypography.captionFn(
                            Colors.grey[500], 'Lexend'
                          ).copyWith(letterSpacing: -0.2)
                        ),
                      ],
                    ),
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