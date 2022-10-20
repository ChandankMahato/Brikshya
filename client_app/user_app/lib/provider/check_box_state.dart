import 'package:flutter/cupertino.dart';

class CashInHandState extends ChangeNotifier {
  bool _cashOnDelivery = false;

  bool get cashOnDelivery => _cashOnDelivery;

  void changeState(bool newVal) {
    _cashOnDelivery = newVal;
    notifyListeners();
  }
}

class DropDownState extends ChangeNotifier {
  String _jobPost = '';
  String get jobPost => _jobPost;

  void changeJobPost(String newVal) {
    _jobPost = newVal;
    notifyListeners();
  }

  String _jobTime = '';
  String get jobTime => _jobTime;

  void changeJobTime(String newVal) {
    _jobTime = newVal;
    notifyListeners();
  }
}
