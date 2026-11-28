import 'package:flutter/material.dart';
import 'package:my_boxy_ds/ui/design_tokens/design_tokens.dart';

import '../containers/mb_box_rounded_container.dart';
import '../labels/mb_title_subtitled_label.dart';

class MBTextInput extends StatelessWidget {
  const MBTextInput({
    super.key,
    required this.controller,
    this.title,
    this.description,
    this.hintText,
    this.enabled = true,
    this.height = AppSizes.inputHeight,
    this.maxLength,
    this.footerText,
    this.isError = false,
    this.backgroundColor,
    this.inputBackgroundColor,
    this.onChanged,
    required this.hasBackground,
  });

  final TextEditingController controller;
  final String? title;
  final String? description;
  final String? hintText;
  final bool enabled;
  final double height;
  final int? maxLength;
  final String? footerText;
  final bool isError;
  final Color? backgroundColor;
  final Color? inputBackgroundColor;
  final ValueChanged<String>? onChanged;
  final bool hasBackground;

  static const _footerSpace = 28.0;

  @override
  Widget build(BuildContext context) {
    return hasBackground ? Container(
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.white,
          borderRadius: AppRadius.allXLarge,
        ),
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  AppSizes.medium, AppSizes.small, AppSizes.medium, AppSizes.sm
              ),
              child: MBTitleSubtitled(
                title: title ?? '', description: description ?? '',
              ),
            ),
            _inputField(),
          ],
        )
    ) : _inputField();
  }

  Widget _inputField() {
    return MBBoxRoundedContainer(
      background: inputBackgroundColor ?? AppColors.grey100,
      padding: EdgeInsets.all(0),
      margin: EdgeInsets.all(AppSizes.small),
      borderRadius: AppRadius.allLg,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 40),
            child: SingleChildScrollView(
              child: SizedBox(
                height: height,
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        AppSizes.medium, AppSizes.xs, AppSizes.medium, 0,
                      ),
                      child: TextField(
                        controller: controller,
                        enabled: enabled,
                        onChanged: onChanged,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        maxLines: 1,
                        maxLength: maxLength,
                        cursorColor: AppColors.grey900,
                        style: AppTextStyles.bodyLarge.copyWith(
                          letterSpacing: -0.5,
                          color: AppColors.grey700,
                        ),
                        onTapOutside: (_) =>
                            FocusManager.instance.primaryFocus?.unfocus(),
                        decoration: InputDecoration(
                          hintText: hintText,
                          hintStyle: AppTextStyles.bodyLarge.copyWith(
                            // fontSize: 13,
                            // height: 1.,
                            letterSpacing: -0.5,
                            color: AppColors.grey400,
                          ),
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: AppSizes.small),
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
                          style: AppTextStyles.descriptionOf(
                            isError ? AppColors.error : AppColors.grey500,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          // Positioned(
          //   bottom: AppSizes.small,
          //   right: AppSizes.small,
          //   child: isSending ? _sendingIndicator() : MBIconBtn(
          //     icon: LucideIcons.send_horizontal,
          //     onTap: onSend,
          //   ),
          // )
        ],
      )
    );
  }
}
