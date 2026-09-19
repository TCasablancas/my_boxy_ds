import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'models/home_section_model.dart';

class HomeViewModel extends ChangeNotifier {
  static const _homeItemsAsset =
      'packages/my_boxy_ds/assets/json/home_items_list.json';

  List<HomeSectionModel> _listItems = const [];
  List<HomeSectionModel> get listItems => _listItems;

  Future<List<HomeSectionModel>> fetchHomeListItems() async {
    final list = await rootBundle.loadString(_homeItemsAsset);
    final decodedJson = jsonDecode(list) as List<dynamic>;

    _listItems = decodedJson.map(
      (item) => HomeSectionModel.fromJson(item as Map<String, dynamic>),
    ).toList(growable: false);

    notifyListeners();
    return _listItems;
  }

  void navigateTo(String routeName) {
    // Implement navigation logic here
  }
}