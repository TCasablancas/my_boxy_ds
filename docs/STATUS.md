# Status — inventário do design system

Levantado em 2026-10-14. Atualize ao criar, renomear ou remover tokens e componentes.

## Stack
- Pacote Flutter `my_boxy_ds` 0.0.1, Dart SDK `^3.13.0`, Flutter local 3.47.0, lints `flutter_lints ^6`.
- Dependências: `flutter_svg`, `gradient_blur`, `intl`, `lottie`, `flutter_lucide`, `camerawesome`, `image`.
- Fontes: Lexend (primária), SFMono (mono), Gloock.
- Consumo: `my_boxy_flutter` usa `path: ../my_boxy_ds` e importa arquivos por caminho (ex.: `package:my_boxy_ds/components/containers/mb_main_view.dart`, `package:my_boxy_ds/ui/design_tokens/design_tokens.dart`).

## Tokens atuais (`lib/ui/design_tokens/`, barrel `design_tokens.dart`)

| Classe | Arquivo | Membros |
|---|---|---|
| `AppColors` | `app_colors.dart` | primary, primaryLight, primaryDark, secondary, accent, background, lightBackground, surface, surfaceVariant, backgroundAlt, errorBackground, textPrimary, textSecondary, textTertiary, textOnDark, disabledText, border, borderStrong, divider, success, warning, error, errorLight, errorStrong, focus, focusLight, gradientStart, gradientEnd, neutral100/200/800/900, white, black, transparent, blueAccent, greyLight, grey100–grey900 |
| `AppTextStyles` | `app_text_styles.dart` | titleLarge, titleMedium, titleSmall, bodyLarge, bodyMedium, bodyMediumStrong, description, labelSmall, button, appBarTitle, linkText, snackBarTitle, switchTag, errorInline, productTitle, productSubtitleStrong, productSubtitle, price, searchInput, priceInstallment; funções snackbar(), input(), titleMediumOf(), titleSmallOf(), bodyLargeOf(), descriptionOf(), labelSmallOf(), buttonOf() |
| `AppFonts` | `app_fonts.dart` | primary (Lexend), mono (SFMono), icons (MaterialIcons) |
| `AppSizes` | `app_sizes.dart` | xs 2, sm 4, small 8, md 12, medium 16, large 24, xl 32, xxl 48; inputHeight 50, bottomMenuHeight 60, otpFieldHeight 52, iconButtonSize 30 |
| `AppRadius` | `app_radius.dart` | xs 2, sm 6, medium 8, lg 10, xl 12, compact 14, xxl 16, xxxl 20, round 24, full 999; BorderRadius allSmall…allFull, topSheet |
| `AppBorders` | `app_borders.dart` | thin, thick, xThickLight, focusThick, errorThick, none; sideOf(), outline() |
| `AppShadows` | `app_shadows.dart` | card, cardStrong, iconButton, floatingButton, bottomSheet, coupon, none; iconButtonConditional() |
| `AppDecorations` | `app_decorations.dart` | card(), pill(), bordered(), errorBanner, circle, circleOf(), bottomSheetTop |

Não há token dedicado de espaçamento: hoje `AppSizes` cumpre esse papel.

## Tokens legados (não usar em código novo)
- `lib/ui/mb_design_tokens.dart`: `AppColors` (subconjunto, conflita em nome com o atual), `AppSpacing` (xs 4 … xxl 48), `AppRadius` (valores diferentes do atual: sm 8, md 12, lg 16, xl 24), `AppTheme.lightTheme`.
- `lib/ui/mb_typography.dart`: `AppTypography` (h1–h3, body1–3, caption, *Fn()).
- `lib/ui/mb_box_decorations.dart`: `AppBoxDecorations`. `lib/ui/mb_input_decorations.dart`: `AppInputDecorations`.
- `lib/components/buttons/mb_button_tokens.dart`: `MBButtonColors` + `mbButtonTextStyle()` (cores duplicadas de `AppColors`).
- ~26 componentes ainda importam arquivos legados.

## Outros utilitários
- `lib/ui/formatters/mb_brazilian_currency_formatter.dart` (com teste).
- `lib/ui/icons/mb_icons_actions.dart`.

## Componentes

"No barrel" = exportado no barrel da categoria. O barrel principal `lib/my_boxy_ds.dart` só inclui bottomsheet, buttons, caroussels, cards, input, menus, selectors e tokens.

### bottomsheet

