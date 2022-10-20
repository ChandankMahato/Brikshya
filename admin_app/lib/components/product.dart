import 'package:admin_app/screens/product_details.dart';
import 'package:admin_app/secrets/secrets.dart';
import 'package:admin_app/services/database.dart';
import 'package:admin_app/state/fliter_type_state.dart';
import 'package:animations/animations.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
// import 'package:provider/provider.dart';
import 'package:admin_app/custom_components/customText.dart';
import 'package:admin_app/constants/constants.dart';
import 'package:admin_app/models/product_model.dart';
import 'package:provider/provider.dart';
// import 'package:admin_app/screens/detailsPage.dart';

class ProductWidget extends StatefulWidget {
  const ProductWidget({Key? key}) : super(key: key);

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  int _productCount = 4;

  _increaseProductCount() {
    setState(() {
      _productCount = _productCount + 4;
    });
  }

  Widget cardWidget(Product product, size, index) {
    return Container(
      height: 240,
      margin: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 8,
      ),
      // padding: const EdgeInsets.symmetric(
      //   horizontal: 10.0,
      //   vertical: 10.0,
      // ),
      child: OpenContainer(
        transitionDuration: const Duration(
          milliseconds: 500,
        ),
        transitionType: ContainerTransitionType.fadeThrough,
        closedShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        openBuilder: (context, _) => ProductDetails(args: {
          "index": index,
          "productName": product.name,
          "productImage": product.image,
          "productId": product.id,
          "productPrice": product.price,
          "productCategory": product.category,
          "productDescription": product.description,
          "productStock": product.stock,
          "productAskUser": product.askUser,
        }),
        closedBuilder: (context, VoidCallback openContainer) => InkWell(
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
                product.image == null
                    ? Container(
                        height: 32,
                        width: 32,
                        decoration: const BoxDecoration(
                          color: kDarkGreenColor,
                          shape: BoxShape.circle,
                        ),
                      )
                    : size.width >= 500
                        ? Image.network(
                            "${API.endPoint}${API.image}${product.name.toLowerCase().split(' ').join('-')}.png",
                            height: 144.0,
                            width: 180.0,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                    kDarkGreenColor,
                                  ),
                                  backgroundColor:
                                      kDarkGreenColor.withOpacity(0.5),
                                ),
                              );
                            },
                          )
                        : Image.network(
                            "${API.endPoint}${API.image}${product.name.toLowerCase().split(' ').join('-')}.png",
                            height: 128.0,
                            width: 164.0,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                    kDarkGreenColor,
                                  ),
                                  backgroundColor:
                                      kDarkGreenColor.withOpacity(0.5),
                                ),
                              );
                            },
                          ),
                CustomTextStyleOne(
                  text: product.name,
                  fontFamily: 'RedHatDisplay',
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
                            CustomTextStyleOne(
                              text: 'Rs ${product.price.toString()}',
                            ),
                            // cartFavoriteRow(index, product, favorite, cart),
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomTextStyleOne(
                              text: 'Rs ${product.price.toString()}',
                            ),
                          ],
                        ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: size.width >= 500 ? 16.0 : 8.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTextStyleOne(
                        text: 'Stock ${product.stock.toString()}',
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: size.width >= 500 ? 16.0 : 8.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTextStyleOne(
                        text: 'Ask User: ${product.askUser ? "Yes" : "No"}',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 16,
            top: 24,
          ),
          child: Align(
            alignment:
                size.width > 850 ? Alignment.center : Alignment.centerLeft,
            child: CustomTextStyleOne(
              text: Provider.of<FilterTypeState>(context, listen: true)
                  .filterType
                  .title,
              fontSize: 24,
              weight: FontWeight.w600,
              myColor: kDarkGreenColor,
              fontFamily: 'RedHatDisplay',
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
              child: FutureBuilder<List>(
                  future: Database.getAllProducts(
                      Provider.of<FilterTypeState>(context, listen: true)
                          .filterType
                          .id),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            kDarkGreenColor,
                          ),
                          backgroundColor: kDarkGreenColor.withOpacity(0.5),
                        ),
                      );
                    }
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text(
                          'Network Error!',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                          ),
                        ),
                      );
                    }

                    if (snapshot.data!.isEmpty) {
                      return Center(
                        child: Text(
                          'No ${Provider.of<FilterTypeState>(context, listen: true).filterType.title}!',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                          ),
                        ),
                      );
                    }
                    final products = snapshot.data!;
                    return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisExtent: size.width >= 500 ? 260 : 245,
                          crossAxisCount: size.width > 650
                              ? size.width > 850
                                  ? 4
                                  : 3
                              : 2,
                        ),
                        itemCount: _productCount > products.length
                            ? products.length
                            : _productCount,
                        itemBuilder: (context, index) {
                          Product product =
                              Product.fromData(data: products[index]);
                          return cardWidget(product, size, index);
                        });
                  }),
            ),
          ],
        ),
      ],
    );
  }
}
