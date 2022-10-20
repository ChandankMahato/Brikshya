import 'package:admin_app/components/category.dart';
import 'package:admin_app/components/drawer.dart';
import 'package:admin_app/components/product.dart';
import 'package:admin_app/constants/constants.dart';
import 'package:admin_app/custom_components/customText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Products extends StatelessWidget {
  static const id = '/products';
  const Products({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              text: 'Products',
              fontSize: 24,
              myColor: kDarkGreenColor,
              fontFamily: 'RedHatDisplay',
            ),
          ),
        ),
      ),
      drawer: const AppDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              CategorysWidget(),
              ProductWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
