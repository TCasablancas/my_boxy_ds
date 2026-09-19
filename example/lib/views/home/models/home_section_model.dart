import 'home_section_tile_model.dart';

class HomeSectionModel {
  final String title;
  final List<HomeSectionTileModel> items;

  HomeSectionModel({
    required this.title,
    required this.items,
  });

  factory HomeSectionModel.fromJson(Map<String, dynamic> json) {
    return HomeSectionModel(
      title: json['title'],
      items: (json['items'] as List).map(
        (item) => HomeSectionTileModel.fromJson(item)
      ).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}