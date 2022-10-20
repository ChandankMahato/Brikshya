import 'dart:convert';

import 'package:animations/animations.dart';
import 'package:badges/badges.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:user_app/custom_components/customText.dart';
import 'package:user_app/components/drawer.dart';
import 'package:user_app/constants.dart';
import 'package:user_app/custom_components/snack_bar.dart';
import 'package:user_app/custom_components/waiting_dialog.dart';
import 'package:user_app/main.dart';
import 'package:user_app/models/product_model.dart';
import 'package:user_app/provider/cart_provider.dart';
import 'package:user_app/provider/favorite_provider.dart';
import 'package:user_app/screens/cart.dart';
import 'package:user_app/screens/detailsPage.dart';
import 'package:user_app/screens/home.dart';
import 'package:user_app/services/cart.dart';
import 'package:user_app/services/favourite.dart';
import 'package:user_app/services/product.dart';
import 'package:user_app/services/storage.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);
  static const String id = '/favorite';

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  Widget cardWidget(index, size) {
    final cart = Provider.of<CartProvider>(context);
    final favorite = Provider.of<FavoriteProvider>(context);
    final product = Products.fromData(data: favProductDetailsList[index]);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 8,
      ),
      child: OpenContainer(
        closedShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        transitionDuration: const Duration(
          milliseconds: 500,
        ),
        transitionType: ContainerTransitionType.fadeThrough,
        openBuilder: (context, _) => ProductDetails(args: {
          "productName": product.productName,
          "productImage": product.productImage,
          "productId": product.productId,
          "productPrice": product.productPrice,
          "productCategory": product.productCategory,
          "productDescription": product.productDescription,
        }),
        closedBuilder: (context, VoidCallback openContainer) => GestureDetector(
          onTap: openContainer,
          child: Neumorphic(
            style: NeumorphicStyle(
              border: const NeumorphicBorder(width: 1),
              depth: -3,
              boxShape: NeumorphicBoxShape.roundRect(
                BorderRadius.circular(15),
              ),
              shadowLightColorEmboss: Colors.white,
              shadowDarkColorEmboss: const Color.fromARGB(255, 162, 162, 162),
              oppositeShadowLightSource: false,
              intensity: 1,
              surfaceIntensity: 0.25,
              lightSource: LightSource.top,
              color: kWhiteColor,
            ),
            child: Column(
              children: [
                size.width >= 500
                    ? Image.network(
                        product.productImage,
                        height: 144,
                        width: 180,
                      )
                    : Image.network(
                        product.productImage,
                        height: 128,
                        width: 164,
                      ),
                CustomTextStyleOne(
                  text: product.productName,
                  fontFamily: redhat,
                  fontSize: size.width >= 500 ? 20 : 16,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: size.width >= 500 ? 16.0 : 8.0,
                  ),
                  child: size.width >= 500
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            PriceWidget(product: product),
                            cartFavoriteRow(index, product, favorite, cart),
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            PriceWidget(product: product),
                            Padding(
                              padding: const EdgeInsets.only(top: 0.0),
                              child: cartFavoriteRow(
                                  index, product, favorite, cart),
                            ),
                          ],
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row cartFavoriteRow(
      index, Products product, FavoriteProvider favorite, CartProvider cart) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.favorite_rounded),
          color: kOrangeColor,
          iconSize: 24,
          tooltip: 'Remove from Favorite',
          onPressed: () async {
            favorite.deleteFavoriteList(product.productId);
            String? data = await Storage.getToken();
            if (data != null) {
              List body = favorite.getFavoriteList();
              final result = await FavouriteDatabase.addUpdateFavourite(body);
              if (result! ~/ 100 == 2) {
                favProductDetailsList.removeAt(index);
                showSnackBar(
                  context,
                  "Item Removed From Favourite",
                  Colors.green,
                );
              } else {
                favProductDetailsList.removeAt(index);
                favorite.saveFavoriteList(product.productId);
                showSnackBar(
                  context,
                  "Couldnot remove item from Favourite",
                  Colors.red,
                );
              }
            }
          },
        ),
        cart.isItemPresent(product.productId)
            ? IconButton(
                icon: const Icon(Icons.add_shopping_cart_rounded),
                color: kOrangeColor,
                iconSize: 32,
                tooltip: 'Add to Cart',
                onPressed: () {
                  showSnackBar(
                    context,
                    'item already in the cart',
                    Colors.red,
                  );
                },
              )
            : IconButton(
                icon: const Icon(Icons.add_shopping_cart_rounded),
                color: kMediumGreenColor,
                iconSize: 32,
                tooltip: 'Add to Cart',
                onPressed: () async {
                  cart.saveCartList(product.productId, 1);
                  cart.addTotalPrice(
                      double.parse(product.productPrice.toString()));
                  String? data = await Storage.getToken();
                  if (data != null) {
                    final body = {
                      'items': cart.getCartList(),
                      'totalPrice': cart.getTotalPrice()
                    };
                    final result = await CartDatabase.addUpdateCart(body);
                    if (result! ~/ 100 == 2) {
                      showSnackBar(
                        context,
                        "Item added as Cart",
                        Colors.green,
                      );
                    } else {
                      cart.deleteCartList(product.productId);
                      cart.removeTotalPrice(
                          double.parse(product.productPrice.toString()));
                      showSnackBar(
                        context,
                        "Couldnot add item to Cart",
                        Colors.red,
                      );
                    }
                  }
                },
              )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final favorite = Provider.of<FavoriteProvider>(context);
    return Scaffold(
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
              navigatorKey.currentState!
                  .pushNamedAndRemoveUntil(Home.id, (route) => false);
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
              padding: const EdgeInsets.only(right: 20),
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
                      onPressed: () {
                        showSnackBar(
                          context,
                          "Already In Favorite",
                          Colors.green,
                        );
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
                              const WaitingDialog(title: "Fetching cart Items"),
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
                      tooltip: 'Navigate To Cart',
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
        child: favorite.getFavoriteList().isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 180,
                      width: 256,
                      child: Icon(Icons.favorite_border,
                          size: 164, color: Colors.black45.withOpacity(0.5)),
                    ),
                    const CustomTextStyleOne(
                      text: 'Favourite is Empty!',
                      fontSize: 24,
                      weight: FontWeight.w600,
                      myColor: kDarkGreenColor,
                      fontFamily: redhat,
                    ),
                    ElevatedButton.icon(
                      icon: const CustomTextStyleOne(
                        text: 'Add Item',
                        fontSize: 20,
                        myColor: kWhiteColor,
                      ),
                      label: const Icon(
                        Icons.home,
                        size: 40,
                      ),
                      onPressed: () {
                        navigatorKey.currentState!
                            .pushNamedAndRemoveUntil(Home.id, (route) => false);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: kLightGreenColor,
                        onPrimary: kWhiteColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : RefreshIndicator(
                color: kLightGreenColor,
                onRefresh: () async {
                  setState(() {});
                  await Future.delayed(const Duration(seconds: 4));
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 16,
                            top: 24,
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: CustomTextStyleOne(
                              text: 'Favorites',
                              fontSize: 24,
                              weight: FontWeight.w600,
                              myColor: kDarkGreenColor,
                              fontFamily: redhat,
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 12.0,
                                right: 12.0,
                                top: 8.0,
                              ),
                              child: GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisExtent: size.width >= 500 ? 260 : 245,
                                  crossAxisCount: size.width > 650
                                      ? size.width > 850
                                          ? 4
                                          : 3
                                      : 2,
                                ),
                                primary: false,
                                itemCount: favorite.getFavoriteList().length,
                                itemBuilder: (context, index) => cardWidget(
                                  index,
                                  size,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}

class PriceWidget extends StatelessWidget {
  const PriceWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Products product;

  @override
  Widget build(BuildContext context) {
    return CustomTextStyleOne(
      text: 'Rs' + (product.productPrice).toString(),
    );
  }
}
