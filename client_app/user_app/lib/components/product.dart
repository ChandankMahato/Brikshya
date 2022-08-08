import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:user_app/Database/db_helper.dart';
import 'package:user_app/constants.dart';
import 'package:user_app/models/cart_model.dart';
import 'package:user_app/models/product_model.dart';
import 'package:user_app/provider/cart_provider.dart';

class ProductWidget extends StatefulWidget {
  const ProductWidget({Key? key}) : super(key: key);

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  DBHelper dbHelper = DBHelper();

  int _productCount = 4;

  List<Products> _favoriteProducts = [];

  _increaseProductCount() {
    setState(() {
      _productCount = _productCount * 2;
    });
  }

  void _toggleFavorite(Products product, String productId) {
    final existingIndex = _favoriteProducts
        .indexWhere((product) => product.productId == productId);
    print(existingIndex);
    if (existingIndex >= 0) {
      setState(() {
        _favoriteProducts.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteProducts.add(product);
      });
    }
  }

  bool _isProductFavorite(String productId) {
    return _favoriteProducts.any((product) => product.productId == productId);
  }

  List products = [
    {
      'productId': '1',
      'productImage': 'images/products/product1.png',
      'productName': 'Office Plant',
      'productPrice': 200,
      'favourite': true,
    },
    {
      'productId': '2',
      'productImage': 'images/products/product2.png',
      'productName': 'Litchi Tree',
      'productPrice': 150,
      'favourite': false,
    },
    {
      'productId': '3',
      'productImage': 'images/products/product3.jpg',
      'productName': 'Coconut Tree',
      'productPrice': 300,
      'favourite': true,
    },
    {
      'productId': '4',
      'productImage': 'images/products/product4.png',
      'productName': 'Mango Tree',
      'productPrice': 100,
      'favourite': false,
    },
    {
      'productId': '5',
      'productImage': 'images/products/product5.png',
      'productName': 'Lemon Tree',
      'productPrice': 50,
      'favourite': false,
    },
    {
      'productId': '6',
      'productImage': 'images/products/product6.png',
      'productName': 'Bonsai Tree',
      'productPrice': 2000,
      'favourite': true,
    },
    {
      'productId': '7',
      'productImage': 'images/products/product7.png',
      'productName': 'Cactus',
      'productPrice': 600,
      'favourite': false,
    },
    {
      'productId': '8',
      'productImage': 'images/products/product8.png',
      'productName': 'Decorative Plant',
      'productPrice': 1000,
      'favourite': false,
    },
  ];