| Arquivo | Classes públicas | No barrel | Teste |
|---|---|---|---|
| `bottomsheet/mb_bottomsheet_handler.dart` | MBBottomsheetHandler | - | - |
| `bottomsheet/mb_main_bottomsheet.dart` | MBMainBottomsheet | sim | - |

### buttons

| Arquivo | Classes públicas | No barrel | Teste |
|---|---|---|---|
| `buttons/mb_add_cart_btn.dart` | MBAddToCartBtn | - | - |
| `buttons/mb_address_item_btn.dart` | MBAddressItemButton | sim | sim |
| `buttons/mb_animated_btn_title.dart` | MBAnimatedButtonTitle | - | - |
| `buttons/mb_bottom_menu_item_btn.dart` | MBBottomMenuItemButton | - | - |
| `buttons/mb_button_tokens.dart` |  | - | - |
| `buttons/mb_category_btn.dart` | MBCategoryButton | sim | - |
| `buttons/mb_favorite_btn.dart` | MBFavoriteButton | sim | - |
| `buttons/mb_favorite_icon_btn.dart` | MBFavoriteIconButton | sim | - |
| `buttons/mb_floating_cart_btn.dart` | MBFloatingCartButton | sim | - |
| `buttons/mb_full_right_icon_btn.dart` | MBFullRightIconBtn | - | - |
| `buttons/mb_header_action_btn.dart` | MBHeaderActionBtn | - | - |
| `buttons/mb_icon_btn.dart` | MBIconBtn | - | - |
| `buttons/mb_main_btn.dart` | MBMainButton | sim | - |
| `buttons/mb_main_info_square_btn.dart` | MBMainInfoSquareButton | sim | - |
| `buttons/mb_menu_slider_btn.dart` | MBMenuSliderBtn | - | - |
| `buttons/mb_outlined_round_btn.dart` | MBOutlinedRoundBtn | sim | - |
| `buttons/mb_outlined_sm_btn.dart` | MBOutlinedSmallButton | sim | - |
| `buttons/mb_pill_btn.dart` | MBPillBtn | - | - |
| `buttons/mb_play_pause_btn.dart` | MBPlayPauseButton | sim | - |
| `buttons/mb_rounded_icon_btn.dart` | MBRoundedIconButton | sim | - |
| `buttons/mb_simple_square_icon_btn.dart` | MBSimpleSquareIconBtn | - | - |
| `buttons/mb_square_icon_btn.dart` | MBSquareIconBtn | - | - |
| `buttons/mb_square_selection_btn.dart` | MBSquareSelectionBtn | - | - |
| `buttons/mb_text_btn.dart` | MBTextButton | sim | - |
| `buttons/mb_upload_file_btn.dart` | MBUploadFileButton | - | sim |

### cards

| Arquivo | Classes públicas | No barrel | Teste |
|---|---|---|---|
| `cards/mb_blurred_card.dart` | MBBlurredCard | sim | - |
| `cards/mb_carousel_store_products.dart` | MBCarouselStoreProducts | sim | - |
| `cards/mb_category_hero_card.dart` | MBCategoryHeroCard | sim | - |
| `cards/mb_category_tile_card.dart` | MBCategoryTileCard | sim | - |
| `cards/mb_comment_product_card.dart` | MBCommentProductCard | - | - |
| `cards/mb_coupon_card.dart` | MBCouponCard | sim | - |
| `cards/mb_inline_info_card.dart` | MBInlineInfoCard | sim | - |
| `cards/mb_large_rating_card.dart` | MBLargeRatingCard | sim | sim |
| `cards/mb_list_component_card.dart` | MBListComponentCard | sim | - |
| `cards/mb_main_product_card.dart` | MBMainProductCard | sim | - |
| `cards/mb_product.dart` | MBProduct | sim | - |
| `cards/mb_product_detail_text_card.dart` | MBProductDetailTextCard | - | - |
| `cards/mb_rating_stars.dart` | MBRatingStars | sim | - |
| `cards/mb_review_count_text.dart` | MBReviewCountText | sim | - |
| `cards/mb_row_action_card.dart` | MBRowActionCard | - | - |
| `cards/mb_simple_product_related_card.dart` | MBSimpleProductRelatedCard | - | - |
| `cards/mb_store_product_card.dart` | MBStoreProductCard | - | - |
| `cards/mb_user_favorite_card.dart` | MBUserFavoriteItem, MBUserFavoriteCard | sim | - |
| `cards/mb_user_home_carousel_card.dart` | MBUserHomeCarouselCard | - | - |

### caroussels

