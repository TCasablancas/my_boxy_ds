import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:my_boxy_ds/components/buttons/buttons.dart';

import '../../ui/design_tokens/design_tokens.dart';

class MBUploadedImageView extends StatelessWidget {
  const MBUploadedImageView({
    super.key,
    required this.imagePath,
    required this.onDelete,
    this.width = 120,
    this.height = 120,
  });

  final String imagePath;
  final VoidCallback onDelete;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: AppRadius.allMedium,
            child: GestureDetector(
              onTap: () => _showFullscreen(context),
              child: Image.file(File(imagePath), fit: BoxFit.cover),
            ),
          ),
          Positioned(
            top: AppSizes.xs,
            right: AppSizes.xs,
            child: MBRoundedIconButton(
              icon: LucideIcons.trash, onPressed: onDelete,
              iconColor: AppColors.primary,
              backgroundColor: AppColors.white,
            )
          ),
        ],
      ),
    );
  }

  void _showFullscreen(BuildContext context) {
    showGeneralDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Fechar imagem',
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, animation, secondaryAnimation) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => Navigator.of(context).pop(),
          child: Stack(
            children: [
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                  child: ColoredBox(color: Colors.black.withValues(alpha: .85)),
                ),
              ),
              SafeArea(
                child: GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSizes.medium),
                    child: Center(
                      child: InteractiveViewer(
                        child: Image.file(File(imagePath), fit: BoxFit.contain),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: AppSizes.medium,
                right: AppSizes.medium,
                child: SafeArea(
                  child: IconButton(
                    tooltip: 'Fechar imagem',
                    color: Colors.white,
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
