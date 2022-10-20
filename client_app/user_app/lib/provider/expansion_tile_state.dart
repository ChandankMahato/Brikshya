import 'package:flutter/cupertino.dart';

class ExpandTileState extends ChangeNotifier {
  bool _isExpanded = false;

  bool get isExpanded => _isExpanded;

  void changeState(bool newVal) {
    _isExpanded = newVal;
    notifyListeners();
  }
}