| Arquivo | Classes públicas | No barrel | Teste |
|---|---|---|---|
| `caroussels/mb_carousel_progress_dot.dart` | MBCarouselProgressDot, MBCarouselProgressDotState | - | - |
| `caroussels/mb_home_carousel_list_header.dart` | MBHomeCarouselItem, MBHomeCarouselListHeader | sim | - |
| `caroussels/mb_home_store_item_carousel.dart` | MBHomeStoreItemCarousel | sim | - |
| `caroussels/mb_main_horizontal_carousel.dart` | MBMainHorizontalCarousel | - | - |
| `caroussels/mb_main_product_carousel.dart` | MBMainProductCarouselItem, MBMainProductCarouselTag, MBMainProductCarousel | sim | - |
| `caroussels/mb_onboarding_type_carousel.dart` | MBOnboardingCarouselItem, MBOnboardingTypeCarousel | sim | sim |

### containers

| Arquivo | Classes públicas | No barrel | Teste |
|---|---|---|---|
| `containers/mb_action_tiled_list_view.dart` | MBActionTiledListView | - | - |
| `containers/mb_box_rounded_container.dart` | MBBoxRoundedContainer | - | - |
| `containers/mb_carousel_rating_container.dart` | MBCarouselRatingContainer | - | - |
| `containers/mb_category_selector_container.dart` | MBCategorySelectorContainer | - | - |
| `containers/mb_checkout_tile_container.dart` | MBCheckoutTileContainer | - | - |
| `containers/mb_main_view.dart` | MBMainView | - | - |
| `containers/mb_price_reactive_container_view.dart` | MBPriceReactiveContainerView | - | - |
| `containers/mb_product_card_image_container.dart` | MBProductCardImageContainer | - | - |
| `containers/mb_rating_container.dart` | MBRatingBadge | - | - |
| `containers/mb_section_titled.dart` | MBSectionTitled | - | - |
| `containers/mb_simple_location_container.dart` | MBSimpleLocationContainer | - | - |
| `containers/mb_simple_titled_container.dart` | MBSimpleTitledContainer | - | - |
| `containers/mb_store_badge.dart` | MBStoreBadge | - | - |
| `containers/mb_store_image_container.dart` | MBStoreImageContainer | - | - |
| `containers/mb_text_blur_container.dart` | MBTextBlurContainer | - | - |
| `containers/mb_user_header_container.dart` | MBUserHeaderContainer | - | - |

### counter

| Arquivo | Classes públicas | No barrel | Teste |
|---|---|---|---|
| `counter/mb_main_counter.dart` | MBMainCounter | - | - |

### headers

| Arquivo | Classes públicas | No barrel | Teste |
|---|---|---|---|
| `headers/mb_home_header.dart` | MBHomeHeader | - | - |
| `headers/mb_product_card_header.dart` | MBProductCardHeader | - | - |
| `headers/mb_product_detail_header.dart` | MBProductDetailHeader | - | - |

### input

| Arquivo | Classes públicas | No barrel | Teste |
|---|---|---|---|
| `input/mb_main_input.dart` | MBMainInput | sim | sim |
| `input/mb_simple_input.dart` | MBSimpleInput | sim | sim |

### labels

| Arquivo | Classes públicas | No barrel | Teste |
|---|---|---|---|
| `labels/mb_center_stripe_text.dart` | MBCenterStripeText | - | - |
| `labels/mb_checkout_tile_price.dart` | MBCheckoutTilePrice | - | - |
| `labels/mb_checkout_tile_value.dart` | MBCheckoutTileValue | - | - |
| `labels/mb_colored_box_label_view.dart` | MBColoredBoxLabelView | - | - |
| `labels/mb_cutted_price_label.dart` | MBCuttedPriceLabel | - | - |
| `labels/mb_installment_price_label.dart` | MBInstallmentPriceLabel | - | - |
| `labels/mb_price_product_detail.dart` | MBPriceProductDetail | - | - |
| `labels/mb_price_value_label.dart` | MBPriceValueLabel | - | - |
| `labels/mb_product_card_label.dart` | MBProductCardLabel | - | - |
| `labels/mb_search_list_tile_label.dart` | MBSearchListTileLabel | - | - |
| `labels/mb_title_subtitled_label.dart` | MBTitleSubtitled | - | - |

### (raiz)

| Arquivo | Classes públicas | No barrel | Teste |
|---|---|---|---|
| `mb_separator.dart` | MBSeparator | - | - |

### menus

