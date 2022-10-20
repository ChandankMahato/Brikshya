import 'package:flutter/cupertino.dart';

class QuantityControllerState extends ChangeNotifier {
  TextEditingController quantity = TextEditingController(text: "");
  void changeQuantity(String text) {
    quantity.text = text;
    notifyListeners();
  }
}
