class Products {
  late String productId;
  late String productImage;
  late String productName;
  late int productPrice;
  late bool favourite;

  Products.fromData({required Map<String, dynamic> data}) {
    productId = data['productId'];
    productImage = data['productImage'];
    productName = data['productName'];
    productPrice = data['productPrice'];
    favourite = data['favourite'];
  }
}
