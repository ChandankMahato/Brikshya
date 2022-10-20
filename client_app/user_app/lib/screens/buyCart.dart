import 'dart:convert';

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
import 'package:user_app/provider/location_state.dart';
import 'package:user_app/screens/buy.dart';
import 'package:user_app/screens/home.dart';
import 'package:user_app/screens/signin.dart';
import 'package:user_app/services/auth.dart';
import 'package:user_app/services/location.dart';
import 'package:user_app/services/sell.dart';
import 'package:user_app/services/storage.dart';

class BuyCart extends StatefulWidget {
  static const String id = '/buycart';
  final Map<String, dynamic>? args;
  const BuyCart({this.args, Key? key}) : super(key: key);

  @override
  State<BuyCart> createState() => _BuyCartState();
}

class _BuyCartState extends State<BuyCart> {
  TextEditingController userAddressController = TextEditingController(text: '');
  String userId = '';
  DateTime pickupDate = DateTime.now();

  @override
  void dispose() {
    userAddressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Provider.of<LocationState>(context, listen: false).checkState();
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
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: IconButton(
                    icon: const Icon(Icons.home),
                    color: kDarkGreenColor,
                    iconSize: 32,
                    tooltip: 'Navigate to Home',
                    onPressed: () {
                      navigatorKey.currentState!
                          .pushNamedAndRemoveUntil(Home.id, (route) => false);
                    }),
              )
            ],
            title: InkWell(
              onTap: () {},
              child: const CustomTextStyleOne(
                text: 'Sell Item',
                fontSize: 24,
                myColor: kDarkGreenColor,
                fontFamily: redhat,
              ),
            ),
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
              child: Center(
                child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(
                            top: 16.0,
                            bottom: 8.0,
                          ),
                          child: Text(
                            'Send request for sells!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: kDarkGreenColor,
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
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
                                        onPressed: () {
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
                                            builder: (context) =>
                                                const WaitingDialog(
                                                    title: "Processing"),
                                          );
                                          Position position;
                                          try {
                                            position = await Location
                                                .determinePosition();
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
                                bottom: 16.0,
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
                                          return Center(
                                              child: brikshyaLoaderSmall());
                                        }
                                        if (snapshot.hasError) {
                                          return const Padding(
                                            padding: EdgeInsets.all(16.0),
                                            child: Center(
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
                                          return const Padding(
                                            padding: EdgeInsets.all(16.0),
                                            child: Center(
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
                                                userData['phoneNumber']
                                                    .toString(),
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
                                    color: kOrangeColor,
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
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 16.0,
                            right: 16.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Select Pickup Date:',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              ElevatedButton(
                                child: CustomTextStyleOne(
                                  text: 'Select Date',
                                  fontSize: size.width > 700
                                      ? 20
                                      : size.width > 500
                                          ? 18
                                          : 16,
                                  myColor: kWhiteColor,
                                  weight: FontWeight.w500,
                                ),
                                onPressed: () => _selectDate(context),
                                style: ElevatedButton.styleFrom(
                                  primary: kLightGreenColor,
                                  onPrimary: kWhiteColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 16.0,
                            right: 16.0,
                            top: 8.0,
                            bottom: 16.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Selected Date:',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: kDarkGreenColor,
                                ),
                              ),
                              Text(
                                '${pickupDate.year}/${pickupDate.month}/${pickupDate.day}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: kOrangeColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
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
                                  const Color.fromARGB(255, 162, 162, 162),
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
                                    widget.args!['image'],
                                    height: 80,
                                    width: 64,
                                    fit: BoxFit.fitWidth,
                                    errorBuilder:
                                        ((context, error, stackTrace) {
                                      return const SizedBox(
                                        height: 150,
                                        child: Icon(Icons.image_not_supported,
                                            size: 96, color: Colors.black45),
                                      );
                                    }),
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      }
                                      return Center(
                                        child: CircularProgressIndicator(
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
                                              kDarkGreenColor.withOpacity(0.5),
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(
                                    //width: screen-width - image-width - 2*margin - 2*padding
                                    width: size.width - 64 - 32 - 24,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              CustomTextStyleOne(
                                                text: widget.args!['name'],
                                              ),
                                              IconButton(
                                                padding:
                                                    const EdgeInsets.all(0),
                                                alignment:
                                                    Alignment.centerRight,
                                                icon: const Icon(
                                                    Icons.delete_forever),
                                                color: kOrangeColor,
                                                iconSize: 32,
                                                tooltip: 'Remove Item',
                                                onPressed: () {
                                                  navigatorKey.currentState!
                                                      .popAndPushNamed(
                                                          BuyItemListing.id);
                                                },
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CustomTextStyleOne(
                                                    text: 'Rate: ' +
                                                        (widget.args!['rate'])
                                                            .toString(),
                                                    weight: FontWeight.w400,
                                                  ),
                                                  CustomTextStyleOne(
                                                    text: 'minimum: ' +
                                                        (widget.args![
                                                                'minimum'])
                                                            .toString(),
                                                    weight: FontWeight.w400,
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
                        ),
                        ElevatedButton.icon(
                          icon: const CustomTextStyleOne(
                            text: 'Send Request',
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
                              final stringDate = pickupDate.toString();
                              final address = userAddressController.text.isEmpty
                                  ? 'no'
                                  : userAddressController.text;

                              try {
                                Position myLocation =
                                    await Location.determinePosition();
                                navigatorKey.currentState!.pop();
                                Map<String, dynamic> data = {
                                  "userLocation": {
                                    "latitude": myLocation.latitude,
                                    "longitude": myLocation.longitude,
                                  },
                                  "product": widget.args!['id'],
                                  "pickupDate": stringDate,
                                  "customAddress": address,
                                };
                                final result =
                                    await SellsDatabase.addSellRequest(data);
                                if (result! ~/ 100 == 2) {
                                  showSnackBar(
                                      context,
                                      'Order Placed Successfully!',
                                      kLightGreenColor);
                                  navigatorKey.currentState!
                                      .pushNamed(BuyItemListing.id);
                                } else {
                                  showSnackBar(context,
                                      'Could not Place Order!', Colors.red);
                                }
                              } catch (ex) {
                                navigatorKey.currentState!.pop();
                                showSnackBar(
                                    context,
                                    'something went wrong, try again',
                                    Colors.red);
                              }
                            }
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
                    )),
              ),
            ),
          ),
        ));
  }

  _selectDate(BuildContext context) async {
    DateTime? date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: kDarkGreenColor,
                onPrimary: kWhiteColor,
                onSurface: kBlackColor,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: kDarkGreenColor,
                ),
              ),
            ),
            child: child!,
          );
        });
    //if 'cancel' => null
    if (date == null) return;
    //if 'ok' => DateTIme
    setState(() => pickupDate = date);
  }
}
