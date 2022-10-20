import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:admin_app/custom_components/customText.dart';
import 'package:admin_app/constants/constants.dart';
import 'package:admin_app/main.dart';

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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(15),
          height: size.width > 400 ? size.height * 0.4 : size.height * 0.35,
          width: double.infinity,
          alignment: Alignment.topLeft,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                widget.args!['productImage'],
              ),
            ),
          ),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              size: 30,
              color: kLightGreenColor,
            ),
          ),
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
                          // favorite.isItemPresent(
                          //         widget.args!['index'].toString())
                          //     ? IconButton(
                          //         icon: const Icon(Icons.favorite_rounded),
                          //         color: kOrangeColor,
                          //         iconSize: 24,
                          //         tooltip: 'Remove from Favorite',
                          //         onPressed: () {
                          //           favorite.deleteFavoriteList(
                          //               widget.args!['index'].toString());
                          //           favorite.removeFavoriteItemCount();
                          //         },
                          //       )
                          //     : IconButton(
                          //         icon: const Icon(
                          //             Icons.favorite_outline_rounded),
                          //         color: kWhiteColor,
                          //         iconSize: 24,
                          //         tooltip: 'Add to Favorite',
                          //         onPressed: () {
                          //           favorite.saveFavoriteList(
                          //               widget.args!['index'].toString());
                          //           favorite.addFavoriteItemCount();
                          //         },
                          //       ),
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
          ],
        ),
      ),
    );
  }
}
