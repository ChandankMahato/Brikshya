import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:user_app/constants.dart';
import 'package:user_app/models/product_content.dart';

class ProductWidget extends StatefulWidget {
  const ProductWidget({Key? key}) : super(key: key);

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  int _productCount = 4;

  _increaseProductCount() {
    setState(() {
      _productCount = _productCount * 2;
    });
  }

  List products = [
    {
      'image': 'images/products/product1.png',
      'name': 'Office Plant',
      'price': 200,
      'favourite': true,
    },
    {
      'image': 'images/products/product2.png',
      'name': 'Litchi Tree',
      'price': 150,
      'favourite': false,
    },
    {
      'image': 'images/products/product3.jpg',
      'name': 'Coconut Tree',
      'price': 300,
      'favourite': true,
    },
    {
      'image': 'images/products/product4.png',
      'name': 'Mango Tree',
      'price': 100,
      'favourite': false,
    },
    {
      'image': 'images/products/product5.png',
      'name': 'Lemon Tree',
      'price': 50,
      'favourite': false,
    },
    {
      'image': 'images/products/product6.png',
      'name': 'Bonsai Tree',
      'price': 2000,
      'favourite': true,
    },
    {
      'image': 'images/products/product7.png',
      'name': 'Cactus',
      'price': 600,
      'favourite': false,
    },
    {
      'image': 'images/products/product8.png',
      'name': 'Decorative Plant',
      'price': 1000,
      'favourite': false,
    },
  ];

  Widget _buildContent(index) {
    final product = Products.fromData(data: products[index]);
    return GestureDetector(
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
            lightSource: LightSource.topLeft,
            color: kWhiteColor,
          ),
          child: Column(
            children: [
              Image.asset(
                product.image,
                height: 144,
                width: 180,
              ),
              Text(
                product.name,
                style: kAppName.copyWith(
                  color: kLightGreenColor,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'RedHatDisplay',
                  fontSize: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Rs ' + (product.price).toString(),
                      style: kAppName.copyWith(
                        color: kLightGreenColor,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'RedHatDisplay',
                        fontSize: 20,
                      ),
                    ),
                    Row(
                      children: [
                        product.favourite == true
                            ? IconButton(
                                icon: const Icon(Icons.favorite_rounded),
                                color: kOrangeColor,
                                iconSize: 24,
                                tooltip: 'Remove from Favorite',
                                onPressed: () {},
                              )
                            : IconButton(
                                icon:
                                    const Icon(Icons.favorite_outline_rounded),
                                color: kLightGreenColor,
                                iconSize: 24,
                                tooltip: 'Add to Favorite',
                                onPressed: () {},
                              ),
                        IconButton(
                          icon: const Icon(Icons.add_shopping_cart_rounded),
                          color: kLightGreenColor,
                          iconSize: 32,
                          tooltip: 'Add to Cart',
                          onPressed: () {},
                        ),
                      ],
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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 16,
            top: 24,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Products',
                style: kAppName.copyWith(
                  color: kLightGreenColor,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'RedHatDisplay',
                  fontSize: 24,
                ),
              ),
            ],
          ),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 12.0,
                right: 12.0,
              ),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 260,
                  crossAxisCount: 2,
                ),
                itemCount: _productCount > products.length
                    ? products.length
                    : _productCount,
                itemBuilder: (context, index) => _buildContent(index),
              ),
            ),
            GestureDetector(
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
