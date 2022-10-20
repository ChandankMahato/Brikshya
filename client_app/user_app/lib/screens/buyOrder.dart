import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_app/components/drawer.dart';
import 'package:user_app/constants.dart';
import 'package:user_app/custom_components/customText.dart';
import 'package:user_app/custom_components/custom_widget.dart';
import 'package:user_app/custom_components/snack_bar.dart';
import 'package:user_app/custom_components/waiting_dialog.dart';
import 'package:user_app/main.dart';
import 'package:user_app/provider/logged_in_state.dart';
import 'package:user_app/screens/buy.dart';
import 'package:user_app/screens/free_event.dart';
import 'package:user_app/screens/home.dart';
import 'package:user_app/screens/my_event.dart';
import 'package:user_app/screens/signin.dart';
import 'package:user_app/services/sell.dart';
import 'package:user_app/services/storage.dart';

class BuyOrder extends StatefulWidget {
  const BuyOrder({Key? key}) : super(key: key);
  static const String id = "/buyOrder";

  @override
  State<BuyOrder> createState() => _UserOrderState();
}

class _UserOrderState extends State<BuyOrder> {
  @override
  Widget build(BuildContext context) {
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
              text: 'Manage Sells',
              fontSize: 24,
              myColor: kDarkGreenColor,
              fontFamily: redhat,
            ),
          ),
        ),
      ),
      drawer: const AppDrawer(),
      body: SafeArea(
        child: Provider.of<LoggedInState>(context, listen: true).isLoggedIn
            ? RefreshIndicator(
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
                      child: FutureBuilder(
                        future: Storage.getToken(),
                        builder: ((context, snapshot) {
                          return FutureBuilder<List>(
                            future: SellsDatabase.getPendingRequest(),
                            builder: ((context, snapshot) {
                              if (!snapshot.hasData) {
                                return brikshyaLoader();
                              }
                              if (snapshot.hasError) {
                                return networkError();
                              }
                              if (snapshot.data!.isEmpty) {
                                return Column(
                                  children: [
                                    const NoDataWidget(
                                      title: 'No Pending Sells',
                                      icondata: Icons.shopping_bag_outlined,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(top: 32.0),
                                      child: CustomTextStyleOne(
                                        text: 'Do you wants to Sell something?',
                                        fontSize: 20,
                                        weight: FontWeight.w600,
                                        myColor: kDarkGreenColor,
                                        fontFamily: redhat,
                                      ),
                                    ),
                                    ElevatedButton.icon(
                                      icon: const CustomTextStyleOne(
                                        text: 'Place Sell Request',
                                        fontSize: 20,
                                        myColor: kWhiteColor,
                                      ),
                                      label: const Icon(
                                        Icons.home,
                                        size: 40,
                                      ),
                                      onPressed: () {
                                        navigatorKey.currentState!
                                            .pushNamedAndRemoveUntil(
                                                BuyItemListing.id,
                                                (route) => false);
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
                                );
                              }
                              final sells = snapshot.data!;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'Manage your sell request!',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: kDarkGreenColor,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: const ScrollPhysics(),
                                    itemCount: sells.length,
                                    itemBuilder: ((context, index) {
                                      Map<String, dynamic> mySell =
                                          sells[index] as Map<String, dynamic>;

                                      final productData = mySell['product'];
                                      return Card(
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 12,
                                          horizontal: 16,
                                        ),
                                        elevation: 4,
                                        color: kWhiteColor,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(12),
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 56,
                                              decoration: const BoxDecoration(
                                                color: kLightGreenColor,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(12),
                                                  topRight: Radius.circular(12),
                                                ),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 16.0),
                                                child: Row(
                                                  children: [
                                                    const CustomTextStyleOne(
                                                      text: 'Invoice:  ',
                                                      myColor: kWhiteColor,
                                                    ),
                                                    CustomTextStyleOne(
                                                      text: mySell['_id'],
                                                      myColor: kWhiteColor,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 16.0,
                                                right: 16.0,
                                                bottom: 16.0,
                                                top: 16.0,
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: const [
                                                              CustomTextStyleOne(
                                                                text:
                                                                    'product:  ',
                                                                myColor:
                                                                    kDarkGreenColor,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .only(
                                                                  top: 8.0,
                                                                  bottom: 8.0,
                                                                ),
                                                                child:
                                                                    CustomTextStyleOne(
                                                                  text:
                                                                      'Rate:  ',
                                                                  myColor:
                                                                      kDarkGreenColor,
                                                                ),
                                                              ),
                                                              CustomTextStyleOne(
                                                                text:
                                                                    'Minimum:  ',
                                                                myColor:
                                                                    kDarkGreenColor,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .only(
                                                                  top: 8.0,
                                                                  bottom: 8.0,
                                                                ),
                                                                child:
                                                                    CustomTextStyleOne(
                                                                  text:
                                                                      'Address:  ',
                                                                  myColor:
                                                                      kDarkGreenColor,
                                                                ),
                                                              ),
                                                              CustomTextStyleOne(
                                                                text:
                                                                    'PickUp Date:  ',
                                                                myColor:
                                                                    kDarkGreenColor,
                                                              ),
                                                            ],
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              CustomTextStyleOne(
                                                                text:
                                                                    productData[
                                                                        'name'],
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                  top: 8.0,
                                                                  bottom: 8.0,
                                                                ),
                                                                child:
                                                                    CustomTextStyleOne(
                                                                  text: productData[
                                                                      'rate'],
                                                                ),
                                                              ),
                                                              CustomTextStyleOne(
                                                                text: productData[
                                                                    'minimum'],
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                  top: 8.0,
                                                                  bottom: 8.0,
                                                                ),
                                                                child:
                                                                    CustomTextStyleOne(
                                                                  text: mySell[
                                                                      'customAddress'],
                                                                ),
                                                              ),
                                                              CustomTextStyleOne(
                                                                text: mySell[
                                                                        'pickupDate']
                                                                    .toString()
                                                                    .substring(
                                                                        0, 10),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 16.0),
                                                    child: SizedBox(
                                                      width: double.infinity,
                                                      height: 48,
                                                      child:
                                                          ElevatedButton.icon(
                                                        icon:
                                                            const CustomTextStyleOne(
                                                          text:
                                                              'Cancle Request',
                                                          fontSize: 20,
                                                          myColor: kWhiteColor,
                                                        ),
                                                        label: const Icon(
                                                          Icons.delete_forever,
                                                          size: 40,
                                                          color: kWhiteColor,
                                                        ),
                                                        onPressed: () async {
                                                          showDialog(
                                                            context: context,
                                                            builder: (context) =>
                                                                const WaitingDialog(
                                                                    title:
                                                                        "Processing"),
                                                          );
                                                          final result =
                                                              await SellsDatabase
                                                                  .cancleSellRequest(
                                                                      mySell[
                                                                          '_id']);
                                                          navigatorKey
                                                              .currentState!
                                                              .pop();
                                                          if (result! ~/ 100 ==
                                                              2) {
                                                            showSnackBar(
                                                              context,
                                                              'Request cancled Successfully!',
                                                              kLightGreenColor,
                                                            );
                                                            setState(() {});
                                                          } else {
                                                            showSnackBar(
                                                              context,
                                                              'Something went wrong, try again!',
                                                              Colors.red,
                                                            );
                                                          }
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          primary:
                                                              kLightRedColor,
                                                          onPrimary:
                                                              kWhiteColor,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                                  ),
                                ],
                              );
                            }),
                          );
                        }),
                      ),
                    ),
                  ),
                ),
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    loginIconWidget(),
                    ElevatedButton(
                      onPressed: () async {
                        navigatorKey.currentState!
                            .pushNamed(Signin.id)
                            .then((_) => setState(() {}));
                      },
                      style: ElevatedButton.styleFrom(
                        primary: kLightGreenColor,
                        onPrimary: kWhiteColor,
                      ),
                      child: const CustomTextStyleOne(
                        text: 'LogIn to Continue',
                        fontSize: 20,
                        myColor: kWhiteColor,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

//here userOrder will be listed
