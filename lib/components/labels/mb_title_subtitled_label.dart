import 'package:flutter/material.dart';
import 'package:my_boxy_ds/ui/mb_typography.dart';

enum MBTitleSubtitledLabelType { defaultType, small, big, header }

class MBTitleSubtitled extends StatelessWidget {
  final String title;
  final String description;
  final Color? color;
  final TextAlign textAlign;
  final MBTitleSubtitledLabelType type;
  final EdgeInsetsGeometry? padding;

  const MBTitleSubtitled({
    super.key,
    required this.title,
    this.description = '',
    this.color = const Color(0xFF424242),
    this.textAlign = TextAlign.left,
    this.type = MBTitleSubtitledLabelType.defaultType,
    this.padding,
  });

  TextStyle get _titleStyle => switch (type) {
    MBTitleSubtitledLabelType.defaultType => AppTypography.body1,
    MBTitleSubtitledLabelType.small => AppTypography.description,
    MBTitleSubtitledLabelType.big => AppTypography.h3.copyWith(
      fontWeight: FontWeight.w700,
      letterSpacing: -0.5
    ),
    MBTitleSubtitledLabelType.header => AppTypography.h2,
  };

  TextStyle get _descriptionStyle => switch (type) {
    MBTitleSubtitledLabelType.defaultType => AppTypography.description,
    MBTitleSubtitledLabelType.small => AppTypography.switchTag,
    MBTitleSubtitledLabelType.big => AppTypography.body1.copyWith(
      letterSpacing: -0.5
    ),
    MBTitleSubtitledLabelType.header => AppTypography.h3,
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Column(
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
                letterSpacing: -0.5,
                color: color,
              )
            )
          ),
          if (description.isNotEmpty)
            SizedBox(
              width: double.infinity,
              child: Text(
                description,
                textAlign: textAlign,
                style: TextStyle(
                  fontSize: _descriptionStyle.fontSize,
                  fontFamily: _descriptionStyle.fontFamily,
                  fontWeight: _descriptionStyle.fontWeight,
                  letterSpacing: -0.2,
                  color: Colors.grey[500],
                ),
              )
            )
        ]
      )
    );
  }
 }