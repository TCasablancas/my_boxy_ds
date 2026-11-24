import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:lottie/lottie.dart';
import 'package:my_boxy_ds/ui/design_tokens/design_tokens.dart';

import '../buttons/mb_square_icon_btn.dart';
import '../input/mb_text_area_input.dart';
import '../labels/mb_title_subtitled_label.dart';
import 'mb_box_rounded_container.dart';

class MBMessageTextInputContainer extends StatelessWidget {

  const MBMessageTextInputContainer({
    super.key,
    this.title,
    this.description,
    required this.controller,
    this.hintText,
    this.enabled = true,
    this.minHeight,
    this.maxLength,
    this.isError,
    this.onSend,
    this.isSending = false,
  });

  final String? title;
  final String? description;
  final TextEditingController controller;
  final String? hintText;
  final bool enabled;
  final double? minHeight;
  final int? maxLength;
  final bool? isError;
  final VoidCallback? onSend;

  /// Enquanto envia, o avião vira o loading (e o toque não faz nada).
  final bool isSending;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: AppRadius.allXLarge,
      ),
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSizes.medium, AppSizes.md, AppSizes.medium, AppSizes.small
            ),
            child: MBTitleSubtitled(
              title: title ?? '', description: description ?? '',
            ),
          ),
          MBBoxRoundedContainer(
            background: AppColors.grey100,
            padding: EdgeInsets.all(0),
            margin: EdgeInsets.all(AppSizes.small),
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 40),
                  child: SingleChildScrollView(
                    child: MBTextAreaInput(
                      controller: controller,
                      hintText: hintText,
                      enabled: enabled,
                      minHeight: minHeight ?? 0.0,
                      maxLength: maxLength,
                      isError: isError ?? false,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 8, right: 8,
                  child: isSending ? _sendingIndicator() : MBSquareIconBtn(
                    icon: LucideIcons.send_horizontal,
                    padding: AppSizes.md,
                    onTap: onSend,
                  ),
                )
              ],
            )
          ),
        ],
      )
    );
  }

  /// Mesmo tamanho e fundo do botão de enviar, com o loading no lugar do ícone.
  Widget _sendingIndicator() {
    return Container(
      padding: const EdgeInsets.all(AppSizes.md),
      decoration: const BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: AppRadius.allXLarge,
      ),
      child: Lottie.asset(
        'assets/animations/loading_icon_white.json',
        package: 'my_boxy_ds',
        width: 18,
        height: 18,
        fit: BoxFit.contain,
      ),
    );
  }
}
