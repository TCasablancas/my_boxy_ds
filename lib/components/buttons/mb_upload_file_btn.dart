import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:my_boxy_ds/ui/design_tokens/design_tokens.dart';

class MBUploadFileButton extends StatelessWidget {
  const MBUploadFileButton({
    super.key,
    this.icon,
    this.label,
    this.onTap,
    this.height,
    this.width,
    this.margin,
    this.imagePath,
    this.imageFit = BoxFit.contain,
    this.imageAlignment = Alignment.center,
    this.onDelete,
    this.onReplace,
  });

  final IconData? icon;
  final String? label;
  final VoidCallback? onTap;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? margin;
  final String? imagePath;
  final BoxFit imageFit;
  final AlignmentGeometry imageAlignment;
  final VoidCallback? onDelete;
  final VoidCallback? onReplace;

  bool get _hasImage => imagePath != null;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _hasImage ? () => _showImagePreview(context) : onTap,
      child: Container(
        height: height ?? 70,
        width: width ?? double.infinity,
        margin: margin ?? EdgeInsets.symmetric(horizontal: AppSizes.medium),
        decoration: BoxDecoration(
          color: AppColors.primaryLight.withAlpha(40),
          borderRadius: BorderRadius.circular(AppSizes.small),
          border: Border.fromBorderSide(
            AppBorders.sideOf(AppColors.primaryLight, width: 3),
          ),
        ),
        child: _hasImage
            ? ClipRRect(
                borderRadius: AppRadius.allMedium,
                child: Image.file(
                  File(imagePath!),
                  fit: imageFit,
                  alignment: imageAlignment,
                  width: double.infinity,
                  height: double.infinity,
                ),
              )
            : Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      icon ?? LucideIcons.image_plus,
                      color: AppColors.primary,
                    ),
                    Text(
                      label ?? '',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.grey500,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  void _showImagePreview(BuildContext context) {
    showGeneralDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Fechar imagem',
      barrierColor: AppColors.transparent,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, animation, secondaryAnimation) => Scaffold(
        backgroundColor: AppColors.black.withValues(alpha: .85),
        body: SafeArea(
          child: Stack(
            children: [
              Center(
                child: InteractiveViewer(
                  child: Image.file(
                    File(imagePath!),
                    fit: BoxFit.contain,
                    alignment: Alignment.center,
                  ),
                ),
              ),
              Positioned(
                top: AppSizes.small,
                right: AppSizes.small,
                child: IconButton(
                  tooltip: 'Fechar imagem',
                  color: AppColors.white,
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              Positioned(
                left: AppSizes.medium,
                right: AppSizes.medium,
                bottom: AppSizes.large,
                child: Row(
                  children: [
                    if (onDelete != null)
                      Expanded(
                        child: TextButton.icon(
                          onPressed: () {
                            Navigator.of(context).pop();
                            onDelete?.call();
                          },
                          icon: const Icon(LucideIcons.trash),
                          label: const Text('Apagar'),
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.white,
                          ),
                        ),
                      ),
                    if (onDelete != null) const SizedBox(width: AppSizes.small),
                    if (onReplace != null || onTap != null)
                      Expanded(
                        child: TextButton.icon(
                          onPressed: () {
                            Navigator.of(context).pop();
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              (onReplace ?? onTap)?.call();
                            });
                          },
                          icon: const Icon(LucideIcons.image_plus),
                          label: const Text('Escolher outra imagem'),
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.white,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
