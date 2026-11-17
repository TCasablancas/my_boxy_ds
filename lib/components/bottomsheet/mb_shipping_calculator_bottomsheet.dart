import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:my_boxy_ds/components/buttons/mb_main_btn.dart';
import 'package:my_boxy_ds/components/containers/mb_box_rounded_container.dart';
import 'package:my_boxy_ds/components/labels/mb_title_subtitled_label.dart';
import 'package:my_boxy_ds/components/selectors/mb_selector_with_counter.dart';
import 'package:my_boxy_ds/components/shimmer/home_shimmer/mb_shimmer_box.dart';
import 'package:my_boxy_ds/components/shimmer/mb_shimmer.dart';
import 'package:my_boxy_ds/ui/design_tokens/design_tokens.dart';

enum MBShippingOption { standard, pickup, handDelivery }

class _ShippingOptionItem {
  const _ShippingOptionItem({
    required this.type,
    required this.icon,
    required this.label,
    required this.description,
    required this.detail,
  });

  final MBShippingOption type;
  final IconData icon;
  final String label;
  final String description;
  final String detail;
}

/// Mesmos itens de "Formas de entrega" do cadastro de loja, do ponto de vista
/// de quem compra.
const _options = [
  _ShippingOptionItem(
    type: MBShippingOption.standard,
    icon: LucideIcons.truck,
    label: 'Transportadora / Correios',
    description: 'Envio pelo Melhor Envio',
    detail: 'Frete calculado automaticamente no checkout',
  ),
  _ShippingOptionItem(
    type: MBShippingOption.handDelivery,
    icon: LucideIcons.handshake,
    label: 'Entrega em mãos',
    description: 'A loja entrega até você',
    detail: 'Disponível perto da loja',
  ),
  _ShippingOptionItem(
    type: MBShippingOption.pickup,
    icon: LucideIcons.store,
    label: 'Retirada pelo cliente',
    description: 'Você busca no ateliê',
    detail: 'Combine o horário com a loja',
  ),
];

/// Endereço já formatado para exibição.
class MBShippingAddress {
  final String title;
  final String description;

  const MBShippingAddress({required this.title, required this.description});
}

/// Conteúdo do bottomsheet de cálculo de frete. Abrir via
/// `MBMainBottomsheet.show(context, child: MBShippingCalculatorBottomsheet(...))`.
///
/// [localDeliveryAvailable] libera "Entrega em mãos" e "Retirada pelo cliente"; a
/// regra (distância até a loja) fica com quem usa o componente.
class MBShippingCalculatorBottomsheet extends StatefulWidget {
  final MBShippingAddress? address;
  final bool localDeliveryAvailable;
  final bool isLoading;
  final VoidCallback onAddAddress;
  final VoidCallback? onChangeAddress;
  final ValueChanged<MBShippingOption> onCalculate;

  const MBShippingCalculatorBottomsheet({
    super.key,
    required this.onAddAddress,
    required this.onCalculate,
    this.address,
    this.onChangeAddress,
    this.localDeliveryAvailable = false,
    this.isLoading = false,
  });

  @override
  State<MBShippingCalculatorBottomsheet> createState() =>
      _MBShippingCalculatorBottomsheetState();
}

