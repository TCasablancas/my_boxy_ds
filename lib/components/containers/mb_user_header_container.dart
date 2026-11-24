import 'package:flutter/material.dart';
import 'dart:io';

import 'package:my_boxy_ds/my_boxy_ds.dart';

class MBUserHeaderContainer extends StatelessWidget {
  final String userName;
  final String userAlias;
  final String imageUrl;
  final bool? hasBackground;
  final VoidCallback? onProfileTap;
  final bool? paddingH;
  final bool? hasNavigation;

  const MBUserHeaderContainer({
    super.key,
    required this.userName,
    required this.userAlias,
    required this.imageUrl,
    this.hasBackground,
    this.onProfileTap,
    this.paddingH,
    this.hasNavigation = true,
  });

  /// URL http(s) vem da rede; caminho local vem do arquivo; vazio fica sem foto.
  ImageProvider? get _avatar {
    if (imageUrl.isEmpty) return null;
    if (imageUrl.startsWith('http://') || imageUrl.startsWith('https://')) {
      return NetworkImage(imageUrl);
    }
    return FileImage(File(imageUrl));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (hasNavigation ?? false) ? onProfileTap : null,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: paddingH == true ? 16 : 0, vertical: 12
        ),
        decoration: BoxDecoration(
          color: hasBackground == true ? Colors.grey[100] : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 14,
              backgroundImage: _avatar,
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: AppTextStyles.appBarTitle.copyWith(
                      letterSpacing: -0.5,
                      color: AppColors.grey900,
                      height: 1.0,
                    )
                  ),
                  Text(
                    userAlias,
                    style: AppTextStyles.switchTag.copyWith(
                      letterSpacing: -0.5,
                      color: AppColors.grey400
                    ),
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
            const Spacer(),
            hasNavigation ?? false ?
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.grey[500], size: 12
              ) : SizedBox.shrink()
          ],
        ),
      ),
    );
  }

} 