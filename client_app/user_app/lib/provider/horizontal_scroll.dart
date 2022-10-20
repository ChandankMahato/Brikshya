import 'package:flutter/cupertino.dart';

class ScrollState extends ChangeNotifier {
  //category
  int _currentIndex = 0;
  int _listLength = 6;
  bool _isLast = false;

  get currentIndex => _currentIndex;
  get listLength => _listLength;
  get isLast => _isLast;

  void changeCurrentIndex(int value) {
    _currentIndex = value;
    notifyListeners();
  }

  void changeListLength(int length) {
    _listLength = length;
    notifyListeners();
  }

  void changeState(bool newValue) {
    _isLast = newValue;
  }

  //popular
  int _popularCurrentIndex = 0;
  int _popularListLength = 5;
  bool _isLastPopular = false;

  get popularCurrentIndex => _popularCurrentIndex;
  get popularListLength => _popularListLength;
  get isLastPopular => _isLastPopular;

  void changePopularCurrentIndex(int value) {
    _popularCurrentIndex = value;
    notifyListeners();
  }

  void changePopularListLength(int length) {
    _popularListLength = length;
    notifyListeners();
  }

  void changePopularState(bool newValue) {
    _isLastPopular = newValue;
  }
}
