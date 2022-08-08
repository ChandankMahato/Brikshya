import 'package:flutter/rendering.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:user_app/Database/db_helper.dart';
import 'package:user_app/components/appbar.dart';
import 'package:user_app/constants.dart';
import 'package:user_app/models/cart_model.dart';
import 'package:user_app/provider/cart_provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  static const String id = '/cart';

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  DBHelper dbHelper = DBHelper();
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      backgroundColor: kGreyLightColor,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: CustomAppBar(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 16.0,
                  bottom: 16.0,
                ),
                child: Text(
                  'My Cart',
                  style: kAppName.copyWith(
                    color: kDarkGreenColor,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'RedHatDisplay',
                    fontSize: 24,
                  ),
                ),
              ),
              FutureBuilder(
                future: cart.getData(),
                builder: (context, AsyncSnapshot<List<Cart>> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isEmpty) {
                      return const Text(
                        'No data',
                      );
                    } else {
                      return Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
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
                                    shadowDarkColorEmboss: const Color.fromARGB(
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
                                        Row(
                                          children: [
                                            Image.asset(
                                              snapshot
                                                  .data![index].productImage,
                                              height: 80,
                                              width: 64,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 8.0,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    snapshot.data![index]
                                                        .productName,
                                                    style: kAppName.copyWith(
                                                      color: kMediumGreenColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          'RedHatDisplay',
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Rs ' +
                                                            (snapshot
                                                                    .data![
                                                                        index]
                                                                    .productPrice)
                                                                .toString(),
                                                        style:
                                                            kAppName.copyWith(
                                                          color:
                                                              kMediumGreenColor,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              'RedHatDisplay',
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            IconButton(
                                              icon: const Icon(
                                                  Icons.delete_forever),
                                              color: kOrangeColor,
                                              iconSize: 32,
                                              tooltip: 'Remove from Cart',
                                              onPressed: () {
                                                dbHelper.delete(int.parse(
                                                    snapshot
                                                        .data![index].itemId));
                                                cart.removeCartItemCount();
                                                cart.removeTotalPrice(
                                                    double.parse(snapshot
                                                        .data![index]
                                                        .productPrice
                                                        .toString()));
                                              },
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 6.0),
                                              child: Row(
                                                children: [
                                                  InkWell(
                                                    child: const Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 12.0),
                                                      child: CustomButtonStyle(
                                                          text: '-'),
                                                    ),
                                                    onTap: () {
                                                      int quantity = snapshot
                                                          .data![index]
                                                          .productQuantity;
                                                      int price = snapshot
                                                          .data![index]
                                                          .initialPrice;
                                                      quantity--;
                                                      int? newPrice =
                                                          price * quantity;
                                                      if (quantity > 0) {
                                                        dbHelper
                                                            .updateQuantity(
                                                                Cart(
                                                          itemId: snapshot
                                                              .data![index]
                                                              .itemId
                                                              .toString(),
                                                          productId: snapshot
                                                              .data![index]
                                                              .productId
                                                              .toString(),
                                                          productName: snapshot
                                                              .data![index]
                                                              .productName
                                                              .toString(),
                                                          productImage: snapshot
                                                              .data![index]
                                                              .productImage
                                                              .toString(),
                                                          initialPrice: snapshot
                                                              .data![index]
                                                              .initialPrice
                                                              .toInt(),
                                                          productPrice:
                                                              newPrice,
                                                          productQuantity:
                                                              quantity,
                                                        ))
                                                            .then((value) {
                                                          newPrice = 0;
                                                          quantity = 0;
                                                          cart.removeTotalPrice(
                                                              double.parse(snapshot
                                                                  .data![index]
                                                                  .initialPrice
                                                                  .toString()));
                                                        }).onError((error,
                                                                stackTrace) {
                                                          print(
                                                              error.toString());
                                                        });
                                                      }
                                                    },
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 12.0),
                                                    child: Text(
                                                      snapshot.data![index]
                                                          .productQuantity
                                                          .toString(),
                                                      style: kAppName.copyWith(
                                                        color:
                                                            kMediumGreenColor,
                                                        fontFamily:
                                                            'RedHatDisplay',
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    child:
                                                        const CustomButtonStyle(
                                                            text: '+'),
                                                    onTap: () {
                                                      int quantity = snapshot
                                                          .data![index]
                                                          .productQuantity;
                                                      int price = snapshot
                                                          .data![index]
                                                          .initialPrice;
                                                      quantity++;
                                                      int? newPrice =
                                                          price * quantity;
                                                      dbHelper
                                                          .updateQuantity(Cart(
                                                        itemId: snapshot
                                                            .data![index].itemId
                                                            .toString(),
                                                        productId: snapshot
                                                            .data![index]
                                                            .productId
                                                            .toString(),
                                                        productName: snapshot
                                                            .data![index]
                                                            .productName
                                                            .toString(),
                                                        productImage: snapshot
                                                            .data![index]
                                                            .productImage
                                                            .toString(),
                                                        initialPrice: snapshot
                                                            .data![index]
                                                            .initialPrice
                                                            .toInt(),
                                                        productPrice: newPrice,
                                                        productQuantity:
                                                            quantity,
                                                      ))
                                                          .then((value) {
                                                        newPrice = 0;
                                                        quantity = 0;
                                                        cart.addTotalPrice(
                                                            double.parse(snapshot
                                                                .data![index]
                                                                .initialPrice
                                                                .toString()));
                                                      }).onError((error,
                                                              stackTrace) {
                                                        print(error.toString());
                                                      });
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
                              );
                            },
                          ),
                          Consumer<CartProvider>(
                            builder: (context, value, child) {
                              return Visibility(
                                visible:
                                    value.getTotalPrice().toStringAsFixed(2) ==
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
                                          border:
                                              const NeumorphicBorder(width: 1),
                                          depth: -3,
                                          boxShape:
                                              NeumorphicBoxShape.roundRect(
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
                                            left: 16.0,
                                            right: 16.0,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Delivery Fee:',
                                                    style: kAppName.copyWith(
                                                      color: kMediumGreenColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          'RedHatDisplay',
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Sub Total:',
                                                    style: kAppName.copyWith(
                                                      color: kMediumGreenColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          'RedHatDisplay',
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Total:',
                                                    style: kAppName.copyWith(
                                                      color: kMediumGreenColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          'RedHatDisplay',
                                                      fontSize: 16,
                                                    ),
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
                                                  Text(
                                                    'Rs 50',
                                                    style: kAppName.copyWith(
                                                      color: kMediumGreenColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          'RedHatDisplay',
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Rs ' +
                                                        cart
                                                            .getTotalPrice()
                                                            .toString(),
                                                    style: kAppName.copyWith(
                                                      color: kMediumGreenColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          'RedHatDisplay',
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Rs ' +
                                                        (cart.getTotalPrice() +
                                                                50)
                                                            .toString(),
                                                    style: kAppName.copyWith(
                                                      color: kMediumGreenColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          'RedHatDisplay',
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    ElevatedButton.icon(
                                      icon: const Text(
                                        'Checkout',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      label: const Icon(
                                        Icons.shopping_cart_checkout_rounded,
                                        size: 40,
                                      ),
                                      onPressed: () {},
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
                      );
                    }
                  } else {
                    return Container(
                      child: Text(
                        'No data',
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomButtonStyle extends StatelessWidget {
  final String text;
  const CustomButtonStyle({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: const NeumorphicStyle(
        border: NeumorphicBorder(width: 0),
        depth: -3,
        boxShape: NeumorphicBoxShape.circle(),
        shadowLightColorEmboss: kWhiteColor,
        shadowDarkColorEmboss: Color.fromARGB(255, 162, 162, 162),
        oppositeShadowLightSource: false,
        intensity: 1,
        surfaceIntensity: 0.25,
        lightSource: LightSource.bottom,
        color: kLightGreenColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: kAppName.copyWith(
            color: kWhiteColor,
            fontFamily: 'RedHatDisplay',
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
