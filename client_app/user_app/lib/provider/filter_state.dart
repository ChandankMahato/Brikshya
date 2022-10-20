import 'package:flutter/cupertino.dart';
import 'package:user_app/models/category_model.dart';

class FilterTypeState extends ChangeNotifier {
  Categories filterType = Categories.fromData(
      data: {"_id": "All", "title": "All", "image": "image"});

  changeState(Categories newValue) {
    filterType = newValue;
    notifyListeners();
  }
}
