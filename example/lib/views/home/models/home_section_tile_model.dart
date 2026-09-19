import 'package:flutter/material.dart';

class HomeSectionTileModel {
  final IconData icon;
  final String label;
  final IconData actionIcon;
  final String path;

  const HomeSectionTileModel({
    required this.icon,
    required this.label,
    required this.actionIcon,
    required this.path,
  });

  factory HomeSectionTileModel.fromJson(Map<String, dynamic> json) {
    return HomeSectionTileModel(
      icon: _iconFromName(json['icon'] as String),
      label: json['label'] as String,
      actionIcon: _iconFromName(json['actionIcon'] as String),
      path: json['path'] as String,
    );
  }

  static IconData _iconFromName(String name) {
    const icons = <String, IconData>{
      'person': Icons.person,
      'chevron_right': Icons.chevron_right,
    };
    final icon = icons[name];
    if (icon == null) {
      throw FormatException('Unsupported Material icon: $name');
    }
    return icon;
  }

  Map<String, dynamic> toJson() {
    return {
      'icon': icon.codePoint,
      'label': label,
      'actionIcon': actionIcon.codePoint,
      'path': path,
    };
  }
}