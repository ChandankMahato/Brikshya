import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:user_app/components/drawer.dart';
import 'package:user_app/constants.dart';
import 'package:user_app/custom_components/customText.dart';
import 'package:user_app/custom_components/custom_widget.dart';
import 'package:user_app/custom_components/snack_bar.dart';
import 'package:user_app/custom_components/waiting_dialog.dart';
import 'package:user_app/main.dart';
import 'package:user_app/models/cart_model.dart';
import 'package:user_app/provider/cart_provider.dart';
import 'package:user_app/provider/check_box_state.dart';
import 'package:user_app/provider/expansion_tile_state.dart';
import 'package:user_app/provider/favorite_provider.dart';
import 'package:user_app/provider/location_state.dart';
import 'package:user_app/screens/cart.dart';
import 'package:user_app/screens/favorite.dart';
import 'package:user_app/screens/home.dart';
import 'package:user_app/screens/signin.dart';
import 'package:user_app/services/auth.dart';
import 'package:user_app/services/location.dart';
import 'package:user_app/services/order.dart';
import 'package:user_app/services/product.dart';
import 'package:user_app/services/storage.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  static const String id = '/order';

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  TextEditingController userAddressController = TextEditingController(text: '');
  // late Position myLocation;
  String userId = '';
  final now = DateTime.now();
  late DateTime deliveryDate;

  @override
  void initState() {
    deliveryDate = now.add(Duration(days: (6 - now.weekday)));
    super.initState();
  }

  @override
  void dispose() {
    userAddressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Provider.of<LocationState>(context, listen: false).checkState();
    final cart = Provider.of<CartProvider>(context, listen: false);
    final expandTile =
        Provider.of<ExpandTileState>(context, listen: true).isExpanded;
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
                          showSnackBar(
                            context,
                            "Couldnot fetch favorite item, try again",
                            Colors.red,
                          );
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
                          showSnackBar(
                            context,
                            "Couldnot fetch Cart item, try again",
                            Colors.red,
                          );
                        }
                      },
                      tooltip: 'Already In Cart',
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
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 16.0,
                      bottom: 8.0,
                    ),
                    child: CustomTextStyleOne(
                      text: 'My Order',
                      fontSize: 20,
                      myColor: kDarkGreenColor,
                      fontFamily: redhat,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      top: 8.0,
                      right: 8.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FutureBuilder(
                          future: Storage.getToken(),
                          builder: (context, snapshot) {
                            if (snapshot.data == null) {
                              return SizedBox(
                                width: (size.width / 2 - 16),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    navigatorKey.currentState!
                                        .pushNamed(Signin.id)
                                        .then((_) => setState(() {}));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: kOrangeColor,
                                    onPrimary: kWhiteColor,
                                  ),
                                  child: CustomTextStyleOne(
                                    text: 'SignIn Required',
                                    fontSize: size.width > 700
                                        ? 20
                                        : size.width > 500
                                            ? 18
                                            : 16,
                                    myColor: kWhiteColor,
                                    weight: FontWeight.w500,
                                  ),
                                ),
                              );
                            } else {
                              return SizedBox(
                                width: (size.width / 2 - 16),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    navigatorKey.currentState!
                                        .pushNamed(Signin.id)
                                        .then((_) => setState(() {}));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: kLightGreenColor,
                                    onPrimary: kWhiteColor,
                                  ),
                                  child: CustomTextStyleOne(
                                    text: 'SignedIn',
                                    fontSize: size.width > 700
                                        ? 20
                                        : size.width > 500
                                            ? 18
                                            : 16,
                                    myColor: kWhiteColor,
                                    weight: FontWeight.w500,
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                        Provider.of<LocationState>(context, listen: true)
                                .isLocationEnabled
                            ? SizedBox(
                                width: (size.width / 2 - 16),
                                child: ElevatedButton(
                                  onPressed: () async {},
                                  style: ElevatedButton.styleFrom(
                                    primary: kLightGreenColor,
                                    onPrimary: kWhiteColor,
                                  ),
                                  child: CustomTextStyleOne(
                                    text: 'Location Enabled',
                                    fontSize: size.width > 700
                                        ? 20
                                        : size.width > 500
                                            ? 18
                                            : 16,
                                    myColor: kWhiteColor,
                                    weight: FontWeight.w500,
                                  ),
                                ),
                              )
                            : SizedBox(
                                width: (size.width / 2 - 16),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    showDialog(
                                      context: context,
                                      builder: (context) => const WaitingDialog(
                                          title: "Processing"),
                                    );
                                    Position position;
                                    try {
                                      position =
                                          await Location.determinePosition();
                                      navigatorKey.currentState!.pop();
                                      Provider.of<LocationState>(context,
                                              listen: false)
                                          .changeState(true);
                                    } catch (ex) {
                                      navigatorKey.currentState!.pop();
                                      return showSnackBar(
                                        context,
                                        'Enable Your Device Location services',
                                        Colors.red,
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: kOrangeColor,
                                    onPrimary: kWhiteColor,
                                  ),
                                  child: CustomTextStyleOne(
                                    text: 'Allow Location',
                                    fontSize: size.width > 700
                                        ? 20
                                        : size.width > 500
                                            ? 18
                                            : 16,
                                    myColor: kWhiteColor,
                                    weight: FontWeight.w500,
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: const EdgeInsets.only(
                          left: 16.0,
                          right: 16.0,
                          bottom: 32.0,
                        ),
                        child: FutureBuilder(
                          future: Storage.getToken(),
                          builder: (context, snapshot) {
                            if (snapshot.data == null) {
                              return const Text(
                                'Please, signin and allow location',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 20,
                                ),
                              );
                            } else {
                              Object? token = snapshot.data;
                              final auth = jsonDecode(token.toString());
                              userId = auth['id'];
                              return FutureBuilder<Map>(
                                future: Authentication.userProfile(),
                                builder: ((context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return Center(child: brikshyaLoaderSmall());
                                  }
                                  if (snapshot.hasError) {
                                    return const Center(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          top: 16.0,
                                        ),
                                        child: Text(
                                          'no User Info, try refresing',
                                          style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  if (snapshot.data!.isEmpty) {
                                    return const Center(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          top: 16.0,
                                        ),
                                        child: Text(
                                          'no User Info, try refresing',
                                          style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  final userData = snapshot.data;
                                  return Column(
                                    children: [
                                      ListTile(
                                        leading: const Icon(
                                          Icons.person,
                                          size: 32,
                                          color: kOrangeColor,
                                        ),
                                        title: Text(
                                          userData!['name'],
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ),
                                      ListTile(
                                        leading: const Icon(
                                          Icons.phone,
                                          size: 32,
                                          color: kOrangeColor,
                                        ),
                                        title: Text(
                                          userData['phoneNumber'].toString(),
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                              );
                            }
                          },
                        )),
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 16.0, right: 16.0),
                      child: Text(
                        'Deliver at different address?',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, bottom: 16.0, top: 16.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: TextFormField(
                          controller: userAddressController,
                          maxLines: 1,
                          autofocus: false,
                          decoration: InputDecoration(
                            hintText: 'Enter Custom Address',
                            labelText: 'Custom Address',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: const BorderSide(
                                color: kBlackColor,
                                width: 2,
                              ),
                            ),
                            focusColor: kDarkGreenColor,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: const BorderSide(
                                color: kDarkGreenColor,
                                width: 2,
                              ),
                            ),
                            labelStyle: const TextStyle(
                              color: kMediumGreenColor,
                              fontSize: 16,
                            ),
                            prefixIcon: const Icon(
                              Icons.add_location_outlined,
                              color: kOrangeColor,
                            ),
                            hintStyle: TextStyle(
                                fontSize: 16,
                                color: kBlackColor.withOpacity(0.2)),
                          ),
                          cursorColor: kDarkGreenColor,
                          keyboardType: TextInputType.streetAddress,
                          onFieldSubmitted: (val) {
                            userAddressController.text = val.toString();
                          }),
                    ),
                  ),
                  FutureBuilder(
                    future: Storage.getToken(),
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return const Padding(
                          padding: EdgeInsets.only(
                            top: 16.0,
                            bottom: 16.0,
                          ),
                          child: CustomTextStyleOne(
                            text: 'SignIn to View Order Summary',
                            fontSize: 20,
                            myColor: kDarkGreenColor,
                            fontFamily: redhat,
                          ),
                        );
                      } else {
                        Object? token = snapshot.data;
                        final auth = jsonDecode(token.toString());
                        userId = auth['id'];
                        return Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: ExpansionTile(
                              collapsedBackgroundColor: kLightGreenColor,
                              collapsedTextColor: kWhiteColor,
                              onExpansionChanged: (value) {
                                Provider.of<ExpandTileState>(context,
                                        listen: false)
                                    .changeState(value);
                              },
                              trailing: Icon(
                                expandTile
                                    ? Icons.arrow_upward_outlined
                                    : Icons.arrow_downward_outlined,
                                color:
                                    expandTile ? kLightGreenColor : kWhiteColor,
                              ),
                              leading: Icon(
                                Icons.add_shopping_cart_rounded,
                                color:
                                    expandTile ? kLightGreenColor : kWhiteColor,
                              ),
                              title: Text(
                                expandTile
                                    ? 'Hide Order Summary'
                                    : 'View Order Summary',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: expandTile
                                      ? kLightGreenColor
                                      : kWhiteColor,
                                ),
                              ),
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
                                      height: 66,
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 16,
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
                                          shadowLightColorEmboss:
                                              const Color.fromARGB(
                                                  255, 192, 74, 74),
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
                                                height: 56,
                                                width: 56,
                                              ),
                                              SizedBox(
                                                //width: screen-width - image-width - 2*margin - 2*padding
                                                width:
                                                    size.width - 56 - 48 - 24,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
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
                                                          Row(
                                                            children: [
                                                              const CustomTextStyleOne(
                                                                text:
                                                                    'Quantity:  ',
                                                                fontSize: 16,
                                                                myColor: Colors
                                                                    .black54,
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
                                                                      redhat,
                                                                  fontSize: 20,
                                                                ),
                                                              ),
                                                            ],
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
                                      visible: value.getCartList().isEmpty
                                          ? false
                                          : true,
                                      child: Column(children: [
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
                                                        CrossAxisAlignment
                                                            .start,
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
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const CustomTextStyleOne(
                                                        text: 'Rs 50',
                                                      ),
                                                      CustomTextStyleOne(
                                                        text: 'Rs ' +
                                                            cart
                                                                .getTotalPrice()
                                                                .toString(),
                                                      ),
                                                      CustomTextStyleOne(
                                                        text: 'Rs ' +
                                                            (cart.getTotalPrice() +
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
                                      ]),
                                    );
                                  },
                                ),
                              ]),
                        );
                      }
                    },
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, top: 24.0, right: 28.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CustomTextStyleOne(
                              text: 'Delivery Date:',
                              fontSize: 16,
                              myColor: Colors.black54,
                            ),
                            CustomTextStyleOne(
                              text: 'Saturday, ' +
                                  deliveryDate.year.toString() +
                                  '-' +
                                  deliveryDate.month.toString() +
                                  '-' +
                                  deliveryDate.day.toString(),
                              fontSize: 16,
                              myColor: kDarkGreenColor,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const CustomTextStyleOne(
                              text: 'Cash on delivery:',
                              fontSize: 16,
                              myColor: Colors.black54,
                            ),
                            Row(
                              children: [
                                CustomTextStyleOne(
                                  text: Provider.of<CashInHandState>(context,
                                              listen: true)
                                          .cashOnDelivery
                                      ? 'checked'
                                      : 'unchecked',
                                  fontSize: 12,
                                  myColor: Provider.of<CashInHandState>(context,
                                              listen: true)
                                          .cashOnDelivery
                                      ? kLightGreenColor
                                      : kOrangeColor,
                                ),
                                Checkbox(
                                  value: Provider.of<CashInHandState>(context,
                                          listen: true)
                                      .cashOnDelivery,
                                  activeColor: kDarkGreenColor,
                                  onChanged: (bool? value) {
                                    Provider.of<CashInHandState>(context,
                                            listen: false)
                                        .changeState(value!);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: () {
                              if (userId == '') {
                                showSnackBar(
                                  context,
                                  'Signin Required',
                                  Colors.red,
                                );
                              } else {
                                Map paymentData = {
                                  'userId': userId,
                                  'totalPrice': cart.getTotalPrice(),
                                };
                                print(paymentData);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              primary: kLightGreenColor,
                              onPrimary: kWhiteColor,
                            ),
                            child: const CustomTextStyleOne(
                              text: 'Pay Now! With Khalti',
                              fontSize: 20,
                              myColor: kWhiteColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton.icon(
                        icon: const CustomTextStyleOne(
                          text: 'Place Order',
                          fontSize: 20,
                          myColor: kWhiteColor,
                        ),
                        label: const Icon(
                          Icons.shopping_cart_checkout_rounded,
                          size: 40,
                        ),
                        onPressed: () async {
                          if (userId == '') {
                            showSnackBar(
                              context,
                              'Signin Required',
                              Colors.red,
                            );
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) =>
                                  const WaitingDialog(title: "Processing"),
                            );
                            final stringDate = deliveryDate.toString();
                            final deliveryMode = Provider.of<CashInHandState>(
                                    context,
                                    listen: false)
                                .cashOnDelivery;
                            final address = userAddressController.text.isEmpty
                                ? 'no'
                                : userAddressController.text;
                            try {
                              Position myLocation =
                                  await Location.determinePosition();
                              Map<String, dynamic> data = {
                                "userLocation": {
                                  "latitude": myLocation.latitude,
                                  "longitude": myLocation.longitude
                                },
                                "items": cart.getCartList(),
                                "totalPrice": cart.getTotalPrice(),
                                "deliveryDate": stringDate,
                                "cashOnDelivery": deliveryMode,
                                "customAddress": address
                              };
                              final result =
                                  await OrderDatabase.placeUserOrder(data);
                              if (result! ~/ 100 == 2) {
                                navigatorKey.currentState!.pop();
                                showSnackBar(
                                    context,
                                    'Order Placed Successfully!',
                                    kLightGreenColor);
                                Provider.of<CartProvider>(context,
                                        listen: false)
                                    .resetCart();
                                navigatorKey.currentState!
                                    .pushNamedAndRemoveUntil(
                                        Home.id, (route) => false);
                              } else {
                                showSnackBar(
                                  context,
                                  'Could not Place Order!',
                                  Colors.red,
                                );
                              }
                            } catch (ex) {
                              navigatorKey.currentState!.pop();
                              showSnackBar(
                                context,
                                'something went wrong, try again',
                                Colors.red,
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: kLightGreenColor,
                          onPrimary: kWhiteColor,
                        ),
                      ),
                    ),
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
