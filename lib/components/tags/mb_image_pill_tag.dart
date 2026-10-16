import 'package:flutter/material.dart';
import 'package:my_boxy_ds/ui/design_tokens/design_tokens.dart';

/// Tag em formato de pílula com imagem de fundo e o nome por cima (ex.: uma
/// categoria). Sem [image], ou se a imagem falhar, usa um fundo neutro.
/// O nome quebra em até 2 linhas (categorias têm nomes longos) e só depois
/// usa reticências. Feita para ficar lado a lado num `MBMainHorizontalCarousel`.
class MBImagePillTag extends StatelessWidget {
  const MBImagePillTag({
    super.key,
    required this.label,
    this.image,
    this.onTap,
    this.width = 130,
    this.height = 56,
  });

  final String label;

  /// Imagem de fundo; o app pode passar uma com cache.
  final ImageProvider? image;
  final VoidCallback? onTap;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final image = this.image;

    return Semantics(
      button: onTap != null,
      label: label,
      excludeSemantics: true,
      child: GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          // borderRadius: BorderRadius.circular(height / 2),
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            width: width,
            height: height,
            child: Stack(
              fit: StackFit.expand,
              children: [
                const ColoredBox(color: AppColors.neutral200),
                if (image != null) ...[
                  Image(
                    image: image,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => const SizedBox.shrink(),
                  ),
                  ColoredBox(color: AppColors.black.withValues(alpha: 0.4)),
                ],
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSizes.medium),
                    child: Text(
                      label,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: image != null ? AppColors.white : AppColors.textPrimary,
                        height: 1.15,
                        letterSpacing:  -0.5
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
