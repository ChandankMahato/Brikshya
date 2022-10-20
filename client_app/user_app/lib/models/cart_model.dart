import 'package:user_app/secrets/secrets.dart';

class Cart {
  late String product;
  late int quantity;

  Cart({
    required this.product,
    required this.quantity,
  });

  Cart.fromData({required Map<String, dynamic> data}) {
    product = data['product'];
    quantity = data['quantity'];
  }
}

class CartProduct {
  late String productId;
  late int productQuantity;
  late String productImage;
  late String productName;
  late String productCategory;
  late int productPrice;
  late String productDescription;

  CartProduct.fromData({required Map<String, dynamic> data}) {
    productId = data['_id'];
    productQuantity = data['quantity'];
    productImage = data['image'];
    productName = data['name'];
    productCategory = data['category'];
    productPrice = data['price'];
    productDescription = data['description'];
  }
}
