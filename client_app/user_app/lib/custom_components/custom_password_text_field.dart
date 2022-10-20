import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_app/constants.dart';
import '../provider/password_eye.dart';

class CustomPasswordField extends StatelessWidget {
  final TextEditingController controller;
  final IconData icon;

  const CustomPasswordField({
    Key? key,
    required this.controller,
    required this.icon,
  }) : super(key: key);

  String? validatePassword(String? password) {
    if (password!.isEmpty) {
      return "Required";
    } else if (password.length < 8) {
      return "Must be at least 8 characters";
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PasswordEyeState>(builder: (context, eyeState, _) {
      return TextFormField(
        controller: controller,
        validator: validatePassword,
        cursorColor: kDarkGreenColor,
        keyboardType: TextInputType.emailAddress,
        obscureText:
            Provider.of<PasswordEyeState>(context, listen: false).seePassword,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(
            top: 15.0,
            bottom: 15.0,
            left: 8.0,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(
              icon,
              color: kDarkGreenColor,
            ),
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              Provider.of<PasswordEyeState>(context, listen: false)
                  .changeState();
            },
            child: eyeState.seePassword
                ? const Icon(
                    EvaIcons.eyeOff,
                    color: kDarkGreenColor,
                  )
                : const Icon(
                    EvaIcons.eye,
                    color: kDarkGreenColor,
                  ),
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
    });
  }
}
