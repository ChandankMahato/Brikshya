import 'package:flutter/cupertino.dart';

class FreeEventState extends ChangeNotifier {
  // ignore: prefer_final_fields
  List _userAttendingEvent = [];
  List get userAttendingEvent => _userAttendingEvent;

  void setUserEventList(List data) {
    _userAttendingEvent = data;
    notifyListeners();
  }

  void addUserEventList(String id) {
    _userAttendingEvent.add(id);
    notifyListeners();
  }

  void removeUserEventList(String id) {
    _userAttendingEvent.remove(id);
    notifyListeners();
  }
}
