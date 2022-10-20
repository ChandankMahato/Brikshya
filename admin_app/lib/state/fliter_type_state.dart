import 'package:admin_app/models/category_model.dart';
import 'package:flutter/cupertino.dart';

class FilterTypeState extends ChangeNotifier {
  Category filterType = Category.fromData(data: {"_id": "All", "title": "All"});

  changeState(Category newValue) {
    filterType = newValue;
    notifyListeners();
  }
}
