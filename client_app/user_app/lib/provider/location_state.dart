import 'package:flutter/cupertino.dart';
import 'package:user_app/services/location.dart';

class LocationState extends ChangeNotifier {
  bool _isLocationEnabled = false;

  bool get isLocationEnabled => _isLocationEnabled;

  void checkState() async {
    _isLocationEnabled = await Location.locationServiceEnabled();
  }

  void changeState(bool newVal) {
    _isLocationEnabled = newVal;
    notifyListeners();
  }
}
