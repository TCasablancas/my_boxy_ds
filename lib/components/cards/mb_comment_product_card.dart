import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:my_boxy_ds/components/containers/mb_user_header_container.dart';
import 'package:my_boxy_ds/components/mb_separator.dart';
import 'package:my_boxy_ds/my_boxy_ds.dart';

class MBCommentProductCard extends StatelessWidget {
  final String? commentId;
  final String userName;
  final String createdAt;
  final String imageUrl;
  final String commentText;
  final VoidCallback? onTap;
  /// Alias do autor. Sem ele, o header mostra [createdAt] (comportamento antigo).
  final String? userAlias;
  final int? rating;
  final int? likesCount;
  final int? photosCount;
  /// Largura fixa no carrossel; null ocupa a largura disponível (lista).
  final double? width;
  /// Linhas do comentário; null mostra o texto inteiro.
  final int? maxLines;
  final VoidCallback? onLikeTap;
  final VoidCallback? onPhotosTap;

  const MBCommentProductCard({
    super.key,
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
    this.onLikeTap,
    this.onPhotosTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
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
            MBSeparator(
              marginEdges: EdgeInsets.only(top: AppSizes.medium, bottom: AppSizes.small),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSizes.medium, AppSizes.sm, AppSizes.medium, AppSizes.md
              ),
              child: Row(
                children: [
                  Expanded(
                      child: MBTextButton(
                        icon: LucideIcons.star,
                        title: '${rating ?? 0}',
                        textColor: AppColors.grey400,
                        onPressed: onTap,
                        horizontalAlign: .start,
                      )
                  ),
                  Expanded(
                      child: MBTextButton(
                        icon: LucideIcons.images,
                        title: '${photosCount ?? 0}',
                        textColor: AppColors.grey400,
                        onPressed: onPhotosTap,
                        horizontalAlign: .start,
                      )
                  ),
                  Spacer(),
                  Expanded(
                      child: MBTextButton(
                        icon: LucideIcons.thumbs_up,
                        title: '${likesCount ?? 0}',
                        textColor: AppColors.focus,
                        onPressed: onLikeTap,
                        horizontalAlign: .end,
                      )
                  )
                ],
              ),
            )
          ]
        ),
      )
    );
  }
}