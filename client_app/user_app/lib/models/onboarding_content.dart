class UnboardingContent {
  String image;
  String title;
  String description;

  UnboardingContent({
    required this.image,
    required this.title,
    required this.description,
  });
}

List<UnboardingContent> onBoardingContents = [
  UnboardingContent(
    image: 'images/onboarding/logo.png',
    title: 'Brikshya',
    description: 'Connected to soil',
  ),
  UnboardingContent(
    image: 'images/onboarding/splash1.png',
    title: 'Welcome to Brikshya',
    description:
        'One-stop platform to buy and sell nursery items, Join events and training, and employment services',
  ),
];
