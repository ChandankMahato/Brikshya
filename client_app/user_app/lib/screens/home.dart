import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:user_app/constants.dart';
import 'package:user_app/main.dart';
import 'package:user_app/models/onboarding_content.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  static const String id = "/home";

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        toolbarHeight: 80,
        leadingWidth: 72,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Image.asset(
            onBoardingContents[0].image,
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
          IconButton(
            icon: const Icon(Icons.favorite_border_rounded),
            color: kLightGreenColor,
            iconSize: 32,
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.add_shopping_cart_rounded),
            color: kLightGreenColor,
            iconSize: 32,
            onPressed: () {},
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Neumorphic(
          style: const NeumorphicStyle(
            border: NeumorphicBorder(width: 1),
            depth: -5,
            boxShape: NeumorphicBoxShape.stadium(),
            shadowLightColorEmboss: Colors.white,
            shadowDarkColorEmboss: Color.fromARGB(255, 162, 162, 162),
            oppositeShadowLightSource: false,
            intensity: 10,
            surfaceIntensity: 0.25,
            lightSource: LightSource.top,
          ),
          child: Container(
            height: 48,
            width: (16 * 1.2 * 16 / 2 + 96).toDouble(),
            color: Colors.white,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: SizedBox(
                    height: 32,
                    width: 32,
                    child: Image.asset('images/categorys/cactus.png'),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 24.0),
                  child: Text(
                    'Decorative Plant',
                    style: TextStyle(
                      color: kBlackColor,
                      fontFamily: 'Ubuntu',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
