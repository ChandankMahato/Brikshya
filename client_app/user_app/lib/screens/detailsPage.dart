import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:user_app/custom_components/customText.dart';
import 'package:user_app/constants.dart';
import 'package:user_app/custom_components/snack_bar.dart';
import 'package:user_app/custom_components/waiting_dialog.dart';
import 'package:user_app/main.dart';
import 'package:user_app/provider/cart_provider.dart';
import 'package:user_app/provider/favorite_provider.dart';
import 'package:user_app/screens/cart.dart';
import 'package:user_app/screens/home.dart';
import 'package:user_app/services/cart.dart';
import 'package:user_app/services/favourite.dart';
import 'package:user_app/services/product.dart';
import 'package:user_app/services/storage.dart';

class ProductDetails extends StatefulWidget {
  final Map<String, dynamic>? args;
  const ProductDetails({
    Key? key,
    this.args,
  }) : super(key: key);

  static const String id = '/productdetails';

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final favorite = Provider.of<FavoriteProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
                margin: const EdgeInsets.all(15),
                height:
                    size.width > 400 ? size.height * 0.4 : size.height * 0.35,
                width: double.infinity,
                alignment: Alignment.center,
                child: Image.network(
                  widget.args!['productImage'],
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          kDarkGreenColor,
                        ),
                        backgroundColor: kDarkGreenColor.withOpacity(0.5),
                      ),
                    );
                  },
                )),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back,
                size: 30,
                color: kLightGreenColor,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SingleChildScrollView(
        child: Column(
          children: [
            Neumorphic(
              style: NeumorphicStyle(
                border: const NeumorphicBorder(width: 1),
                depth: -3,
                boxShape: NeumorphicBoxShape.roundRect(
                  const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                shadowDarkColorEmboss: const Color.fromARGB(255, 162, 162, 162),
                oppositeShadowLightSource: false,
                intensity: 1,
                surfaceIntensity: 0.25,
                lightSource: LightSource.top,
                color: kDarkGreenColor,
              ),
              child: Container(
                height:
                    size.width > 400 ? size.height * 0.4 : size.height * 0.45,
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomTextStyleOne(
                            text: widget.args!['productName'],
                            myColor: kWhiteColor,
                            fontSize: size.width > 500 ? 28 : 20,
                          ),
                          favorite.isItemPresent(widget.args!['productId'])
                              ? IconButton(
                                  icon: const Icon(Icons.favorite_rounded),
                                  color: kOrangeColor,
                                  iconSize: 24,
                                  tooltip: 'Remove from Favorite',
                                  onPressed: () async {
                                    favorite.deleteFavoriteList(
                                        widget.args!['productId']);
                                    String? data = await Storage.getToken();
                                    if (data != null) {
                                      List body = favorite.getFavoriteList();
                                      final result = await FavouriteDatabase
                                          .addUpdateFavourite(body);
                                      if (result! ~/ 100 == 2) {
                                        showSnackBar(
                                          context,
                                          "Item Removed From Favourite",
                                          Colors.green,
                                        );
                                      } else {
                                        favorite.saveFavoriteList(
                                            widget.args!['productId']);
                                        showSnackBar(
                                          context,
                                          "Couldnot remove item From Favourite",
                                          Colors.red,
                                        );
                                      }
                                    }
                                  },
                                )
                              : IconButton(
                                  icon: const Icon(
                                      Icons.favorite_outline_rounded),
                                  color: kWhiteColor,
                                  iconSize: 24,
                                  tooltip: 'Add to Favorite',
                                  onPressed: () async {
                                    favorite.saveFavoriteList(
                                        widget.args!['productId']);
                                    String? data = await Storage.getToken();
                                    if (data != null) {
                                      List body = favorite.getFavoriteList();
                                      final result = await FavouriteDatabase
                                          .addUpdateFavourite(body);
                                      if (result! ~/ 100 == 2) {
                                        showSnackBar(
                                          context,
                                          "Item added as Favourite",
                                          Colors.green,
                                        );
                                      } else {
                                        favorite.deleteFavoriteList(
                                            widget.args!['productId']);
                                        showSnackBar(
                                          context,
                                          "Could not add item to Favourite",
                                          Colors.red,
                                        );
                                      }
                                    }
                                  },
                                ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextStyleOne(
                                  text: 'Description',
                                  fontSize: size.width > 500 ? 28 : 20,
                                  myColor: kWhiteColor,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  widget.args!['productDescription'],
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
                                    color: kWhiteColor,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  CustomTextStyleOne(
                                    text: 'Product Price:',
                                    fontSize: size.width > 500 ? 24 : 16,
                                    myColor: kWhiteColor,
                                  ),
                                  const Spacer(),
                                  CustomTextStyleOne(
                                    text: 'Rs ',
                                    fontSize: size.width > 500 ? 24 : 16,
                                    myColor: kWhiteColor,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  CustomTextStyleOne(
                                    text:
                                        widget.args!['productPrice'].toString(),
                                    myColor: kWhiteColor,
                                    fontSize: size.width > 500 ? 24 : 16,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  CustomTextStyleOne(
                                    text: 'Delivery Time:',
                                    fontSize: size.width > 500 ? 24 : 16,
                                    myColor: kWhiteColor,
                                  ),
                                  const Spacer(),
                                  Icon(
                                    CupertinoIcons.clock,
                                    color: kWhiteColor,
                                    size: size.width > 500 ? 24 : 16,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  CustomTextStyleOne(
                                    text: '20 Minutes',
                                    fontSize: size.width > 500 ? 24 : 16,
                                    myColor: kWhiteColor,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 70,
              decoration: const BoxDecoration(
                color: kGreyLightColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  cart.isItemPresent(widget.args!['productId'])
                      ? InkWell(
                          onTap: () async {
                            showDialog(
                              context: context,
                              builder: (context) => const WaitingDialog(
                                  title: "Fetching cart Items"),
                            );
                            cartProductDetailsList =
                                await ProductDatabase.multipleProductDetails(
                                    Provider.of<CartProvider>(context,
                                            listen: false)
                                        .getCartList());
                            if (cartProductDetailsList.isNotEmpty) {
                              navigatorKey.currentState!.pop();
                              navigatorKey.currentState!
                                  .pushNamed(CartScreen.id);
                            } else {
                              cartProductDetailsList = [];
                              navigatorKey.currentState!.pop();
                              showSnackBar(
                                  context,
                                  "Couldnot fetch Cart item, try again",
                                  Colors.red);
                            }
                          },
                          child: const AddToCartWidget(
                            buttonText: 'View cart',
                            buttonIcon: Icons.add_shopping_cart_rounded,
                            iconColor: kOrangeColor,
                          ),
                        )
                      : InkWell(
                          onTap: () async {
                            cart.saveCartList(
                                widget.args!['productId'].toString(), 1);
                            cart.addTotalPrice(double.parse(
                                widget.args!['productPrice'].toString()));
                            String? data = await Storage.getToken();
                            if (data != null) {
                              final body = {
                                'items': cart.getCartList(),
                                'totalPrice': cart.getTotalPrice()
                              };
                              final result =
                                  await CartDatabase.addUpdateCart(body);
                              if (result! ~/ 100 == 2) {
                                showSnackBar(
                                  context,
                                  "Item added to Cart",
                                  Colors.green,
                                );
                              } else {
                                cart.deleteCartList(widget.args!['productId']);
                                cart.removeTotalPrice(
                                    widget.args!['productId']);
                                showSnackBar(
                                  context,
                                  "Couldnot add Item to Cart",
                                  Colors.red,
                                );
                              }
                            }
                          },
                          child: const AddToCartWidget(
                            buttonText: 'add to cart',
                            buttonIcon: Icons.add_shopping_cart_rounded,
                            iconColor: kWhiteColor,
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddToCartWidget extends StatelessWidget {
  final String buttonText;
  final IconData buttonIcon;
  final Color iconColor;
  const AddToCartWidget({
    required this.buttonText,
    required this.buttonIcon,
    required this.iconColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        color: kDarkGreenColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            buttonIcon,
            color: iconColor,
            size: 28,
          ),
          const SizedBox(
            width: 5,
          ),
          CustomTextStyleOne(
            text: buttonText,
            fontSize: 18,
            myColor: kWhiteColor,
          ),
        ],
      ),
    );
  }
}
