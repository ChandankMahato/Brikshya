import 'package:admin_app/components/drawer.dart';
import 'package:admin_app/custom_components/customText.dart';
import 'package:flutter/material.dart';
import 'package:admin_app/constants/constants.dart';

class Home extends StatefulWidget {
  static const id = '/home';
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    // Get.put(TextController());
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          centerTitle: true,
          toolbarHeight: 80,
          backgroundColor: kWhiteColor,
          elevation: 0.0,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: kDarkGreenColor,
                  size: 32, // Changing Drawer Icon Size
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
          title: InkWell(
            onTap: () {},
            child: const CustomTextStyleOne(
              text: 'Brikshya',
              fontSize: 24,
              myColor: kDarkGreenColor,
              fontFamily: 'RedHatDisplay',
            ),
          ),
        ),
      ),
      drawer: AppDrawer(),
    );
  }
}
