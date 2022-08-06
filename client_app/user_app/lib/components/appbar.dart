import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:user_app/constants.dart';
import 'package:user_app/models/onboarding_content.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          fontWeight: FontWeight.w600,
          fontFamily: 'RedHatDisplay',
          fontSize: 24,
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: IconButton(
                    icon: const Icon(Icons.favorite_border_rounded),
                    color: kGreyDarkColor,
                    iconSize: 32,
                    onPressed: () {},
                  ),
                ),
                Badge(
                  badgeColor: kOrangeColor,
                  padding: EdgeInsets.all(7),
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
              ],
            ),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: IconButton(
                    icon: const Icon(Icons.add_shopping_cart_rounded),
                    color: kGreyDarkColor,
                    iconSize: 32,
                    onPressed: () {},
                  ),
                ),
                Badge(
                  badgeColor: kOrangeColor,
                  padding: EdgeInsets.all(7),
                  badgeContent: const Text(
                    '3',
                    style: TextStyle(
                      color: kWhiteColor,
                    ),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.add_shopping_cart_rounded),
                    color: kLightGreenColor,
                    iconSize: 32,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: IconButton(
                      icon: const Icon(Icons.search_rounded),
                      color: kGreyDarkColor,
                      iconSize: 32,
                      onPressed: () {},
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.search_rounded),
                    color: kLightGreenColor,
                    iconSize: 32,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
