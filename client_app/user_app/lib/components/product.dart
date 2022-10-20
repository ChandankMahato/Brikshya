import 'package:animations/animations.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:user_app/custom_components/customText.dart';
import 'package:user_app/constants.dart';
import 'package:user_app/custom_components/custom_widget.dart';
import 'package:user_app/custom_components/snack_bar.dart';
import 'package:user_app/models/product_model.dart';
import 'package:user_app/provider/cart_provider.dart';
import 'package:user_app/provider/favorite_provider.dart';
import 'package:user_app/provider/filter_state.dart';
import 'package:user_app/screens/detailsPage.dart';
import 'package:user_app/services/cart.dart';
import 'package:user_app/services/favourite.dart';
import 'package:user_app/services/product.dart';
import 'package:user_app/services/storage.dart';

class ProductWidget extends StatefulWidget {
  const ProductWidget({Key? key}) : super(key: key);

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  Widget cardWidget(product, index, size) {
    final cart = Provider.of<CartProvider>(context);
    final favorite = Provider.of<FavoriteProvider>(context);

    return Container(
      height: 240,
      margin: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 8,
      ),
      child: OpenContainer(
        transitionDuration: const Duration(
          milliseconds: 500,
        ),
        transitionType: ContainerTransitionType.fadeThrough,
        closedShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        openBuilder: (context, _) => ProductDetails(args: {
          "productName": product.productName,
          "productImage": product.productImage,
          "productId": product.productId,
          "productPrice": product.productPrice,
          "productCategory": product.productCategory,
          "productDescription": product.productDescription,
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
                product.productImage == null
                    ? size.width > 500
                        ? const SizedBox(
                            height: 144,
                            width: 180,
                            child: Icon(Icons.image_not_supported,
                                size: 64, color: Colors.black45),
                          )
                        : const SizedBox(
                            height: 128,
                            width: 164,
                            child: Icon(Icons.image_not_supported,
                                size: 64, color: Colors.black45),
                          )
                    : size.width >= 500
                        ? Image.network(
                            product.productImage,
                            height: 144,
                            width: 180,
                            errorBuilder: (context, error, stackTrace) {
                              return const SizedBox(
                                height: 144,
                                width: 180,
                                child: Icon(Icons.image_not_supported,
                                    size: 64, color: Colors.black45),
                              );
                            },
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
                            product.productImage,
                            height: 128,
                            width: 164,
                            errorBuilder: (context, error, stackTrace) {
                              return const SizedBox(
                                height: 128,
                                width: 164,
                                child: Icon(Icons.image_not_supported,
                                    size: 64, color: Colors.black45),
                              );
                            },
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
                            cartFavoriteRow(index, product, favorite, cart),
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
        favorite.isItemPresent(product.productId)
            ? IconButton(
                icon: const Icon(Icons.favorite_rounded),
                color: kOrangeColor,
                iconSize: 24,
                tooltip: 'Remove from Favorite',
                onPressed: () async {
                  favorite.deleteFavoriteList(product.productId);
                  String? data = await Storage.getToken();
                  if (data != null) {
                    final result = await FavouriteDatabase.addUpdateFavourite(
                        favorite.getFavoriteList());
                    if (result! ~/ 100 == 2) {
                      showSnackBar(
                        context,
                        "Item removed from Favourite",
                        Colors.green,
                      );
                    } else {
                      favorite.saveFavoriteList(product.productId);
                      showSnackBar(
                        context,
                        "Could not remove Item From Favourite",
                        Colors.red,
                      );
                    }
                  }
                },
              )
            : IconButton(
                icon: const Icon(Icons.favorite_outline_rounded),
                color: kMediumGreenColor,
                iconSize: 24,
                tooltip: 'Add to Favorite',
                onPressed: () async {
                  favorite.saveFavoriteList(product.productId);
                  String? data = await Storage.getToken();
                  if (data != null) {
                    final result = await FavouriteDatabase.addUpdateFavourite(
                        favorite.getFavoriteList());
                    if (result! ~/ 100 == 2) {
                      showSnackBar(
                        context,
                        "Item added as Favourite",
                        Colors.green,
                      );
                    } else {
                      favorite.deleteFavoriteList(product.productId);
                      showSnackBar(
                        context,
                        "Could not add item to Favourtie",
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
                    "Item already in the cart",
                    Colors.green,
                  );
                })
            : IconButton(
                icon: const Icon(Icons.add_shopping_cart_rounded),
                color: kMediumGreenColor,
                iconSize: 32,
                tooltip: 'Add to Cart',
                onPressed: () async {
                  cart.saveCartList(product.productId, 1);
                  cart.addTotalPrice(product.productPrice.toDouble());
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
                        "Item added to Cart",
                        Colors.green,
                      );
                    } else {
                      cart.deleteCartList(product.productId);
                      cart.removeTotalPrice(product.productPrice.toDouble());
                      showSnackBar(
                        context,
                        "Could not add item to Cart",
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
              child: FutureBuilder<List>(
                future: ProductDatabase.allProduct(
                    Provider.of<FilterTypeState>(context, listen: true)
                        .filterType
                        .id),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return brikshyaLoaderSmall();
                  }
                  if (snapshot.hasError) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: networkError(),
                    );
                  }
                  if (snapshot.data!.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Image.asset(
                        'images/noproduct.png',
                        width: 180,
                        height: 164,
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
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        Products product =
                            Products.fromData(data: products[index]);
                        return cardWidget(
                          product,
                          index,
                          size,
                        );
                      });
                },
              ),
            ),
          ],
        ),
      ],
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
