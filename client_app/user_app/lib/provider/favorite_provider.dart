import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteProvider with ChangeNotifier {
  String _updatedDate = '';
  String get updatedDate => _updatedDate;

  List<dynamic> favoriteList = [];
  List<dynamic> _favoriteItemList = [];
  List get favoriteItemList => _favoriteItemList;

  void _setListPrefsItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('favorite_list', jsonEncode(favoriteList));
    prefs.setString('updatedAt', DateTime.now().toString());
    notifyListeners();
  }

  void _getListPrefsItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _favoriteItemList = jsonDecode(prefs.getString('favorite_list') ?? '');
    _updatedDate = prefs.getString('updatedAt') ?? '';
    notifyListeners();
  }

  void saveFavoriteList(String favProductId) async {
    if (getFavoriteList().isEmpty) {
      favoriteList = getFavoriteList();
      favoriteList.add({'product': favProductId});
    } else {
      final listLength = getFavoriteList().length;
      bool check = false;
      for (int i = 0; i < listLength; i++) {
        if (getFavoriteList()[i]['product'] == favProductId) {
          check = true;
        }
      }
      if (!check) {
        favoriteList = getFavoriteList();
        favoriteList.add({'product': favProductId});
      }
    }
    _setListPrefsItems();
  }

  void replaceFavoriteList(List<dynamic> userFavList) async {
    favoriteList = userFavList;
    _setListPrefsItems();
  }

  void deleteFavoriteList(String favProductId) async {
    late int itemIndex;
    final listLength = getFavoriteList().length;
    for (int i = 0; i < listLength; i++) {
      if (getFavoriteList()[i]['product'] == favProductId) {
        itemIndex = i;
      }
    }
    favoriteList = getFavoriteList();
    favoriteList.removeAt(itemIndex);
    _setListPrefsItems();
  }

  List getFavoriteList() {
    _getListPrefsItems();
    return _favoriteItemList;
  }

  bool isItemPresent(String prodId) {
    final favoriteList = getFavoriteList();
    for (int i = 0; i < favoriteList.length; i++) {
      if (favoriteList[i]['product'] == prodId) {
        return true;
      }
    }
    return false;
  }

  String getUpdatedDate() {
    _getListPrefsItems();
    return _updatedDate;
  }
}
