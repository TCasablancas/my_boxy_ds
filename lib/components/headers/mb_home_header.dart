import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_boxy_ds/components/shimmer/home_shimmer/mb_shimmer_box.dart';
import 'package:my_boxy_ds/ui/design_tokens/design_tokens.dart';

/// Header da home: logo, saudação, nome, @alias e local (cidade - UF).
///
/// Nome e alias truncam com reticências. Sem [userAlias] (visitante) a linha
/// de baixo mostra só o local. [location] null esconde o local; com
/// [onLocationTap], o local vira um botão (ex.: trocar cidade). [locationAction]
/// é um convite curto depois do local (ex.: "Cadastrar endereço").
/// [isLoading] troca os textos por skeleton, sem mostrar dado provisório.
class MBHomeHeader extends StatelessWidget {
  final String userName;
  final String? userAlias;
  final String greeting;
  final String? location;
  final String? locationAction;
  final VoidCallback? onLocationTap;
  final bool isLoading;
  final List<Widget>? rightBtns;

  const MBHomeHeader({
    super.key,
    required this.userName,
    this.userAlias,
    this.greeting = 'Olá, ',
    this.location,
    this.locationAction,
    this.onLocationTap,
    this.isLoading = false,
    this.rightBtns,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(AppSizes.medium, AppSizes.medium, AppSizes.medium, AppSizes.large),
      child: Row(
        spacing: AppSizes.small,
        children: [
          SvgPicture.asset(
            './assets/images/mb_icon.svg',
            package: 'my_boxy_ds',
            width: 40, height: 40,
          ),
          Expanded(
            child: isLoading ? const _HeaderSkeleton() : _HeaderTexts(header: this),
          ),
          ...rightBtns ?? [],
        ],
      ),
    );
  }
}

class _HeaderTexts extends StatelessWidget {
  const _HeaderTexts({required this.header});

  final MBHomeHeader header;

  @override
  Widget build(BuildContext context) {
    final alias = header.userAlias;
    final secondaryStyle = AppTextStyles.labelSmallOf(AppColors.textTertiary);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text.rich(
          TextSpan(children: [
            TextSpan(text: header.greeting, style: AppTextStyles.bodyLargeOf(AppColors.textSecondary)),
            TextSpan(
              text: header.userName,
              style: AppTextStyles.bodyLargeOf(AppColors.textPrimary, FontWeight.w700)
                  .copyWith(letterSpacing: -0.5),
            ),
          ]),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Row(
          children: [
            if (alias != null && alias.isNotEmpty)
              Flexible(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(right: AppSizes.small),
                  child: Text(
                    '@$alias',
                    style: secondaryStyle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            if (header.location != null)
              Flexible(
                flex: 3,
                child: _LocationLabel(
                  location: header.location!,
                  action: header.locationAction,
                  onTap: header.onLocationTap,
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _LocationLabel extends StatelessWidget {
  const _LocationLabel({required this.location, this.action, this.onTap});

  final String location;
  final String? action;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final style = AppTextStyles.labelSmallOf(AppColors.textTertiary);
    final label = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.location_pin, size: AppSizes.small, color: AppColors.textTertiary),
        const SizedBox(width: AppSizes.xs),
        Flexible(
          child: Text(location, style: style, maxLines: 1, overflow: TextOverflow.ellipsis),
        ),
        if (action != null) ...[
          const SizedBox(width: AppSizes.sm),
          Flexible(
            child: Text(
              action!,
              style: AppTextStyles.labelSmallOf(AppColors.primaryDark).copyWith(fontWeight: FontWeight.w500),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ],
    );
    if (onTap == null) return label;

    return Semantics(
      button: true,
      label: action == null ? location : '$location. $action',
      excludeSemantics: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.allMedium,
        // Alvo de toque mínimo de 32 de altura sem mudar o layout da linha
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: AppSizes.xl),
          child: Align(alignment: Alignment.centerLeft, widthFactor: 1, child: label),
        ),
      ),
    );
  }
}

class _HeaderSkeleton extends StatelessWidget {
  const _HeaderSkeleton();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      spacing: AppSizes.sm,
      children: [
        MBShimmerBox(width: 160, height: AppSizes.medium),
        MBShimmerBox(width: 120, height: AppSizes.md),
      ],
    );
  }
}
