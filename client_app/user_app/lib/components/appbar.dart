import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_app/constants.dart';
import 'package:user_app/main.dart';
import 'package:user_app/models/onboarding_model.dart';
import 'package:user_app/provider/cart_provider.dart';
import 'package:user_app/screens/cart.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final cart = Provider.of<CartProvider>(context);
    return AppBar(
      toolbarHeight: 80,
      backgroundColor: kWhiteColor,
      leadingWidth: 72,
      elevation: 0.0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Image.asset(
          splashContents[0].image,
        ),
      ),
      title: Text(
        'Brikshya',
        style: kAppName.copyWith(
          color: kMediumGreenColor,
          fontWeight: size.width >= 400 ? FontWeight.w600 : FontWeight.w500,
          fontFamily: 'RedHatDisplay',
          fontSize: 24,
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Badge(
              badgeColor: kOrangeColor,
              padding: const EdgeInsets.all(7),
              badgeContent: const Text(
                '1',
                style: TextStyle(
                  color: kWhiteColor,
                ),
              ),
              child: IconButton(
                icon: const Icon(Icons.favorite_border_rounded),
                color: kLightGreenColor,
                iconSize: 32,
                onPressed: () {},
              ),
            ),
            Badge(
              badgeColor: kOrangeColor,
              padding: const EdgeInsets.all(7),
              badgeContent:
                  Consumer<CartProvider>(builder: (context, value, child) {
                return Text(
                  value.getCartItemCount().toString(),
                  style: const TextStyle(
                    color: kWhiteColor,
                  ),
                );
              }),
              child: IconButton(
                icon: const Icon(Icons.add_shopping_cart_rounded),
                color: kLightGreenColor,
                iconSize: 32,
                onPressed: () {
                  navigatorKey.currentState!.pushNamed(CartScreen.id);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: IconButton(
                icon: const Icon(Icons.search_rounded),
                color: kLightGreenColor,
                iconSize: 32,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }
}
