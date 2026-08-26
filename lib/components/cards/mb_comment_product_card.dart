import 'package:flutter/material.dart';
import 'package:my_boxy_ds/components/containers/mb_user_header_container.dart';

class MBCommentProductCard extends StatelessWidget {
  final String userName;
  final String userAlias;
  final String imageUrl;
  final String commentText;
  final VoidCallback? onTap;

  const MBCommentProductCard({
    super.key,
    required this.userName,
    required this.userAlias,
    required this.imageUrl,
    required this.commentText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 320,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withAlpha(20),
              spreadRadius: 3,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            MBUserHeaderContainer(
              userName: userName,
              userAlias: userAlias,
              imageUrl: imageUrl,
              hasBackground: false,
              paddingH: false,
            ),
            Text(
              commentText.substring(0, commentText.length > 100 ? 100 : commentText.length) + (commentText.length > 100 ? '...' : ''),
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Lexend',
                fontWeight: FontWeight.w400,
                letterSpacing: -0.5,
                color: Colors.grey[700],
              ),  
            ),
            
          ]
        ),
      )
    );
  }
}