| Arquivo | Classes públicas | No barrel | Teste |
|---|---|---|---|
| `menus/mb_bottom_fixed_menu.dart` | MBBottomFixedMenu | sim | - |
| `menus/mb_collapsible_sidebar.dart` | MBSidebarController, MBSidebarItem, MBCollapsibleSidebar | sim | - |
| `menus/mb_floating_bottom_menu.dart` | MBFloatingMenuController, MBFloatingBottomMenu | sim | sim |
| `menus/mb_flow_bottom_menu.dart` | MBFlowBottomMenu | - | - |

### selectors

| Arquivo | Classes públicas | No barrel | Teste |
|---|---|---|---|
| `selectors/mb_main_selector.dart` | MBMainSelector | sim | - |
| `selectors/mb_option_toggle.dart` | MBOptionToggle | sim | - |
| `selectors/mb_selector_with_counter.dart` | MBSelectorWithCounter | - | sim |
| `selectors/mb_square_check_selector.dart` | MBSquareCheckSelector | - | sim |
| `selectors/mb_text_with_select.dart` | MBTextWithSelect | sim | - |

### shimmer

| Arquivo | Classes públicas | No barrel | Teste |
|---|---|---|---|
| `shimmer/home_shimmer/mb_carousel_shimmer.dart` | MBCarouselShimmer | sim | - |
| `shimmer/home_shimmer/mb_home_shimmer_view.dart` | MBHomeShimmerView | sim | sim |
| `shimmer/home_shimmer/mb_product_card_shimmer.dart` | MBProductCardShimmer | sim | - |
| `shimmer/home_shimmer/mb_shimmer_box.dart` | MBShimmerBox | sim | - |
| `shimmer/mb_shimmer.dart` | MBShimmer | sim | - |

### tags

| Arquivo | Classes públicas | No barrel | Teste |
|---|---|---|---|
| `tags/mb_category_selectable_tag.dart` | MBCategorySelectableTag | - | - |

### tiles

| Arquivo | Classes públicas | No barrel | Teste |
|---|---|---|---|
| `tiles/mb_cart_item_tile.dart` | MBCartItemTile | - | - |
| `tiles/mb_checkout_item_tile.dart` | MBCheckoutItemTile | - | - |
| `tiles/mb_checkout_product_tile.dart` | MBCheckoutProductTile | - | - |
| `tiles/mb_item_variation_tile.dart` | MBItemVariationTile | - | - |
| `tiles/mb_light_item_tile.dart` | MBLightItemTile | - | sim |
| `tiles/mb_removable_tile.dart` | MBRemovableTile | - | - |

### views

| Arquivo | Classes públicas | No barrel | Teste |
|---|---|---|---|
| `views/mb_camera_view.dart` | MBCameraView | - | - |
| `views/mb_main_loading_view.dart` | MBMainLoadingView, MBMainLoadingViewController | - | - |
| `views/mb_uploaded_image_view.dart` | MBUploadedImageView | - | - |

## Testes
- 13 arquivos em `test/` (widget tests + formatter), 2 em `example/test`.
- Nenhum golden test.
- Execução local em 2026-10-14: `flutter test` com 25 passando e 2 falhando:
  - `test/components/selectors/mb_square_check_selector_view_test.dart`: não compila (`MBSquareCheckSelectorView` não existe; classe atual é `MBSquareCheckSelector`).
  - `test/components/caroussels/mb_onboarding_type_carousel_test.dart`: "centers half-width progress and supports peek display".
- `flutter analyze` local: 17 issues (1 error, warnings de imports não usados e `must_be_immutable` em `mb_camera_view.dart`, infos). Exit code 1.

## Pendências conhecidas
- CI vai ficar vermelho até corrigir o erro de analyze e os 2 testes acima.
- `pubspec.yaml` declara `SFMonoSemiBold.otf` e `SFMonoSemiBoldItalic.otf`, mas os arquivos são `SFMonoSemibold.otf` e `SFMonoSemiboldItalic.otf`. Funciona no macOS (case-insensitive), deve falhar no Linux/CI.
- Barrel principal não exporta containers, counter, headers, labels, shimmer, tags, tiles, views; vários componentes fora dos barrels de categoria.
- Valores fixos: ~102 arquivos em `lib/components` com `Color(0x…)`/`Colors.*` e ~42 com `fontSize:` literal.
- Duas definições de `AppColors`/`AppRadius` (atual vs legado) com valores divergentes.
- Stub `Calculator` em `lib/my_boxy_ds.dart` (template do Flutter).
- `assets/json/home_items_list.json` é dado de exemplo dentro do pacote.
- README e `CHANGELOG.md` da raiz são placeholders.
