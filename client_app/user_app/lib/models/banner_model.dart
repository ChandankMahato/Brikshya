class Banners {
  late String image;

  Banners.fromData({required Map<String, dynamic> data}) {
    image = data['image'];
  }
}
