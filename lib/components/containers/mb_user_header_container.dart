import 'package:flutter/material.dart';
import 'dart:io';

class MBUserHeaderContainer extends StatelessWidget {
  final String userName;
  final String userAlias;
  final String imageUrl;
  final bool? hasBackground;
  final VoidCallback? onProfileTap;

  const MBUserHeaderContainer({
    super.key,
    required this.userName,
    required this.userAlias,
    required this.imageUrl,
    this.hasBackground,
    this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onProfileTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: hasBackground == true ? Colors.grey[100] : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: Image.file(File(imageUrl)).image,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.5,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    userAlias,
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.2,
                      color: Colors.grey[700]!,
                    ),
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
            const Spacer(),
            Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey[500], size: 12),
          ],
        ),
      ),
    );
  }

} 