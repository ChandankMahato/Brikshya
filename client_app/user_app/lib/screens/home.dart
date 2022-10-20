import 'dart:math';

import 'package:badges/badges.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:user_app/components/footer.dart';
import 'package:user_app/custom_components/customText.dart';
import 'package:user_app/components/banner.dart';
import 'package:user_app/components/drawer.dart';
import 'package:user_app/components/popular.dart';
import 'package:user_app/components/product.dart';
import 'package:user_app/constants.dart';
import 'package:user_app/custom_components/custom_widget.dart';
import 'package:user_app/custom_components/snack_bar.dart';
import 'package:user_app/custom_components/waiting_dialog.dart';
import 'package:user_app/main.dart';
import 'package:user_app/models/category_model.dart';
import 'package:user_app/provider/cart_provider.dart';
import 'package:user_app/provider/favorite_provider.dart';
import 'package:user_app/provider/filter_state.dart';
import 'package:user_app/provider/horizontal_scroll.dart';
import 'package:user_app/screens/cart.dart';
import 'package:user_app/screens/favorite.dart';
import 'package:user_app/services/product.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  static const String id = "/home";

  @override
  State<Home> createState() => _HomeState();
}

List favProductDetailsList = [];
List cartProductDetailsList = [];

class _HomeState extends State<Home> {
  final scrollController = ItemScrollController();
  void scrollToIndex(int index) {
    scrollController.scrollTo(
      index: index,
      duration: const Duration(seconds: 1),
    );
  }

  final ScrollController _scrollToProductController = ScrollController();

