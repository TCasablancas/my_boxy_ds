import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:my_boxy_ds/components/containers/mb_box_rounded_container.dart';
import 'package:my_boxy_ds/components/containers/mb_user_header_container.dart';
import 'package:my_boxy_ds/components/mb_separator.dart';
import 'package:my_boxy_ds/my_boxy_ds.dart';

enum MBCommentProductCardType {
  review, question
}

class MBCommentProductCard extends StatelessWidget {

  final MBCommentProductCardType? type;
  final String? commentId;
  final String userName;
  final String createdAt;
  final String imageUrl;
  final String commentText;
  final String? userAlias;
  final String? rating;
  final int? likesCount;
  final int? photosCount;
  final double? width;
  final int? maxLines;
  final bool? shadow;
  final VoidCallback? onTap;
  final VoidCallback? onLikeTap;
  final VoidCallback? onPhotosTap;
  final bool? hasAnswer;

  /// Resposta da loja (tipo `.question`); só aparece com [hasAnswer] verdadeiro.
  final String? answerText;
  final String? answerAuthorName;
  final String? answerAuthorImageUrl;

  /// Data da resposta já formatada.
  final String? answeredAt;

  const MBCommentProductCard({
    super.key,
    this.type = .review,
    this.commentId,
    required this.userName,
    required this.createdAt,
    required this.imageUrl,
    required this.commentText,
    this.onTap,
    this.userAlias,
    this.rating,
    this.likesCount,
    this.photosCount,
    this.width = 300,
    this.maxLines = 2,
    this.shadow,
    this.onLikeTap,
    this.onPhotosTap,
    this.hasAnswer,
    this.answerText,
    this.answerAuthorName,
    this.answerAuthorImageUrl,
    this.answeredAt,
  });

  @override
  Widget build(BuildContext context) {
    final colorCount = (photosCount ?? 0) > 0 ? AppColors.grey900 : AppColors.grey400;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        margin: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            if (shadow ?? false)
              BoxShadow(
                color: Colors.black.withAlpha(20),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MBUserHeaderContainer(
              userName: userName,
              userAlias: userAlias ?? createdAt,
              imageUrl: imageUrl,
              hasBackground: false,
              paddingH: true,
              hasNavigation: type == .review,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.medium),
              child: Text(
                commentText,
                maxLines: maxLines,
                overflow: maxLines == null ? null : TextOverflow.ellipsis,
                style: AppTextStyles.description.copyWith(
                  letterSpacing: -0.5
                )
              ),
            ),
            if (type == .review) _reviewActions(colorCount)
            else if (hasAnswer == true) _questionReply(),
            SizedBox(height: hasAnswer == true ? 0 : 12)
          ]
        ),
      )
    );
  }

  Widget _questionReply() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MBSeparator(
          marginEdges: EdgeInsets.only(top: AppSizes.medium),
        ),
        Row(children: [
          Padding(
            padding: EdgeInsets.only(
              left: AppSizes.medium, right: AppSizes.small
            ),
            child: SizedBox(
              width: 22,
              child: Icon(
                LucideIcons.corner_down_right,
                size: 16, color: AppColors.grey400,
              ),
            ),
          ),
          Expanded(
            child: MBUserHeaderContainer(
              userName: answerAuthorName ?? '',
              userAlias: answeredAt ?? '',
              imageUrl: answerAuthorImageUrl ?? '',
              hasBackground: false,
              paddingH: false,
              hasNavigation: false,
            )
          ),
        ]
        ),
        Padding(
          // Alinha com o nome da loja, ao lado do ícone de resposta
          padding: const EdgeInsets.fromLTRB(
            AppSizes.medium + 22 + AppSizes.small, 0, AppSizes.medium, AppSizes.medium
          ),
          child: Text(
            answerText ?? '',
            style: AppTextStyles.description.copyWith(letterSpacing: -0.5),
          ),
        ),
      ],
    );
  }

  Widget _reviewActions(Color? colorCount) {
    return Column(
      children: [
        MBSeparator(
          marginEdges: EdgeInsets.only(top: AppSizes.medium, bottom: AppSizes.small),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(
              AppSizes.medium, AppSizes.sm, AppSizes.medium, AppSizes.md
          ),
          child: Row(
            spacing: AppSizes.small,
            children: [
              Expanded(
                  child: MBBoxRoundedContainer(
                      background: AppColors.grey100,
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: MBTextButton(
                        icon: LucideIcons.star,
                        title: '${rating ?? 0}',
                        textColor: AppColors.grey400,
                        onPressed: onTap,
                        horizontalAlign: .center,
                      )
                  )
              ),
              Expanded(
                  child: MBBoxRoundedContainer(
                      background: AppColors.grey100,
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: MBTextButton(
                        icon: LucideIcons.images,
                        title: '${photosCount ?? 0}',
                        textColor: colorCount,
                        onPressed: onPhotosTap,
                        horizontalAlign: .center,
                      )
                  )
              ),
              Spacer(),
              Expanded(
                  child: MBBoxRoundedContainer(
                      background: AppColors.accent.withAlpha(40),
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: MBTextButton(
                        icon: LucideIcons.thumbs_up,
                        title: '${likesCount ?? 0}',
                        textColor: AppColors.focus,
                        onPressed: onLikeTap,
                        horizontalAlign: .center,
                      )
                  )
              )
            ],
          ),
        )
      ],
    );
  }
}