import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:user_app/constants.dart';
import 'package:user_app/models/popular_content.dart';

class PopularWdiget extends StatefulWidget {
  const PopularWdiget({Key? key}) : super(key: key);

  @override
  State<PopularWdiget> createState() => _PopularWdigetState();
}

class _PopularWdigetState extends State<PopularWdiget> {
  List populars = [
    {'image': 'images/popular/popular1.png'},
    {'image': 'images/popular/popular2.png'},
    {'image': 'images/popular/popular3.png'},
    {'image': 'images/popular/popular4.png'},
    {'image': 'images/popular/popular5.jpg'},
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
                'Populars',
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
            height: 150,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: populars.length,
              itemBuilder: (context, index) {
                final popular = Populars.fromData(data: populars[index]);
                return GestureDetector(
                  onTap: () {
                    print('Popular Clicked');
                  },
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 8,
                        ),
                        height: 144,
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
                          child: Image.asset(
                            popular.image,
                            height: 144,
                            width: 180,
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