  void _scrollToProduct() {
    _scrollToProductController.animateTo(400,
        duration: const Duration(seconds: 1), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final scrollState = Provider.of<ScrollState>(context, listen: false);
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
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
            onTap: () {
              showSnackBar(
                context,
                "Already in Home",
                Colors.red,
              );
            },
            child: const CustomTextStyleOne(
              text: 'Brikshya',
              fontSize: 24,
              myColor: kDarkGreenColor,
              fontFamily: redhat,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Badge(
                    badgeColor: kOrangeColor,
                    padding: const EdgeInsets.all(7),
                    badgeContent: Consumer<FavoriteProvider>(
                      builder: (context, value, child) {
                        return Text(
                          value.getFavoriteList().length.toString(),
                          style: const TextStyle(
                            color: kWhiteColor,
                          ),
                        );
                      },
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.favorite_border_rounded),
                      color: kLightGreenColor,
                      iconSize: 32,
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (context) =>
                              const WaitingDialog(title: "Fetching"),
                        );
                        favProductDetailsList =
                            await ProductDatabase.multipleProductDetails(
                                Provider.of<FavoriteProvider>(context,
                                        listen: false)
                                    .getFavoriteList());
                        if (favProductDetailsList.isNotEmpty) {
                          navigatorKey.currentState!.pop();
                          navigatorKey.currentState!
                              .pushNamed(FavoriteScreen.id);
                        } else {
                          favProductDetailsList = [];
                          navigatorKey.currentState!.pop();
                          if (Provider.of<FavoriteProvider>(context,
                                  listen: false)
                              .getFavoriteList()
                              .isEmpty) {
                            showSnackBar(
                              context,
                              "Favourite is Empty! Add Item",
                              Colors.red,
                            );
                          } else {
                            showSnackBar(
                              context,
                              "Couldnot fetch Favourite item, try again",
                              Colors.red,
                            );
                          }
                        }
                      },
                    ),
                  ),
                  Badge(
                    badgeColor: kOrangeColor,
                    padding: const EdgeInsets.all(7),
                    badgeContent: Consumer<CartProvider>(
                        builder: (context, value, child) {
                      return Text(
                        value.getCartList().length.toString(),
                        style: const TextStyle(
                          color: kWhiteColor,
                        ),
                      );
                    }),
                    child: IconButton(
                      icon: const Icon(Icons.add_shopping_cart_rounded),
                      color: kLightGreenColor,
                      iconSize: 32,
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (context) =>
                              const WaitingDialog(title: "Fetching"),
                        );
                        cartProductDetailsList =
                            await ProductDatabase.multipleProductDetails(
                                Provider.of<CartProvider>(context,
                                        listen: false)
                                    .getCartList());

                        if (cartProductDetailsList.isNotEmpty) {
                          navigatorKey.currentState!.pop();
                          navigatorKey.currentState!.pushNamed(CartScreen.id);
                        } else {
                          cartProductDetailsList = [];
                          navigatorKey.currentState!.pop();
                          if (Provider.of<CartProvider>(context, listen: false)
                              .getCartList()
                              .isEmpty) {
                            showSnackBar(
                              context,
                              "Cart is Empty! Add Item",
                              Colors.red,
                            );
                          } else {
                            showSnackBar(
                              context,
                              "Couldnot fetch Cart item, try again",
                              Colors.red,
                            );
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      drawer: const AppDrawer(),
      body: SafeArea(
        child: RefreshIndicator(
          color: kLightGreenColor,
          onRefresh: () async {
            setState(() {});
            await Future.delayed(const Duration(seconds: 4));
          },
          child: SingleChildScrollView(
            controller: _scrollToProductController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomBanner(),
                RefreshIndicator(
                  onRefresh: () async {
                    setState(() {});
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                          top: 24,
                        ),
                        child: Row(
                          mainAxisAlignment: size.width > 850
                              ? MainAxisAlignment.center
                              : MainAxisAlignment.spaceBetween,
                          children: [
                            const CustomTextStyleOne(
                              text: 'Category',
                              fontSize: 24,
                              weight: FontWeight.w600,
                              myColor: kDarkGreenColor,
                              fontFamily: redhat,
                            ),
                            size.width < 850
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                      left: 8.0,
                                      top: 8.0,
                                      bottom: 8.0,
                                      right: 12.0,
                                    ),
                                    child: IconButton(
                                      icon: Provider.of<ScrollState>(context,
                                                  listen: true)
                                              .isLast
                                          ? Transform.rotate(
                                              angle: 180 * pi / 180,
                                              child: const Icon(
                                                  Icons.forward_sharp),
                                            )
                                          : const Icon(Icons.forward_sharp),
                                      color: kDarkGreenColor,
                                      iconSize: 24,
                                      splashColor:
                                          kLightGreenColor.withOpacity(0.3),
                                      splashRadius: 30.0,
                                      onPressed: () {
                                        if (scrollState.isLast) {
                                          scrollState.changeCurrentIndex(
                                              scrollState.currentIndex - 1);
                                          if (scrollState.currentIndex == 0) {
                                            scrollState.changeState(false);
                                            // setState(() {});
                                          }
                                        } else {
                                          scrollState.changeCurrentIndex(
                                              scrollState.currentIndex + 1);
                                          if (scrollState.currentIndex + 2 ==
                                              scrollState.listLength) {
                                            scrollState.changeState(true);
                                            // setState(() {});
                                          }
                                        }
                                        scrollToIndex(scrollState.currentIndex);
                                      },
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                      FutureBuilder<List>(
                        future: ProductDatabase.getCategories(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return brikshyaLoaderSmall();
                          }
                          if (snapshot.hasError) {
                            const Padding(
                              padding: EdgeInsets.only(bottom: 16.0),
                              child: Text(
                                'Network Error!   ',
                                style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 25,
                                ),
                              ),
                            );
                          }
                          if (snapshot.data!.isEmpty) {
                            return const Center(
                              child: Text(
                                'No categories!',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 25),
                              ),
                            );
                          }
                          final categories = snapshot.data!;
                          scrollState.changeListLength(categories.length);
                          return Padding(
                            padding: const EdgeInsets.only(
                              left: 12.0,
                              right: 12.0,
                            ),
                            child: SizedBox(
                              height: 50,
                              child: ScrollablePositionedList.builder(
                                itemScrollController: scrollController,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: categories.length,
                                itemBuilder: (context, index) {
                                  final category = Categories.fromData(
                                      data: categories[index]);

                                  return Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 8,
                                    ),
                                    height: 48,
                                    child: Row(
                                      children: [
                                        index == 0
                                            ? Container(
                                                margin: const EdgeInsets.only(
                                                  right: 12,
                                                ),
                                                height: 48,
                                                child: InkWell(
                                                  onTap: () {
                                                    Provider.of<FilterTypeState>(
                                                            context,
                                                            listen: false)
                                                        .changeState(
                                                      Categories.fromData(
                                                        data: {
                                                          "_id": "All",
                                                          "title": "All",
                                                          "image": "image"
                                                        },
                                                      ),
                                                    );
                                                    _scrollToProduct();
                                                    setState(() {});
                                                  },
                                                  child: Neumorphic(
                                                    style: NeumorphicStyle(
                                                      border:
                                                          const NeumorphicBorder(
                                                              width: 1),
                                                      depth: -3,
                                                      boxShape:
                                                          NeumorphicBoxShape
                                                              .roundRect(
                                                        BorderRadius.circular(
                                                            15),
                                                      ),
                                                      shadowLightColorEmboss:
                                                          Colors.white,
                                                      shadowDarkColorEmboss:
                                                          const Color.fromARGB(
                                                              255,
                                                              162,
                                                              162,
                                                              162),
                                                      oppositeShadowLightSource:
                                                          false,
                                                      intensity: 1,
                                                      surfaceIntensity: 0.25,
                                                      lightSource:
                                                          LightSource.top,
                                                      color: kWhiteColor,
                                                    ),
                                                    child: Row(
                                                      children: const [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                            right: 12,
                                                            left: 12,
                                                          ),
                                                          child:
                                                              CustomTextStyleOne(
                                                            text: 'All',
                                                            myColor:
                                                                kBlackColor,
                                                            fontFamily: redhat,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        InkWell(
                                          onTap: () {
                                            Provider.of<FilterTypeState>(
                                                    context,
                                                    listen: false)
                                                .changeState(category);
                                            _scrollToProduct();
                                            setState(() {});
                                          },
                                          child: Neumorphic(
                                            style: NeumorphicStyle(
                                              border: const NeumorphicBorder(
                                                  width: 1),
                                              depth: -3,
                                              boxShape:
                                                  NeumorphicBoxShape.roundRect(
                                                BorderRadius.circular(15),
                                              ),
                                              shadowLightColorEmboss:
                                                  Colors.white,
                                              shadowDarkColorEmboss:
                                                  const Color.fromARGB(
                                                      255, 162, 162, 162),
                                              oppositeShadowLightSource: false,
                                              intensity: 1,
                                              surfaceIntensity: 0.25,
                                              lightSource: LightSource.top,
                                              color: kWhiteColor,
                                            ),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(4),
                                                  child: category.image == null
                                                      ? const SizedBox(
                                                          height: 32,
                                                          width: 32,
                                                          child: Icon(
                                                              Icons
                                                                  .image_not_supported,
                                                              size: 24,
                                                              color: Colors
                                                                  .black45),
                                                        )
                                                      : Image.network(
                                                          category.image!,
                                                          height: 32.0,
                                                          width: 32.0,
                                                          errorBuilder:
                                                              (context, error,
                                                                  stackTrace) {
                                                            return const SizedBox(
                                                              height: 32,
                                                              width: 32,
                                                              child: Icon(
                                                                  Icons
                                                                      .image_not_supported,
                                                                  size: 24,
                                                                  color: Colors
                                                                      .black45),
                                                            );
                                                          },
                                                          loadingBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  Widget child,
                                                                  ImageChunkEvent?
                                                                      loadingProgress) {
                                                            if (loadingProgress ==
                                                                null) {
                                                              return child;
                                                            }
                                                            return Center(
                                                              child:
                                                                  CircularProgressIndicator(
                                                                value: loadingProgress
                                                                            .expectedTotalBytes !=
                                                                        null
                                                                    ? loadingProgress
                                                                            .cumulativeBytesLoaded /
                                                                        loadingProgress
                                                                            .expectedTotalBytes!
                                                                    : null,
                                                                valueColor:
                                                                    const AlwaysStoppedAnimation(
                                                                        kDarkGreenColor),
                                                                backgroundColor:
                                                                    kDarkGreenColor
                                                                        .withOpacity(
                                                                            0.5),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    right: 8,
                                                  ),
                                                  child: CustomTextStyleOne(
                                                    text: category.title,
                                                    myColor: kBlackColor,
                                                    fontFamily: redhat,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                RefreshIndicator(
                    onRefresh: () async {
                      setState(() {});
                    },
                    child: PopularWdiget()),
                RefreshIndicator(
                    onRefresh: () async {
                      setState(() {});
                    },
                    child: ProductWidget()),
                const FooterWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