  Widget _buildContent(index, size) {
    final product = Products.fromData(data: products[index]);
    final cart = Provider.of<CartProvider>(context);
    return InkWell(
      onTap: () {
        print('Product Clicked');
      },
      child: Container(
        height: 240,
        margin: const EdgeInsets.symmetric(
          horizontal: 8,
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
            shadowDarkColorEmboss: const Color.fromARGB(255, 162, 162, 162),
            oppositeShadowLightSource: false,
            intensity: 1,
            surfaceIntensity: 0.25,
            lightSource: LightSource.top,
            color: kWhiteColor,
          ),
          child: Column(
            children: [
              size.width >= 500
                  ? Image.asset(
                      product.productImage,
                      height: 144,
                      width: 180,
                    )
                  : Image.asset(
                      product.productImage,
                      height: 128,
                      width: 164,
                    ),
              Text(
                product.productName,
                style: kAppName.copyWith(
                  color: kMediumGreenColor,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'RedHatDisplay',
                  fontSize: size.width >= 500 ? 20 : 16,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: size.width >= 500 ? 16.0 : 8.0,
                  left: 16.0,
                  right: 8.0,
                ),
                child: size.width >= 500
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Rs ' + (product.productPrice).toString(),
                            style: kAppName.copyWith(
                              color: kMediumGreenColor,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'RedHatDisplay',
                              fontSize: 20,
                            ),
                          ),
                          Row(
                            children: [
                              _isProductFavorite(product.productId)
                                  ? IconButton(
                                      icon: const Icon(Icons.favorite_rounded),
                                      color: kOrangeColor,
                                      iconSize: 32,
                                      tooltip: 'Remove from Favorite',
                                      onPressed: () {
                                        _toggleFavorite(
                                            product, product.productId);
                                      },
                                    )
                                  : IconButton(
                                      icon: const Icon(
                                          Icons.favorite_outline_rounded),
                                      color: kMediumGreenColor,
                                      iconSize: 32,
                                      tooltip: 'Add to Favorite',
                                      onPressed: () {
                                        _toggleFavorite(
                                            product, product.productId);
                                      },
                                    ),
                              IconButton(
                                icon:
                                    const Icon(Icons.add_shopping_cart_rounded),
                                color: kMediumGreenColor,
                                iconSize: 32,
                                tooltip: 'Add to Cart',
                                onPressed: () {
                                  dbHelper
                                      .insert(
                                    Cart(
                                      itemId: index.toString(),
                                      productId: product.productId.toString(),
                                      productImage:
                                          product.productImage.toString(),
                                      productName:
                                          product.productName.toString(),
                                      initialPrice:
                                          product.productPrice.toInt(),
                                      productPrice:
                                          product.productPrice.toInt(),
                                      productQuantity: 1,
                                    ),
                                  )
                                      .then((value) {
                                    cart.addTotalPrice(double.parse(
                                        product.productPrice.toString()));
                                    cart.addCartItemCount();
                                    print('product is added to cart');
                                  }).onError((error, stackTrace) {
                                    print(error.toString());
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Rs ' + (product.productPrice).toString(),
                            style: kAppName.copyWith(
                              color: kMediumGreenColor,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'RedHatDisplay',
                              fontSize: 16,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 0.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _isProductFavorite(product.productId)
                                    ? IconButton(
                                        icon:
                                            const Icon(Icons.favorite_rounded),
                                        color: kOrangeColor,
                                        iconSize: 24,
                                        tooltip: 'Remove from Favorite',
                                        onPressed: () {
                                          _toggleFavorite(
                                              product, product.productId);
                                        },
                                      )
                                    : IconButton(
                                        icon: const Icon(
                                            Icons.favorite_outline_rounded),
                                        color: kMediumGreenColor,
                                        iconSize: 24,
                                        tooltip: 'Add to Favorite',
                                        onPressed: () {
                                          _toggleFavorite(
                                              product, product.productId);
                                        },
                                      ),
                                IconButton(
                                  icon: const Icon(
                                      Icons.add_shopping_cart_rounded),
                                  color: kMediumGreenColor,
                                  iconSize: 24,
                                  tooltip: 'Add to Cart',
                                  onPressed: () {
                                    dbHelper
                                        .insert(
                                      Cart(
                                          itemId: index.toString(),
                                          productId:
                                              product.productId.toString(),
                                          productImage:
                                              product.productImage.toString(),
                                          productName:
                                              product.productName.toString(),
                                          initialPrice:
                                              product.productPrice.toInt(),
                                          productPrice:
                                              product.productPrice.toInt(),
                                          productQuantity: 1),
                                    )
                                        .then((value) {
                                      cart.addTotalPrice(double.parse(
                                          product.productPrice.toString()));
                                      cart.addCartItemCount();
                                      print('product is added to cart');
                                    }).onError((error, stackTrace) {
                                      print(error.toString());
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
              )
            ],
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
            child: Text(
              'Products',
              style: kAppName.copyWith(
                color: kDarkGreenColor,
                fontWeight: FontWeight.w600,
                fontFamily: 'RedHatDisplay',
                fontSize: 24,
              ),
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
              child: GridView.builder(
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
                itemBuilder: (context, index) => _buildContent(index, size),
              ),
            ),
            InkWell(
              onTap: _increaseProductCount,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Loadmore',
                    style: kAppName.copyWith(
                      color: kBlackColor,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'RedHatDisplay',
                      fontSize: 20,
                    ),
                  ),
                  IconButton(
                    onPressed: _increaseProductCount,
                    icon: const Icon(Icons.download),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
