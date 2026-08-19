import 'package:flutter/material.dart';
import 'package:my_boxy_ds/ui/mb_typography.dart';

enum MBTitleSubtitledLabelType { defaultType, small, big, header }

class MBTitleSubtitled extends StatelessWidget {
  final String title;
  final String description;
  final Color? color;
  final TextAlign textAlign;
  final MBTitleSubtitledLabelType type; 

  const MBTitleSubtitled({
    super.key,
    required this.title,
    this.description = '',
    this.color = const Color(0xFF424242),
    this.textAlign = TextAlign.left,
    this.type = MBTitleSubtitledLabelType.defaultType,
  });

  TextStyle get _titleStyle => switch (type) {
    MBTitleSubtitledLabelType.defaultType => AppTypography.body1,
    MBTitleSubtitledLabelType.small => AppTypography.description,
    MBTitleSubtitledLabelType.big => AppTypography.h3,
    MBTitleSubtitledLabelType.header => AppTypography.h2,
  };

  TextStyle get _descriptionStyle => switch (type) {
    MBTitleSubtitledLabelType.defaultType => AppTypography.description,
    MBTitleSubtitledLabelType.small => AppTypography.switchTag,
    MBTitleSubtitledLabelType.big => AppTypography.body1,
    MBTitleSubtitledLabelType.header => AppTypography.h3,
  };

  @override
  Widget build(BuildContext context) {
    return (
      Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Text(
              title,
              textAlign: textAlign,
              style: TextStyle(
                fontSize: _titleStyle.fontSize,
                fontFamily: _titleStyle.fontFamily,
                fontWeight: FontWeight.w700,
                color: color,
              )
            )
          ),
          SizedBox(
            width: double.infinity,
            child: Text(
              description,
              textAlign: textAlign,
              style: TextStyle(
                fontSize: _descriptionStyle.fontSize,
                fontFamily: _descriptionStyle.fontFamily,
                fontWeight: _descriptionStyle.fontWeight,
                color: Colors.grey[500],
              ),
            )
          )
        ]
      )
    );
  }
 }