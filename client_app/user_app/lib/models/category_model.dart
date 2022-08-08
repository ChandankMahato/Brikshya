class Categorys {
  late String image;
  late String title;

  Categorys.fromData({required Map<String, dynamic> data}) {
    image = data['image'];
    title = data['title'];
  }
}
