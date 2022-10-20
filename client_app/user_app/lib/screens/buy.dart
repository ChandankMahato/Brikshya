import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:user_app/components/drawer.dart';
import 'package:user_app/constants.dart';
import 'package:user_app/custom_components/customText.dart';
import 'package:user_app/custom_components/custom_widget.dart';
import 'package:user_app/main.dart';
import 'package:user_app/models/buy_model.dart';
import 'package:user_app/screens/buyCart.dart';
import 'package:user_app/screens/home.dart';
import 'package:user_app/services/product.dart';

class BuyItemListing extends StatefulWidget {
  const BuyItemListing({Key? key}) : super(key: key);
  static const String id = "/buy";

  @override
  State<BuyItemListing> createState() => _BuyItemListingState();
}

List sellProductDetailsList = [];

class _BuyItemListingState extends State<BuyItemListing> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
              text: 'Sell Items',
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
                    FutureBuilder<List>(
                      future: ProductDatabase.allListing(),
                      builder: ((context, snapshot) {
                        if (!snapshot.hasData) {
                          return brikshyaLoader();
                        }
                        if (snapshot.hasError) {
                          return networkError();
                        }
                        if (snapshot.data!.isEmpty) {
                          return NoProductWidget(size: size);
                        }
                        final listings = snapshot.data!;

                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 16.0,
                                bottom: 16.0,
                              ),
                              child: Column(
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 8.0),
                                    child: Text(
                                      'Sell your items and services here!',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: kOrangeColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'We are in need of following:',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: kDarkGreenColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    ' Items and services!',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: kDarkGreenColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              itemCount: listings.length,
                              itemBuilder: (context, index) {
                                final itemObject =
                                    Listing.fromData(data: listings[index]);
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
                                            itemObject.image,
                                            height: 80,
                                            width: 64,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return const SizedBox(
                                                height: 128,
                                                width: 164,
                                                child: Icon(
                                                    Icons.image_not_supported,
                                                    size: 64,
                                                    color: Colors.black45),
                                              );
                                            },
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
                                                        text: itemObject.name,
                                                        weight: FontWeight.w600,
                                                      ),
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          navigatorKey
                                                              .currentState!
                                                              .pushNamed(
                                                                  BuyCart.id,
                                                                  arguments: {
                                                                "name":
                                                                    itemObject
                                                                        .name,
                                                                "image":
                                                                    itemObject
                                                                        .image,
                                                                "id": itemObject
                                                                    .id,
                                                                "minimum":
                                                                    itemObject
                                                                        .minimum,
                                                                "rate":
                                                                    itemObject
                                                                        .rate,
                                                              });
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          primary:
                                                              kLightGreenColor,
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
                                                        child:
                                                            const CustomTextStyleOne(
                                                          text: 'Sell',
                                                          fontSize: 16,
                                                          myColor: kWhiteColor,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          CustomTextStyleOne(
                                                            text: 'Rate: ' +
                                                                (itemObject
                                                                        .rate)
                                                                    .toString(),
                                                            weight:
                                                                FontWeight.w400,
                                                          ),
                                                          CustomTextStyleOne(
                                                            text: 'minimum: ' +
                                                                (itemObject
                                                                        .minimum)
                                                                    .toString(),
                                                            weight:
                                                                FontWeight.w400,
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
                          ],
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
