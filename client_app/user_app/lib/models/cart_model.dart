class Cart {
  late String itemId;
  late String productId;
  late String productImage;
  late String productName;
  late int initialPrice;
  late int productPrice;
  late int productQuantity;

  Cart({
    required this.itemId,
    required this.productId,
    required this.productName,
    required this.initialPrice,
    required this.productPrice,
    required this.productImage,
    required this.productQuantity,
  });

  Cart.fromMap(Map<dynamic, dynamic> data) {
    itemId = data['itemId'];
    productId = data['productId'];
    productImage = data['productImage'];
    productName = data['productName'];
    initialPrice = data['initialPrice'];
    productPrice = data['productPrice'];
    productQuantity = data['productQuantity'];
  }

  Map<String, Object> toMap() {
    return {
      'itemId': itemId,
      'productId': productId,
      'productImage': productImage,
      'productName': productName,
      'initialPrice': initialPrice,
      'productPrice': productPrice,
      'productQuantity': productQuantity
    };
  }
}
