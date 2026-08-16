import 'package:flutter/material.dart';

class MBInlineInfoCard extends StatelessWidget {
  final String title;
  final String? description;
  final String? actionLabel;
  final VoidCallback? onAction;

  const MBInlineInfoCard({
    super.key,
    required this.title,
    this.description,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5FF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1F2A44),
            ),
          ),
          if (description != null) ...[
            const SizedBox(height: 6),
            Text(
              description!,
              style: const TextStyle(
                fontSize: 13,
                height: 18 / 13,
                color: Color(0xFF4B5875),
              ),
            ),
          ],
          if (actionLabel != null && onAction != null) ...[
            const SizedBox(height: 8),
            InkWell(
              onTap: onAction,
              child: Text(
                actionLabel!,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF3457D5),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
