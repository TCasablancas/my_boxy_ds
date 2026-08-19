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

  bool isCollapsed = false;

  @override
  Widget build(BuildContext context) {
    return(
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Column(
          children: [
            Row(
              spacing: 8,
              children: [
                SvgPicture.asset(
                  './assets/images/mb_icon.svg',
                  package: 'my_boxy_ds',
                  width: 40, height: 40,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isCollapsed = !isCollapsed;
                    });
                  },
                  child: Column(
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
                ),
                Spacer(),
                ...widget.rightBtns ?? []
              ],
            ),
            const SizedBox(height: 16),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              height: isCollapsed ? 0 : 80,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8)
              ),
              child: Row(
                children: [
                  MBPillBtn(
                    text: 'Compartilhar Perfil',
                    onPressed: () {},
                    color: Colors.grey[400],
                    textColor: Colors.grey[800],
                  ),
                  MBPillBtn(
                    text: 'Criar caixa',
                    onPressed: () {},
                    color: Colors.grey[400],
                    textColor: Colors.grey[800],
                  ),
                ],
              )
            ),
          ]
        )
      )
    );
  }
}