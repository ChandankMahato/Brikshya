class SplashContent {
  String image;
  String title;
  String description;

  SplashContent({
    required this.image,
    required this.title,
    required this.description,
  });
}

List<SplashContent> splashContents = [
  SplashContent(
    image: 'images/logo.png',
    title: 'Brikshya',
    description: 'Connected to soil',
  ),
];

class OnBoardingContent {
  late String image;
  late String title;
  late String description;

  OnBoardingContent.fromData({required Map<String, dynamic> data}) {
    image = data['image'];
    title = data['title'];
    description = data['description'];
  }
}
