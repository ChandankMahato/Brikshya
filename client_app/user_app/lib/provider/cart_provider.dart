import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_app/Database/db_helper.dart';
import 'package:user_app/models/cart_model.dart';

class CartProvider with ChangeNotifier {
  DBHelper db = DBHelper();

  int _cartItemCount = 0;
  int get cartItemCount => _cartItemCount;

  double _totalPrice = 0.0;
  double get totalPrice => _totalPrice;

  late Future<List<Cart>> _cart;

  Future<List<Cart>> get cart => _cart;

  Future<List<Cart>> getData() async {
    _cart = db.getCartList();
    return _cart;
  }

  void _setPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('cart_item', _cartItemCount);
    prefs.setDouble('total_price', _totalPrice);
    notifyListeners();
  }

  void _getPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _cartItemCount = prefs.getInt('cart_item') ?? 0;
    _totalPrice = prefs.getDouble('total_price') ?? 0;
    notifyListeners();
  }

  void addCartItemCount() {
    _cartItemCount++;
    _setPrefItems();
    notifyListeners();
  }

  void removeCartItemCount() {
    _cartItemCount--;
    _setPrefItems();
    notifyListeners();
  }

  int getCartItemCount() {
    _getPrefItems();
    return _cartItemCount;
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

  double getTotalPrice() {
    _getPrefItems();
    return _totalPrice;
  }
}
