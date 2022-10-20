import 'package:flutter/cupertino.dart';

class LoggedInState extends ChangeNotifier {
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  void changeState(bool newVal) {
    _isLoggedIn = newVal;
    notifyListeners();
  }
}
