class Category {
  late String id;
  late String? image;
  late String title;

  Category.fromData({required Map<String, dynamic> data}) {
    id = data["_id"];
    image = data['image'];
    title = data['title'];
  }
}
