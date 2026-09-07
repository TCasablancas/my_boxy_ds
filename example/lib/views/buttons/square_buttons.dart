import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:my_boxy_ds/components/containers/mb_main_view.dart';
import 'package:my_boxy_ds/components/containers/mb_section_titled.dart';
import 'package:my_boxy_ds/components/buttons/mb_square_selection_btn.dart';
import 'package:my_boxy_ds/components/buttons/mb_icon_btn.dart';
import 'package:my_boxy_ds/my_boxy_ds.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SquareButtons extends StatefulWidget {

  const SquareButtons({super.key});

  @override
  State<SquareButtons> createState() => _SquareButtonsState();
}

class _SquareButtonsState extends State<SquareButtons> {

  @override
  Widget build(BuildContext context) {
    return MBMainView(
      viewTitle: 'Square Buttons - Actions',
      hasBottomMenu: false,
      child: Padding(
        padding: EdgeInsets.all(AppSizes.medium),
        child: Column(
          children: [
            MBSectionTitled(
              title: 'Ações Carrinho',
              child: Row(
                spacing: AppSizes.medium,
                children: [
                  Expanded(
                    child: MBSquareSelectionBtn(
                      label: 'Entrega',
                      icon: LucideIcons.truck,
                      name: 'Sedex',
                      description: 'Casa',
                      descriptionIcon: Icon(LucideIcons.map_pin, size: 16.0, color: AppColors.primaryDark),
                      actions: [
                        MBIconBtn(icon: LucideIcons.square_pen, onTap: () {  }),
                        MBIconBtn(icon: LucideIcons.square_pen, onTap: () {  }),
                      ],
                      onPressed: () {  },
                    )
                  ),
                  Expanded(
                      child: MBSquareSelectionBtn(
                        label: 'Pagamento',
                        icon: LucideIcons.credit_card,
                        name: 'Cartão',
                        description: 'final - 4905',
                        descriptionIcon: SvgPicture.asset('../assets/images/ic_mastercard.svg', height: 14.0, width: 20.0),
                        onPressed: () {  },
                      )
                  ),
                ],
              ),
            )
          ],
        )
      )
    );
  }
}