import 'package:flutter/material.dart';
import 'package:user_app/constants.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final IconData icon;
  final bool isEmail;
  final bool isPhoneNumber;
  final bool isTransactionPin;
  final bool isAmount;
  final bool canBeEdited;
  final bool isPassword;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.icon,
    this.isEmail = false,
    this.isPhoneNumber = false,
    this.isTransactionPin = false,
    this.isAmount = false,
    this.canBeEdited = true,
    this.isPassword = false,
  }) : super(key: key);

  String? validate(String? username) {
    if (username!.trim().isEmpty) {
      return "Required";
    } else {
      return null;
    }
  }

  String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return "Required";
    } else if (value.length < 8) {
      return "Password must be atleast 8 characters";
    } else {
      return null;
    }
  }

  bool isNumeric(String? s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  String? validatePhoneNumber(String? value) {
    if (value!.trim().isEmpty) {
      return "Required";
    } else if (value.trim().length != 10 || !isNumeric(value.trim())) {
      return "Invalid phone number";
    } else {
      return null;
    }
  }

  String? validatePin(String? value) {
    if (value!.trim().isEmpty) {
      return "Required";
    } else if (value.trim().length != 4 || !isNumeric(value.trim())) {
      return "Invalid transaction pin";
    } else {
      return null;
    }
  }

  String? validateAmount(String? value) {
    if (value!.trim().isEmpty) {
      return "Required";
    } else if (!isNumeric(value.trim())) {
      return "Invalid Amount";
    } else {
      return null;
    }
  }

  String? validateEmail(String? email) {
    if (email!.trim().isEmpty) {
      return "Required";
    } else if (!RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
        .hasMatch(email.trim())) {
      return "Email not valid";
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: isEmail
          ? validateEmail
          : isPhoneNumber
              ? validatePhoneNumber
              : isTransactionPin
                  ? validatePin
                  : isAmount
                      ? validateAmount
                      : isPassword
                          ? validatePassword
                          : validate,
      cursorColor: kLightGreenColor,
      enabled: canBeEdited,
      keyboardType: isPhoneNumber || isTransactionPin || isAmount
          ? TextInputType.number
          : TextInputType.emailAddress,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(
          top: 15.0,
          bottom: 15.0,
          left: 8.0,
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 5.0,
          ),
          child: Icon(
            icon,
            color: kDarkGreenColor,
          ),
        ),
        // label: Text(
        //   labelText,
        // ),
        labelStyle: kTextFieldLabelStyle.copyWith(
          // color: kLightRedColor,
          color: Colors.black,
        ),
        errorStyle: const TextStyle(
          color: kLightRedColor,
          fontSize: 13.0,
          fontFamily: ubuntu,
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: kLightRedColor,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: kLightRedColor,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      style: kTextFieldTextStyle.copyWith(
        // color: kTextFieldTextStyle.color,
        color: Colors.black,
      ),
    );
  }
}
