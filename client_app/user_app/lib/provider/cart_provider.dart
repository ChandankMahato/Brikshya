import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_app/models/cart_model.dart';

class CartProvider with ChangeNotifier {
  String _updatedDate = '';
  String get updatedDate => _updatedDate;

  double _totalPrice = 0.0;
  double get totalPrice => _totalPrice;

  List cartList = [];
  List _cartItemList = [];
  List get cartItemList => _cartItemList;

  void _setPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setDouble('total_price', _totalPrice);
    prefs.setString('updatedAt', DateTime.now().toString());
    notifyListeners();
  }

  void _getPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _totalPrice = prefs.getDouble('total_price') ?? 0;
    _updatedDate = prefs.getString('updatedAt') ?? '';
    notifyListeners();
  }

  void _setListPrefsItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('cart_item_list', jsonEncode(cartList));
    notifyListeners();
  }

  void _getListPrefsItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _cartItemList = jsonDecode(prefs.getString('cart_item_list') ?? '');
    notifyListeners();
  }

  void saveCartList(
    String product,
    int quantity,
  ) {
    cartList = getCartList();
    cartList.add({'product': product, 'quantity': quantity});
    _setListPrefsItems();
  }

  void replaceCartList(List<dynamic> userCartList) {
    cartList = userCartList;
    _setListPrefsItems();
  }

  void updateCartList(
    String product,
    int quantity,
  ) {
    late int itemIndex;
    final cartLength = getCartList().length;
    for (int i = 0; i < cartLength; i++) {
      final item = Cart.fromData(data: getCartList()[i]);
      if (item.product == product) {
        itemIndex = i;
      }
    }
    cartList = getCartList();
    cartList.removeAt(itemIndex);
    cartList.insert(itemIndex, {'product': product, 'quantity': quantity});
    _setListPrefsItems();
  }

  void deleteCartList(
    String prodId,
  ) {
    late int itemIndex;
    for (int i = 0; i < getCartList().length; i++) {
      if (getCartList()[i]['product'] == prodId) {
        itemIndex = i;
      }
    }
    cartList = getCartList();
    cartList.removeAt(itemIndex);
    _setListPrefsItems();
  }

  void addTotalPrice(double productPrice) {
    _totalPrice = _totalPrice + productPrice;
    _setPrefItems();
    notifyListeners();
  }

  void removeTotalPrice(double productPrice) {
    _totalPrice = _totalPrice - productPrice;
    _setPrefItems();
    notifyListeners();
  }

  bool isItemPresent(String prodId) {
    for (int i = 0; i < getCartList().length; i++) {
      if (getCartList()[i]['product'] == prodId) {
        return true;
      }
    }
    return false;
  }

  List getCartList() {
    _getListPrefsItems();
    return _cartItemList;
  }

  double getTotalPrice() {
    _getPrefItems();
    return _totalPrice;
  }

  void resetCart() {
    cartList = [];
    _totalPrice = 0.0;
    _setPrefItems();
    _setListPrefsItems();
  }
}
