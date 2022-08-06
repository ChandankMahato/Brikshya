class Products {
  late String image;
  late String name;
  late int price;
  late bool favourite;

  Products.fromData({required Map<String, dynamic> data}) {
    image = data['image'];
    name = data['name'];
    price = data['price'];
    favourite = data['favourite'];
  }
}
