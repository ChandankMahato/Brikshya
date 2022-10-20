import 'dart:convert';

import 'package:provider/provider.dart';
import 'package:user_app/custom_components/snack_bar.dart';
import 'package:user_app/custom_components/waiting_dialog.dart';
import 'package:user_app/provider/cart_provider.dart';
import 'package:user_app/provider/favorite_provider.dart';
import 'package:user_app/provider/logged_in_state.dart';
import 'package:user_app/screens/changePassword.dart';
import 'package:user_app/services/cart.dart';
import 'package:user_app/services/favourite.dart';
import 'package:user_app/services/storage.dart';

import '../services/auth.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import '../custom_components/custom_button.dart';
import '../custom_components/custom_password_text_field.dart';
import '../custom_components/custom_text_field.dart';
import '../main.dart';
import '../screens/signup.dart';
import '../constants.dart';

class Signin extends StatefulWidget {
  static const String id = "/signin";
  const Signin({Key? key}) : super(key: key);

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  late TextEditingController phoneNumberController;

  late TextEditingController passwordController;

  late GlobalKey<FormState> globalKey;

  @override
  void initState() {
    phoneNumberController = TextEditingController();
    passwordController = TextEditingController();
    globalKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    phoneNumberController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final favorite = Provider.of<FavoriteProvider>(context, listen: false);
    final cart = Provider.of<CartProvider>(context, listen: false);
    return Scaffold(
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
                    height: size.height * 0.08,
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
                    "LOG IN",
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
                        CustomPasswordField(
                          controller: passwordController,
                          icon: EvaIcons.lockOutline,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                navigatorKey.currentState!
                                    .popAndPushNamed(ChangePassword.id);
                              },
                              child: Container(
                                color: kWhiteColor,
                                width: 150,
                                height: 40,
                                alignment: Alignment.center,
                                child: Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: kDarkGreenColor.withOpacity(0.8),
                                    fontFamily: ubuntu,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.05,
                        ),
                        CustomButton(
                          borderRadius: 20.0,
                          onPressed: () async {
                            if (globalKey.currentState!.validate()) {
                              showDialog(
                                context: context,
                                builder: (context) => const WaitingDialog(
                                    title: "Authenticating"),
                              );

                              final body = {
                                "phoneNumber":
                                    phoneNumberController.text.trim(),
                                "password": passwordController.text.trim(),
                              };
                              // try {
                              //   userPosition =
                              //       await Location.determinePosition();
                              // } catch (ex) {
                              //   showSnackBar(
                              //     context,
                              //     ex.toString(),
                              //     kLightRedColor,
                              //   );
                              // }
                              final result = await Authentication.signIn(body);
                              if (result! ~/ 100 != 2) {
                                navigatorKey.currentState!.pop();
                                return showSnackBar(
                                  context,
                                  "Invalid username or password.",
                                  kLightRedColor,
                                );
                              }
                              if (result ~/ 100 == 2) {
                                Provider.of<LoggedInState>(context,
                                        listen: false)
                                    .changeState(true);
                                navigatorKey.currentState!.pop();
                                navigatorKey.currentState!.pop();
                                showSnackBar(
                                  context,
                                  "Login successful",
                                  Colors.green,
                                );
                                String? data = await Storage.getToken();
                                if (data != null) {
                                  //resolving favourites
                                  final favourites = favorite.getFavoriteList();
                                  final updatedAt = favorite.updatedDate;
                                  final body = {
                                    'favourites': favourites,
                                    'updatedAt': updatedAt
                                  };
                                  List<dynamic> userFavoriteList =
                                      await FavouriteDatabase.resolveFavourite(
                                          body);
                                  if (userFavoriteList.isNotEmpty) {
                                    favorite
                                        .replaceFavoriteList(userFavoriteList);
                                  }
                                  final carts = cart.getCartList();
                                  final cartUpdatedAt = cart.updatedDate;
                                  final totalPrice = cart.getTotalPrice();
                                  final cartBody = {
                                    'items': carts,
                                    'updatedAt': cartUpdatedAt,
                                    'totalPrice': totalPrice
                                  };
                                  List<dynamic> userCartList =
                                      await CartDatabase.resolveCart(cartBody);
                                  if (userCartList.isNotEmpty) {
                                    final cartTotalPrice =
                                        await CartDatabase.cartTotalPrice();
                                    cart.replaceCartList(userCartList);
                                    cart.removeTotalPrice(cart.getTotalPrice());
                                    cart.addTotalPrice(double.parse(
                                        cartTotalPrice.toString()));
                                  }
                                }
                              } else if (result ~/ 100 == 4) {
                                navigatorKey.currentState!.pop();
                                showSnackBar(
                                  context,
                                  "Invalid username or password.",
                                  kLightRedColor,
                                );
                              } else {
                                navigatorKey.currentState!.pop();
                                showSnackBar(
                                  context,
                                  "Couldnot login, please try again later.",
                                  kLightRedColor,
                                );
                              }
                            }
                          },
                          buttonContent: const Text(
                            "LOG IN",
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account ?  ',
                        style: kTextFieldLabelStyle.copyWith(
                          fontSize: 16.0,
                          fontFamily: ubuntu,
                          color: kDarkGreenColor,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          navigatorKey.currentState!.popAndPushNamed(Signup.id);
                        },
                        child: Container(
                          color: kWhiteColor,
                          width: 80,
                          height: 50,
                          alignment: Alignment.center,
                          child: Text(
                            'Register',
                            style: kTextFieldLabelStyle.copyWith(
                              fontFamily: ubuntu,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                              color: kOrangeColor,
                            ),
                          ),
                        ),
                      ),
                    ],
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
