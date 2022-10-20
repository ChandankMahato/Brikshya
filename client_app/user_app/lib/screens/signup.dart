import 'package:user_app/custom_components/snack_bar.dart';
import 'package:user_app/custom_components/waiting_dialog.dart';
import 'package:user_app/screens/phone_verification.dart';
import 'package:user_app/screens/signin.dart';
import 'package:user_app/services/auth.dart';
import 'package:user_app/services/database.dart';
import '../services/otp_services.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import '../custom_components/custom_button.dart';
import '../custom_components/custom_password_text_field.dart';
import '../custom_components/custom_text_field.dart';
import '../constants.dart';
import '../main.dart';

class Signup extends StatefulWidget {
  static const String id = "/signup";
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  late TextEditingController phoneNumberController;
  late GlobalKey<FormState> globalKey;
  late GlobalKey<ScaffoldState> scaffoldKey;

  @override
  void initState() {
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    phoneNumberController = TextEditingController();
    globalKey = GlobalKey<FormState>();
    scaffoldKey = GlobalKey<ScaffoldState>();
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: kWhiteColor,
      body: Padding(
        padding: const EdgeInsets.only(
          // top: size.height * 0.1,
          left: 25.0,
          right: 25.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Image.asset(
                    "images/logo.png",
                    height: 90,
                    width: 90,
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Text(
                    "CREATE NEW ACCOUNT",
                    textAlign: TextAlign.center,
                    style: kTextFieldLabelStyle.copyWith(
                      fontSize: 20.0,
                      fontFamily: ubuntu,
                      color: kDarkGreenColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: globalKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 10.0,
                          ),
                          child: Text(
                            "USERNAME",
                            textAlign: TextAlign.center,
                            style: kTextFieldLabelStyle.copyWith(
                              color: kLightGreenColor,
                              fontSize: 14.3,
                              fontFamily: ubuntu,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        CustomTextField(
                          controller: usernameController,
                          icon: EvaIcons.personOutline,
                        ),
                        SizedBox(
                          height: size.height * 0.035,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 10.0,
                          ),
                          child: Text(
                            "PHONE NUMBER",
                            textAlign: TextAlign.center,
                            style: kTextFieldLabelStyle.copyWith(
                              color: kLightGreenColor,
                              fontSize: 14.3,
                              fontFamily: ubuntu,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        CustomTextField(
                          controller: phoneNumberController,
                          isPhoneNumber: true,
                          icon: EvaIcons.phoneCallOutline,
                        ),
                        SizedBox(
                          height: size.height * 0.035,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 10.0,
                          ),
                          child: Text(
                            "PASSWORD",
                            textAlign: TextAlign.center,
                            style: kTextFieldLabelStyle.copyWith(
                              fontSize: 14.3,
                              color: kLightGreenColor,
                              fontFamily: ubuntu,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        CustomPasswordField(
                          controller: passwordController,
                          icon: EvaIcons.lockOutline,
                        ),
                        SizedBox(
                          height: size.height * 0.04,
                        ),
                        CustomButton(
                          borderRadius: 15.0,
                          onPressed: () async {
                            if (globalKey.currentState!.validate()) {
                              // showDialog(
                              //   context: context,
                              //   builder: (context) =>
                              //       const WaitingDialog(title: "Autheticating"),
                              // );
                              // final result = await Database.userExists(
                              //     phoneNumberController.text.trim());
                              // if (result! ~/ 100 != 2) {
                              //   navigatorKey.currentState!.pop();
                              //   return showSnackBar(
                              //     context,
                              //     "User already exists",
                              //     Colors.red,
                              //   );
                              // }
                              // final otpResult = await OtpServices.sendOtp({
                              //   "phoneNumber": phoneNumberController.text.trim()
                              // });
                              // if (otpResult.isEmpty) {
                              //   navigatorKey.currentState!.pop();
                              //   showSnackBar(
                              //     context,
                              //     "Verification code couldnot be sent",
                              //     kLightRedColor,
                              //   );
                              // } else {
                              //   navigatorKey.currentState!.pop();
                              //   navigatorKey.currentState!.pushNamed(
                              //     PhoneVerification.id,
                              //     arguments: {
                              //       "origin": "signup",
                              //       "password": passwordController.text.trim(),
                              //       "name": usernameController.text.trim(),
                              //       "phoneNumber":
                              //           phoneNumberController.text.trim(),
                              //       "sid": otpResult["service_sid"]
                              //     },
                              //   );
                              // }

                              showDialog(
                                context: context,
                                builder: (context) => const WaitingDialog(
                                    title: "Authenticating"),
                              );
                              final result = await Database.userExists(
                                  phoneNumberController.text.trim());

                              if (result! ~/ 100 != 2) {
                                navigatorKey.currentState!.pop();
                                return showSnackBar(
                                  context,
                                  "User already exists",
                                  Colors.red,
                                );
                              }
                              final body = {
                                "name": usernameController.text.trim(),
                                "phoneNumber":
                                    phoneNumberController.text.trim(),
                                "password": passwordController.text.trim(),
                              };

                              final signUpresult =
                                  await Authentication.signUp(body);
                              if (signUpresult! ~/ 100 == 2) {
                                navigatorKey.currentState!.pop();
                                navigatorKey.currentState!
                                    .popAndPushNamed(Signin.id);
                                showSnackBar(
                                    context,
                                    "Account successfully created",
                                    Colors.green);
                              } else if (signUpresult ~/ 100 == 4) {
                                navigatorKey.currentState!.pop();
                                navigatorKey.currentState!
                                    .popAndPushNamed(Signin.id);
                                showSnackBar(context, "User already exists",
                                    kLightRedColor);
                              } else {
                                navigatorKey.currentState!.pop();
                                navigatorKey.currentState!
                                    .popAndPushNamed(Signin.id);
                                showSnackBar(
                                    context,
                                    "Account could not be created",
                                    kLightRedColor);
                              }
                            }
                          },
                          buttonContent: const Text(
                            "REGISTER",
                            style: kButtonContentTextStyle,
                          ),
                          width: size.width * 0.75,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?  ',
                        style: kTextFieldLabelStyle.copyWith(
                          fontSize: 16.0,
                          fontFamily: ubuntu,
                          color: kDarkGreenColor,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          navigatorKey.currentState!.popAndPushNamed(Signin.id);
                        },
                        child: Container(
                          color: kWhiteColor,
                          width: 80,
                          height: 50,
                          alignment: Alignment.center,
                          child: Text(
                            'Sign in',
                            style: kTextFieldLabelStyle.copyWith(
                                fontFamily: ubuntu,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                                color: kOrangeColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: InkWell(
                        onTap: () {
                          navigatorKey.currentState!.pop();
                        },
                        child: Container(
                          color: kWhiteColor,
                          width: 60,
                          height: 50,
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.home,
                            color: kLightGreenColor,
                            size: 48,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
