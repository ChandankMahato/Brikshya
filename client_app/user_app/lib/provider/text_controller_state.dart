import 'package:flutter/cupertino.dart';

class JobTextControllerState extends ChangeNotifier {
  TextEditingController userAddressController = TextEditingController(text: '');
  TextEditingController userEmailController = TextEditingController(text: '');
  TextEditingController userPhoneController = TextEditingController(text: '');
  TextEditingController userAgeController = TextEditingController(text: '');

  void changeAddress(String text) {
    userAddressController.text = text;
    notifyListeners();
  }

  void changeEmail(String text) {
    userEmailController.text = text;
    notifyListeners();
  }

  void changeAge(String text) {
    userAgeController.text = text;
    notifyListeners();
  }

  void changePhone(String text) {
    userPhoneController.text = text;
    notifyListeners();
  }
}
