import 'package:flutter/material.dart';
import 'package:my_boxy_ds/ui/design_tokens/design_tokens.dart';

class MBTextAreaInput extends StatelessWidget {

  const MBTextAreaInput({
    super.key,
    required this.controller,
    this.hintText,
    this.enabled = true,
    this.minHeight = 120,
    this.maxLength,
    this.footerText,
    this.isError = false,
    this.onChanged,
  });

  final TextEditingController controller;
  final String? hintText;
  final bool enabled;
  final double minHeight;
  final int? maxLength;

  /// Texto pequeno no rodapé da caixa (ex.: "12/500" ou a mensagem de erro).
  final String? footerText;
  final bool isError;
  final ValueChanged<String>? onChanged;

  static const _footerSpace = 28.0;

  @override
  Widget build(BuildContext context) {
    // Stack: a caixa define o tamanho (mínimo [minHeight], cresce com o texto) e o
    // rodapé fica preso no canto inferior direito, como na referência.
    return Stack(
      children: [
        Container(
          constraints: BoxConstraints(minHeight: minHeight),
          padding: EdgeInsets.fromLTRB(
            AppSizes.medium,
            AppSizes.xs,
            AppSizes.medium,
            footerText == null ? AppSizes.small : _footerSpace,
          ),
          child: TextField(
            controller: controller,
            enabled: enabled,
            onChanged: onChanged,
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.newline,
            minLines: 1,
            maxLines: null,
            maxLength: maxLength,
            cursorColor: AppColors.grey900,
            style: AppTextStyles.bodyLarge.copyWith(
              fontSize: 13,
              height: 1.4,
              letterSpacing: -0.5,
              color: AppColors.grey700
            ),
            onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: AppTextStyles.bodyLarge.copyWith(
                fontSize: 13,
                height: 1.4,
                letterSpacing: -0.5,
                color: AppColors.grey400,
              ),
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(vertical: AppSizes.small),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              counterText: '',
            ),
          ),
        ),
        if (footerText != null)
          Positioned(
            right: AppSizes.medium,
            bottom: AppSizes.small,
            left: AppSizes.medium,
            child: Text(
              footerText!,
              textAlign: TextAlign.end,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.descriptionOf(isError ? AppColors.error : AppColors.grey500),
            ),
          ),
      ],
    );
  }
}