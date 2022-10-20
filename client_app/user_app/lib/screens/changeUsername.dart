import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:user_app/constants.dart';
import 'package:user_app/custom_components/custom_button.dart';
import 'package:user_app/custom_components/custom_password_text_field.dart';
import 'package:user_app/custom_components/custom_text_field.dart';
import 'package:user_app/custom_components/snack_bar.dart';
import 'package:user_app/custom_components/waiting_dialog.dart';
import 'package:user_app/main.dart';
import 'package:user_app/screens/home.dart';
import 'package:user_app/screens/signin.dart';
import 'package:user_app/services/auth.dart';
import 'package:user_app/services/storage.dart';

class ChangeUsername extends StatefulWidget {
  const ChangeUsername({Key? key}) : super(key: key);

  static const String id = "/changeusername";

  @override
  State<ChangeUsername> createState() => _ChangeUsernameState();
}

class _ChangeUsernameState extends State<ChangeUsername> {
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
                    height: size.height * 0.07,
                  ),
                  Image.asset(
                    "images/logo.png",
                    height: 100,
                    width: 100,
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Text(
                    "CHANGE USERNAME",
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
                            "NEW USERNAME",
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
                          height: size.height * 0.05,
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

                              // final otpResult = await OtpServices.sendOtp({
                              //   "phoneNumber":
                              //       phoneNumberController.text.trim()
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
                              //       "origin": "changeusername",
                              //       "password":
                              //           passwordController.text.trim(),
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
                              final body = {
                                "userName": usernameController.text.trim(),
                                "phoneNumber":
                                    phoneNumberController.text.trim(),
                                "password": passwordController.text.trim(),
                              };
                              final result =
                                  await Authentication.changeUserName(body);
                              if (result! ~/ 100 == 2) {
                                navigatorKey.currentState!.pop();
                                await Storage.removeToken();
                                navigatorKey.currentState!
                                    .popAndPushNamed(Signin.id);
                                showSnackBar(
                                    context,
                                    "Username changed successfully!",
                                    Colors.green);
                              } else if (result ~/ 100 == 4) {
                                navigatorKey.currentState!.pop();
                                showSnackBar(
                                    context,
                                    "Invalid phone number or password",
                                    kLightRedColor);
                              } else {
                                navigatorKey.currentState!.pop();
                                navigatorKey.currentState!
                                    .popAndPushNamed(Home.id);
                                showSnackBar(
                                    context,
                                    "Something went wrong, try again!",
                                    Colors.red);
                              }
                            }
                          },
                          buttonContent: const Text(
                            "UPDATE USERNAME",
                            style: kButtonContentTextStyle,
                          ),
                          width: size.width * 0.75,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
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
