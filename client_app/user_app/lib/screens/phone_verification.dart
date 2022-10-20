import 'package:user_app/custom_components/custom_button.dart';
import 'package:user_app/custom_components/snack_bar.dart';
import 'package:user_app/custom_components/waiting_dialog.dart';
import 'package:user_app/screens/home.dart';
import 'package:user_app/screens/signin.dart';
import 'package:user_app/services/auth.dart';
import 'package:user_app/services/storage.dart';
import '../constants.dart';
import 'package:user_app/main.dart';
import 'package:user_app/services/otp_services.dart';
import 'package:user_app/provider/phone_verification_state.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class PhoneVerification extends StatefulWidget {
  static const String id = '/phoneverification';
  final Map<String, dynamic>? args;

  const PhoneVerification({this.args, Key? key}) : super(key: key);

  @override
  State<PhoneVerification> createState() => _PhoneVerificationState();
}

class _PhoneVerificationState extends State<PhoneVerification> {
  @override
  void initState() {
    super.initState();
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    // ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        foregroundColor: kDarkGreenColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10.0,
            left: 30.0,
            right: 30.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "images/logo.png",
                height: 150,
                width: 150,
              ),
              const SizedBox(
                height: 40.0,
              ),
              const Text(
                "Verify Mobile Number",
                style: TextStyle(
                  color: kDarkGreenColor,
                  fontSize: 20.0,
                  fontFamily: ubuntu,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Text(
                "OTP sent to +977-${widget.args!["phoneNumber"]}",
                style: const TextStyle(
                  color: kDarkGreenColor,
                  fontSize: 16.0,
                  fontFamily: ubuntu,
                  wordSpacing: 1.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              const Text(
                "Please enter the OTP you just received.",
                style: TextStyle(
                  color: kDarkGreenColor,
                  fontSize: 14.0,
                  fontFamily: ubuntu,
                  wordSpacing: 1.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              getPinPut(),
              Provider.of<PhoneVerificationSate>(context, listen: true).error
                  ? const SizedBox(
                      height: 10.0,
                    )
                  : Container(),
              Provider.of<PhoneVerificationSate>(context, listen: true).error
                  ? Provider.of<PhoneVerificationSate>(context, listen: false)
                      .errorMessage
                  : const SizedBox(
                      height: 5.0,
                    ),
              const SizedBox(
                height: 50.0,
              ),
              CustomButton(
                onPressed: () async {
                  final userPin =
                      Provider.of<PhoneVerificationSate>(context, listen: false)
                          .pin;
                  if (userPin == "") {
                    Provider.of<PhoneVerificationSate>(context, listen: false)
                        .onError("Required");
                  } else if (userPin.length != 6 ||
                      double.tryParse(userPin) == null) {
                    Provider.of<PhoneVerificationSate>(context, listen: false)
                        .onError("Invalid pin");
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) =>
                          const WaitingDialog(title: "Autheticating"),
                    );
                    final body = {
                      "phoneNumber": widget.args!["phoneNumber"],
                      "code": Provider.of<PhoneVerificationSate>(context,
                              listen: false)
                          .pin,
                      "sid": widget.args!["sid"],
                    };
                    final result = await OtpServices.verifyOtp(body);
                    if (result.isEmpty) {
                      navigatorKey.currentState!.pop();
                      Provider.of<PhoneVerificationSate>(context, listen: false)
                          .onError("Incorrect pin");
                    } else {
                      if (widget.args!["origin"] == "signup") {
                        navigatorKey.currentState!.pop();
                        showSnackBar(
                            context, "Phone number verified", kLightGreenColor);
                        final signupBody = {
                          "phoneNumber": widget.args!["phoneNumber"],
                          "name": widget.args!["name"],
                          "password": widget.args!["password"],
                        };
                        final signUpresult =
                            await Authentication.signUp(signupBody);
                        if (signUpresult! ~/ 100 == 2) {
                          navigatorKey.currentState!.pop();
                          navigatorKey.currentState!.popAndPushNamed(Signin.id);
                          showSnackBar(context, "Account successfully created",
                              Colors.green);
                        } else if (signUpresult ~/ 100 == 4) {
                          navigatorKey.currentState!.pop();
                          navigatorKey.currentState!.popAndPushNamed(Signin.id);
                          showSnackBar(
                              context, "User already exists", kLightRedColor);
                        } else {
                          navigatorKey.currentState!.pop();
                          navigatorKey.currentState!.popAndPushNamed(Signin.id);
                          showSnackBar(context, "Account could not be created",
                              kLightRedColor);
                        }
                      }
                      if (widget.args!["origin"] == "changephone") {
                        navigatorKey.currentState!.pop();
                        showSnackBar(
                            context, "Phone number verified", kLightGreenColor);
                        final phoneBody = {
                          "phoneNumber": widget.args!["newPhoneNumber"],
                          "newPhoneNumber": widget.args!["phoneNumber"],
                          "password": widget.args!["password"],
                        };
                        final phoneResult =
                            await Authentication.changePhoneNumber(phoneBody);
                        if (phoneResult! ~/ 100 == 2) {
                          navigatorKey.currentState!.pop();
                          await Storage.removeToken();
                          navigatorKey.currentState!.popAndPushNamed(Signin.id);
                          showSnackBar(
                              context,
                              "Phone number Changed successfully!",
                              Colors.green);
                        } else if (phoneResult ~/ 100 == 4) {
                          navigatorKey.currentState!.pop();

                          showSnackBar(
                              context,
                              "Invalid phone number or password",
                              kLightRedColor);
                        } else {
                          navigatorKey.currentState!.pop();
                          navigatorKey.currentState!.popAndPushNamed(Home.id);
                          showSnackBar(
                              context,
                              "Something went wrong, try again!",
                              kLightRedColor);
                        }
                      }
                      if (widget.args!['origin'] == "changepassword") {
                        navigatorKey.currentState!.pop();
                        showSnackBar(
                            context, "Phone number verified", kLightGreenColor);
                        final passBody = {
                          "phoneNumber": widget.args!["phoneNumber"],
                          "newPassword": widget.args!["newPassword"],
                        };
                        final passResult =
                            await Authentication.changePassword(passBody);
                        if (passResult! ~/ 100 == 2) {
                          navigatorKey.currentState!.pop();
                          await Storage.removeToken();
                          navigatorKey.currentState!.popAndPushNamed(Signin.id);
                          showSnackBar(context,
                              "Password Changed successfully!", Colors.green);
                        } else if (passResult ~/ 100 == 4) {
                          navigatorKey.currentState!.pop();
                          showSnackBar(
                              context,
                              "Invalid phone number or password",
                              kLightRedColor);
                        } else {
                          navigatorKey.currentState!.pop();
                          navigatorKey.currentState!.popAndPushNamed(Home.id);
                          showSnackBar(
                              context,
                              "Something went wrong, try again!",
                              kLightRedColor);
                        }
                      }
                    }
                  }
                },
                width: double.infinity,
                buttonColor: kDarkGreenColor,
                borderRadius: 10.0,
                buttonContent: Text(
                  "VERIFY",
                  style: kButtonContentTextStyle.copyWith(
                    color: kWhiteColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getPinPut() {
    final defaultPinTheme =
        Provider.of<PhoneVerificationSate>(context, listen: true)
            .defaultPinTheme;

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(
        color: kDarkGreenColor,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(8),
    );

    final errorPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(
        color: kLightRedColor,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: kWhiteColor,
      ),
    );

    return Pinput(
      length: 6,
      onTap: () {
        Provider.of<PhoneVerificationSate>(context, listen: false).reset();
      },
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: submittedPinTheme,
      errorPinTheme: errorPinTheme,
      keyboardType: TextInputType.number,
      useNativeKeyboard: true,
      pinputAutovalidateMode: PinputAutovalidateMode.disabled,
      closeKeyboardWhenCompleted: true,
      onChanged: (value) {
        Provider.of<PhoneVerificationSate>(context, listen: false).pin = value;
      },
      showCursor: false,
    );
  }
}
