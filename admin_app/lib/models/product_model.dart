class Product {
  late String id;
  late String? image;
  late String name;
  late String category;
  late int price;
  late String description;
  late int stock;
  late bool askUser;

  Product.fromData({required Map<String, dynamic> data}) {
    id = data['_id'];
    image = data['image'];
    name = data['name'];
    category = data['category'];
    price = data['price'];
    description = data['description'];
    stock = data['stock'];
    askUser = data['askUser'];
  }
}
