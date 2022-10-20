// import 'dart:convert';
// import 'package:flutter/cupertino.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class SellProvider with ChangeNotifier {
//   List<dynamic> sellsList = [];
//   List<dynamic> _sellsItemList = [];
//   List get sellsItemList => _sellsItemList;

//   void _setListPrefsItems() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setString('sells_list', jsonEncode(sellsList));
//     notifyListeners();
//   }

//   void _getListPrefsItems() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     _sellsItemList = jsonDecode(prefs.getString('sells_list') ?? '');
//     notifyListeners();
//   }

//   void saveSellsList(String productId) async {
//     if (getSellsList().isEmpty) {
//       sellsList = getSellsList();
//       sellsList.add({'product': productId});
//     } else {
//       final listLength = getSellsList().length;
//       bool check = false;
//       for (int i = 0; i < listLength; i++) {
//         if (getSellsList()[i]['product'] == productId) {
//           check = true;
//         }
//       }
//       if (!check) {
//         sellsList = getSellsList();
//         sellsList.add({'product': productId});
//       }
//     }
//     _setListPrefsItems();
//   }

//   void deleteSellsList(String productId) async {
//     late int itemIndex;
//     final listLength = getSellsList().length;
//     for (int i = 0; i < listLength; i++) {
//       if (getSellsList()[i]['product'] == productId) {
//         itemIndex = i;
//       }
//     }
//     sellsList = getSellsList();
//     sellsList.removeAt(itemIndex);
//     _setListPrefsItems();
//   }

//   List getSellsList() {
//     _getListPrefsItems();
//     return _sellsItemList;
//   }

//   bool isItemPresent(String prodId) {
//     final sellsList = getSellsList();
//     for (int i = 0; i < sellsList.length; i++) {
//       if (sellsList[i]['product'] == prodId) {
//         return true;
//       }
//     }
//     return false;
//   }
// }
