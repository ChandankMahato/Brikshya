import 'package:badges/badges.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:user_app/custom_components/customText.dart';
import 'package:user_app/components/drawer.dart';
import 'package:user_app/constants.dart';
import 'package:user_app/custom_components/snack_bar.dart';
import 'package:user_app/custom_components/waiting_dialog.dart';
import 'package:user_app/main.dart';
import 'package:user_app/models/cart_model.dart';
import 'package:user_app/provider/cart_provider.dart';
import 'package:user_app/provider/favorite_provider.dart';
import 'package:user_app/screens/favorite.dart';
import 'package:user_app/screens/home.dart';
import 'package:user_app/screens/order.dart';
import 'package:user_app/services/cart.dart';
import 'package:user_app/services/product.dart';
import 'package:user_app/services/storage.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  static const String id = '/cart';

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  TextEditingController quantityController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final cart = Provider.of<CartProvider>(context, listen: true);

    return Scaffold(
      backgroundColor: kGreyLightColor,
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
                          builder: (context) => const WaitingDialog(
                              title: "Fetching Favorite Items"),
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
                      tooltip: 'Navigate To Favorite',
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
                      onPressed: () {
                        showSnackBar(
                          context,
                          'Already In Cart',
                          Colors.red,
                        );
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
        child: cart.getCartList().isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 180,
                      width: 256,
                      child: Icon(Icons.add_shopping_cart_rounded,
                          size: 164, color: Colors.black45.withOpacity(0.5)),
                    ),
                    const CustomTextStyleOne(
                      text: 'Cart is Empty!',
                      fontSize: 24,
                      weight: FontWeight.w600,
                      myColor: kDarkGreenColor,
                      fontFamily: redhat,
                    ),
                    const SizedBox(
                      height: 24,
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
                            top: 16.0,
                            bottom: 16.0,
                          ),
                          child: CustomTextStyleOne(
                            text: 'My Cart',
                            fontSize: 20,
                            myColor: kDarkGreenColor,
                            fontFamily: redhat,
                          ),
                        ),
                        Column(
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              itemCount: cart.getCartList().length,
                              itemBuilder: (context, index) {
                                final cartProductObject =
                                    cartProductDetailsList[index];
                                final cartItem = cart.getCartList()[index];
                                cartProductObject['quantity'] =
                                    cartItem['quantity'];
                                final itemObject = CartProduct.fromData(
                                    data: cartProductObject);
                                return Container(
                                  height: 96,
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  child: Neumorphic(
                                    style: NeumorphicStyle(
                                      border: const NeumorphicBorder(width: 1),
                                      depth: -3,
                                      boxShape: NeumorphicBoxShape.roundRect(
                                        BorderRadius.circular(15),
                                      ),
                                      shadowLightColorEmboss: Colors.white,
                                      shadowDarkColorEmboss:
                                          const Color.fromARGB(
                                              255, 162, 162, 162),
                                      oppositeShadowLightSource: false,
                                      intensity: 1,
                                      surfaceIntensity: 0.25,
                                      lightSource: LightSource.top,
                                      color: kWhiteColor,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 12.0,
                                        right: 12.0,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Image.network(
                                            itemObject.productImage,
                                            height: 80,
                                            width: 64,
                                            fit: BoxFit.fitWidth,
                                            errorBuilder:
                                                ((context, error, stackTrace) {
                                              return const SizedBox(
                                                height: 150,
                                                child: Icon(
                                                    Icons.image_not_supported,
                                                    size: 96,
                                                    color: Colors.black45),
                                              );
                                            }),
                                            loadingBuilder:
                                                (BuildContext context,
                                                    Widget child,
                                                    ImageChunkEvent?
                                                        loadingProgress) {
                                              if (loadingProgress == null) {
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
                                                      const AlwaysStoppedAnimation<
                                                          Color>(
                                                    kDarkGreenColor,
                                                  ),
                                                  backgroundColor:
                                                      kDarkGreenColor
                                                          .withOpacity(0.5),
                                                ),
                                              );
                                            },
                                          ),
                                          SizedBox(
                                            //width: screen-width - image-width - 2*margin - 2*padding
                                            width: size.width - 64 - 32 - 24,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      CustomTextStyleOne(
                                                        text: itemObject
                                                            .productName,
                                                      ),
                                                      IconButton(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(0),
                                                        alignment: Alignment
                                                            .centerRight,
                                                        icon: const Icon(Icons
                                                            .delete_forever),
                                                        color: kOrangeColor,
                                                        iconSize: 32,
                                                        tooltip:
                                                            'Remove from Cart',
                                                        onPressed: () async {
                                                          cart.deleteCartList(
                                                            itemObject
                                                                .productId,
                                                          );
                                                          cart.removeTotalPrice(
                                                              double.parse((itemObject
                                                                          .productQuantity *
                                                                      itemObject
                                                                          .productPrice)
                                                                  .toString()));
                                                          String? data =
                                                              await Storage
                                                                  .getToken();
                                                          if (data != null) {
                                                            final body = {
                                                              'items': cart
                                                                  .getCartList(),
                                                              'totalPrice': cart
                                                                  .getTotalPrice()
                                                            };
                                                            final result =
                                                                await CartDatabase
                                                                    .addUpdateCart(
                                                                        body);
                                                            if (result! ~/
                                                                    100 ==
                                                                2) {
                                                              cartProductDetailsList
                                                                  .removeAt(
                                                                      index);
                                                              showSnackBar(
                                                                context,
                                                                "Item Removed from Cart",
                                                                Colors.green,
                                                              );
                                                            } else {
                                                              cart.saveCartList(
                                                                  itemObject
                                                                      .productId,
                                                                  1);
                                                              cart.addTotalPrice(double.parse((itemObject
                                                                          .productQuantity *
                                                                      itemObject
                                                                          .productPrice)
                                                                  .toString()));
                                                              showSnackBar(
                                                                context,
                                                                "Couldnot remove item from Cart",
                                                                Colors.red,
                                                              );
                                                            }
                                                          }
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          CustomTextStyleOne(
                                                            text: 'Rs ' +
                                                                (itemObject
                                                                        .productPrice)
                                                                    .toString(),
                                                          ),
                                                        ],
                                                      ),
                                                      Container(
                                                        width: 120,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              width: 2.0,
                                                              color:
                                                                  kDarkGreenColor),
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(
                                                            Radius.circular(
                                                                5.0),
                                                          ),
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            InkWell(
                                                              child: Container(
                                                                width: 24,
                                                                decoration:
                                                                    const BoxDecoration(
                                                                  color:
                                                                      kLightGreenColor,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            3.0),
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            3.0),
                                                                  ),
                                                                ),
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child:
                                                                    const Text(
                                                                  '-',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          24,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color:
                                                                          kWhiteColor),
                                                                ),
                                                              ),
                                                              onTap: () async {
                                                                int quantity =
                                                                    itemObject
                                                                        .productQuantity;
                                                                if (quantity >
                                                                    0) {
                                                                  quantity--;
                                                                }
                                                                quantityController
                                                                        .text =
                                                                    quantity
                                                                        .toString();
                                                                if (quantity >
                                                                    0) {
                                                                  cart.updateCartList(
                                                                      itemObject
                                                                          .productId,
                                                                      quantity);
                                                                  quantity = 0;
                                                                  cart.removeTotalPrice(
                                                                    double
                                                                        .parse(
                                                                      itemObject
                                                                          .productPrice
                                                                          .toString(),
                                                                    ),
                                                                  );
                                                                }
                                                                String? data =
                                                                    await Storage
                                                                        .getToken();
                                                                if (data !=
                                                                    null) {
                                                                  final body = {
                                                                    "items": cart
                                                                        .getCartList(),
                                                                    "totalPrice":
                                                                        cart.getTotalPrice(),
                                                                  };
                                                                  final result =
                                                                      await CartDatabase
                                                                          .addUpdateCart(
                                                                              body);
                                                                  if (result! ~/
                                                                          100 ==
                                                                      2) {
                                                                    print(
                                                                        'success');
                                                                  } else {
                                                                    int quantity =
                                                                        itemObject
                                                                            .productQuantity;
                                                                    if (quantity >
                                                                        0) {
                                                                      quantity++;
                                                                    }
                                                                    quantityController
                                                                            .text =
                                                                        quantity
                                                                            .toString();
                                                                    if (quantity >
                                                                        0) {
                                                                      cart.updateCartList(
                                                                          itemObject
                                                                              .productId,
                                                                          quantity);
                                                                      quantity =
                                                                          0;
                                                                      cart.addTotalPrice(
                                                                        double
                                                                            .parse(
                                                                          itemObject
                                                                              .productPrice
                                                                              .toString(),
                                                                        ),
                                                                      );
                                                                    }
                                                                  }
                                                                }
                                                              },
                                                            ),
                                                            Text(
                                                              itemObject
                                                                  .productQuantity
                                                                  .toString(),
                                                              style: kAppName
                                                                  .copyWith(
                                                                color:
                                                                    kMediumGreenColor,
                                                                fontFamily:
                                                                    'RedHatDisplay',
                                                                fontSize: 20,
                                                              ),
                                                            ),
                                                            InkWell(
                                                              child: Container(
                                                                width: 24,
                                                                decoration:
                                                                    const BoxDecoration(
                                                                  color:
                                                                      kLightGreenColor,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .only(
                                                                    topRight: Radius
                                                                        .circular(
                                                                            3.0),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            3.0),
                                                                  ),
                                                                ),
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child:
                                                                    const Text(
                                                                  '+',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          24,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color:
                                                                          kWhiteColor),
                                                                ),
                                                              ),
                                                              onTap: () async {
                                                                int quantity =
                                                                    itemObject
                                                                        .productQuantity;
                                                                quantity++;
                                                                quantityController
                                                                        .text =
                                                                    quantity
                                                                        .toString();
                                                                cart.updateCartList(
                                                                    itemObject
                                                                        .productId,
                                                                    quantity);
                                                                quantity = 0;
                                                                cart.addTotalPrice(
                                                                  double.parse(
                                                                    itemObject
                                                                        .productPrice
                                                                        .toString(),
                                                                  ),
                                                                );
                                                                String? data =
                                                                    await Storage
                                                                        .getToken();
                                                                if (data !=
                                                                    null) {
                                                                  final body = {
                                                                    "items": cart
                                                                        .getCartList(),
                                                                    "totalPrice":
                                                                        cart.getTotalPrice(),
                                                                  };
                                                                  final result =
                                                                      await CartDatabase
                                                                          .addUpdateCart(
                                                                              body);
                                                                  if (result! ~/
                                                                          100 ==
                                                                      2) {
                                                                    print(
                                                                        'success');
                                                                  } else {
                                                                    int quantity =
                                                                        itemObject
                                                                            .productQuantity;
                                                                    quantity--;
                                                                    quantityController
                                                                            .text =
                                                                        quantity
                                                                            .toString();
                                                                    cart.updateCartList(
                                                                        itemObject
                                                                            .productId,
                                                                        quantity);
                                                                    quantity =
                                                                        0;
                                                                    cart.addTotalPrice(
                                                                      double
                                                                          .parse(
                                                                        itemObject
                                                                            .productPrice
                                                                            .toString(),
                                                                      ),
                                                                    );
                                                                  }
                                                                }
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            Consumer<CartProvider>(
                              builder: (context, value, child) {
                                return Visibility(
                                  visible: value
                                              .getTotalPrice()
                                              .toStringAsFixed(2) ==
                                          "0.00"
                                      ? false
                                      : true,
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 80,
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 16.0,
                                          vertical: 16.0,
                                        ),
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
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              left: 16.0,
                                              right: 16.0,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: const [
                                                    CustomTextStyleOne(
                                                      text: 'Delivery Fee:',
                                                    ),
                                                    CustomTextStyleOne(
                                                      text: 'Sub Total:',
                                                    ),
                                                    CustomTextStyleOne(
                                                      text: 'Total:',
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const CustomTextStyleOne(
                                                      text: 'Rs 50',
                                                    ),
                                                    CustomTextStyleOne(
                                                      text: 'Rs ' +
                                                          value
                                                              .getTotalPrice()
                                                              .toString(),
                                                    ),
                                                    CustomTextStyleOne(
                                                      text: 'Rs ' +
                                                          (value.getTotalPrice() +
                                                                  50)
                                                              .toString(),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      ElevatedButton.icon(
                                        icon: const CustomTextStyleOne(
                                          text: 'Checkout',
                                          fontSize: 20,
                                          myColor: kWhiteColor,
                                        ),
                                        label: const Icon(
                                          Icons.shopping_cart_checkout_rounded,
                                          size: 40,
                                        ),
                                        onPressed: () {
                                          navigatorKey.currentState!
                                              .pushNamed(OrderScreen.id);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: kLightGreenColor,
                                          onPrimary: kWhiteColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            )
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
