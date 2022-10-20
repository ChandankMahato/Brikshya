class Categories {
  late String id;
  late String? image;
  late String title;

  Categories.fromData({required Map<String, dynamic> data}) {
    id = data["_id"];
    image = data['image'];
    title = data['title'];
  }
}
