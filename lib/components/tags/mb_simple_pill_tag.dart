import 'package:flutter/material.dart';
import 'package:my_boxy_ds/ui/design_tokens/design_tokens.dart';

/// Pill de texto selecionável (ex.: filtro de categoria).
///
/// O toque alterna a seleção e anima fundo e texto. Vários pills podem estar
/// selecionados ao mesmo tempo: cada um guarda o próprio estado.
///
/// - Sem [isSelected]: o pill controla a seleção sozinho, começando em
///   [initiallySelected]. Use uma `Key` estável em listas que recarregam.
/// - Com [isSelected]: quem usa manda no estado (controlado) e atualiza
///   pelo [onSelectedChanged].
class MBSimplePillTag extends StatefulWidget {
  const MBSimplePillTag({
    super.key,
    required this.title,
    this.onTap,
    this.isSelected,
    this.initiallySelected = false,
    this.onSelectedChanged,
  });

  final String title;

  /// Chamado a cada toque, depois de alternar a seleção.
  final VoidCallback? onTap;

  /// Seleção controlada por fora. Nulo: o pill controla sozinho.
  final bool? isSelected;

  /// Estado inicial quando o pill controla a seleção sozinho.
  final bool initiallySelected;

  /// Novo valor da seleção após o toque.
  final ValueChanged<bool>? onSelectedChanged;

  static const _duration = Duration(milliseconds: 220);

  @override
  State<MBSimplePillTag> createState() => _MBSimplePillTagState();
}

class _MBSimplePillTagState extends State<MBSimplePillTag> {
  late bool _selected = widget.isSelected ?? widget.initiallySelected;

  bool get _isSelected => widget.isSelected ?? _selected;

  void _handleTap() {
    final next = !_isSelected;
    if (widget.isSelected == null) setState(() => _selected = next);
    widget.onSelectedChanged?.call(next);
    widget.onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    final selected = _isSelected;
    final shape = BorderRadius.circular(AppSizes.large);

    return Semantics(
      button: true,
      selected: selected,
      child: AnimatedContainer(
        duration: MBSimplePillTag._duration,
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: selected ? AppColors.primaryLight : AppColors.white,
          borderRadius: shape,
        ),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: _handleTap,
            borderRadius: shape,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.medium, vertical: AppSizes.small
              ),
              child: AnimatedDefaultTextStyle(
                duration: MBSimplePillTag._duration,
                curve: Curves.easeOut,
                style: AppTextStyles.productSubtitle.copyWith(
                  color: selected ? AppColors.primary : AppColors.grey600,
                  height: 1.5,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                  fontFamily: AppFonts.third
                ),
                child: Text(widget.title),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
