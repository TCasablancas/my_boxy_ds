import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:my_boxy_ds/components/containers/mb_box_rounded_container.dart';
import 'package:my_boxy_ds/components/containers/mb_user_header_container.dart';
import 'package:my_boxy_ds/components/mb_separator.dart';
import 'package:my_boxy_ds/my_boxy_ds.dart';

class MBCommentProductCard extends StatelessWidget {

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
    this.shadow,
    this.onLikeTap,
    this.onPhotosTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorCount = photosCount! > 0 ? AppColors.grey900 : AppColors.grey400;

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
                        title: '$photosCount',
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
                        title: '$likesCount',
                        textColor: AppColors.focus,
                        onPressed: onLikeTap,
                        horizontalAlign: .center,
                      )
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