class _MBShippingCalculatorBottomsheetState
    extends State<MBShippingCalculatorBottomsheet> {
  MBShippingOption _option = MBShippingOption.standard;

  @override
  void didUpdateWidget(covariant MBShippingCalculatorBottomsheet oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!widget.localDeliveryAvailable) {
      _option = MBShippingOption.standard;
    }
  }

  bool get _canCalculate => !widget.isLoading && widget.address != null;

  void _select(MBShippingOption option) => setState(() => _option = option);

  @override
  Widget build(BuildContext context) {
    return Column(
        spacing: 16.0,
        children: [
          MBBoxRoundedContainer(
            padding: const EdgeInsets.all(16),
            child: Column(
              spacing: 12.0,
              children: [
                const MBTitleSubtitled(title: 'Enviar para'),
                if (widget.isLoading)
                  const MBShimmer(
                    child: MBShimmerBox(
                      height: 64,
                      borderRadius: AppRadius.allXLarge,
                    ),
                  )
                else if (widget.address != null)
                  _ShippingAddressTile(
                    address: widget.address!,
                    onTap: widget.onChangeAddress,
                  )
                else
                  _AddAddressTile(onTap: widget.onAddAddress),
              ],
            ),
          ),
          MBBoxRoundedContainer(
            child: Column(
              spacing: 12.0,
              children: [
                const MBTitleSubtitled(
                  title: 'Como receber',
                  description: 'Escolha como prefere receber este item.',
                ),
                LayoutBuilder(
                  builder: (context, constraints) => Column(
                    spacing: AppSizes.medium,
                    children: _options
                        .where((option) =>
                            widget.localDeliveryAvailable ||
                            option.type == MBShippingOption.standard)
                        .map(
                          (option) => MBSelectorWithCounter(
                            icon: option.icon,
                            label: option.label,
                            description: option.description,
                            isSelected: _option == option.type,
                            type: MBSelectorWithCounterType.radio,
                            inactiveBorderColor: AppColors.grey200,
                            onSelectionChanged: (_) => _select(option.type),
                            height: 120,
                            width: constraints.maxWidth,
                            child: Text(
                              option.detail,
                              style: AppTextStyles.labelSmall.copyWith(
                                color: AppColors.focus,
                                letterSpacing: -0.5,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
          MBMainButton(
            title: 'Calcular',
            icon: LucideIcons.truck,
            buttonType: _canCalculate
                ? MBMainButtonType.normal
                : MBMainButtonType.disabled,
            onPressed: () => widget.onCalculate(_option),
          ),
        ],
    );
  }
}

class _ShippingAddressTile extends StatelessWidget {
  final MBShippingAddress address;
  final VoidCallback? onTap;

  const _ShippingAddressTile({required this.address, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSizes.md),
        decoration: BoxDecoration(
          color: AppColors.grey100,
          borderRadius: AppRadius.allXLarge,
          border: Border.all(color: AppColors.primary, width: 1.5),
        ),
        child: Row(
          spacing: AppSizes.md,
          children: [
            const Icon(
              LucideIcons.map_pin,
              size: AppSizes.large,
              color: AppColors.primary,
            ),
            Expanded(
              child: Column(
                spacing: AppSizes.sm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address.title,
                    style: AppTextStyles.bodyMediumStrong.copyWith(
                      color: AppColors.primaryDark,
                      letterSpacing: -0.5,
                    ),
                  ),
                  Text(
                    address.description,
                    style: AppTextStyles.description.copyWith(
                      color: AppColors.grey700,
                      letterSpacing: -0.2,
                    ),
                  ),
                ],
              ),
            ),
            if (onTap != null)
              const Icon(
                LucideIcons.chevron_right,
                size: AppSizes.medium,
                color: AppColors.grey500,
              ),
          ],
        ),
      ),
    );
  }
}

class _AddAddressTile extends StatelessWidget {
  final VoidCallback onTap;

  const _AddAddressTile({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSizes.md),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: AppRadius.allXLarge,
          border: Border.all(color: AppColors.borderStrong, width: 1.5),
        ),
        child: Row(
          spacing: AppSizes.md,
          children: [
            const Icon(
              LucideIcons.map_pin_plus,
              size: AppSizes.large,
              color: AppColors.primary,
            ),
            Expanded(
              child: Column(
                spacing: AppSizes.sm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cadastrar endereço',
                    style: AppTextStyles.bodyMediumStrong.copyWith(
                      color: AppColors.primaryDark,
                      letterSpacing: -0.5,
                    ),
                  ),
                  Text(
                    'Você ainda não tem endereço de entrega.',
                    style: AppTextStyles.description.copyWith(
                      color: AppColors.grey500,
                      letterSpacing: -0.2,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              LucideIcons.chevron_right,
              size: AppSizes.medium,
              color: AppColors.grey500,
            ),
          ],
        ),
      ),
    );
  }
}
