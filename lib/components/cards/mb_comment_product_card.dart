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

  const MBCommentProductCard({
    super.key,
    this.commentId,
    required this.userName,
    required this.createdAt,
    required this.imageUrl,
    required this.commentText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 300,
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
              userAlias: createdAt,
              imageUrl: imageUrl,
              hasBackground: false,
              paddingH: true,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.medium),
              child: Text(
                  commentText,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
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
                        title: '1234',
                        textColor: AppColors.grey400,
                        onPressed: () {},
                        horizontalAlign: .start,
                      )
                  ),
                  Expanded(
                      child: MBTextButton(
                        icon: LucideIcons.images,
                        title: '12',
                        textColor: AppColors.grey400,
                        onPressed: () {},
                        horizontalAlign: .start,
                      )
                  ),
                  Spacer(),
                  Expanded(
                      child: MBTextButton(
                        icon: LucideIcons.thumbs_up,
                        title: '543',
                        textColor: AppColors.focus,
                        onPressed: () {},
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