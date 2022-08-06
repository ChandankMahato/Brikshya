class Populars {
  late String image;

  Populars.fromData({required Map<String, dynamic> data}) {
    image = data['image'];
  }
}
