import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:user_app/constants.dart';
import 'package:user_app/models/category_content.dart';

class CategorysWidget extends StatefulWidget {
  const CategorysWidget({Key? key}) : super(key: key);

  @override
  State<CategorysWidget> createState() => _CategorysWidgetState();
}

class _CategorysWidgetState extends State<CategorysWidget> {
  List categorys = [
    {'image': 'images/categorys/bonsai.png', 'title': 'Bonsai'},
    {'image': 'images/categorys/cactus.png', 'title': 'Cactus'},
    {'image': 'images/categorys/decorative.png', 'title': 'Decorative'},
    {'image': 'images/categorys/garden.png', 'title': 'Garden'},
    {'image': 'images/categorys/hanging.png', 'title': 'Hanging'},
    {'image': 'images/categorys/office.jpg', 'title': 'Office'},
    {'image': 'images/categorys/ornamental.png', 'title': 'Ornamental'},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 16,
            top: 24,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Category',
                style: kAppName.copyWith(
                  color: kLightGreenColor,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'RedHatDisplay',
                  fontSize: 24,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Text(
                      'See All',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.forward_sharp,
                      ),
                      color: kMediumGreenColor,
                      iconSize: 24,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 12.0,
            right: 12.0,
          ),
          child: SizedBox(
            height: 50,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: categorys.length,
              itemBuilder: (context, index) {
                final category = Categorys.fromData(data: categorys[index]);
                return GestureDetector(
                  onTap: () {
                    print('Category Clicked');
                  },
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 8,
                        ),
                        height: 48,
                        child: Neumorphic(
                          style: NeumorphicStyle(
                            border: const NeumorphicBorder(width: 1),
                            depth: -3,
                            boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(15),
                            ),
                            shadowLightColorEmboss: Colors.white,
                            shadowDarkColorEmboss:
                                const Color.fromARGB(255, 162, 162, 162),
                            oppositeShadowLightSource: false,
                            intensity: 1,
                            surfaceIntensity: 0.25,
                            lightSource: LightSource.topLeft,
                            color: kWhiteColor,
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4),
                                child: Image.asset(
                                  category.image,
                                  height: 32,
                                  width: 32,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 8,
                                ),
                                child: Text(
                                  category.title,
                                  style: kAppName.copyWith(
                                    color: kBlackColor,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'RedHatDisplay',
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
