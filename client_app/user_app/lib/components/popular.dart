import 'dart:math';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:user_app/custom_components/customText.dart';
import 'package:user_app/constants.dart';
import 'package:user_app/provider/horizontal_scroll.dart';

class PopularWdiget extends StatefulWidget {
  const PopularWdiget({Key? key}) : super(key: key);

  @override
  State<PopularWdiget> createState() => _PopularWdigetState();
}

class _PopularWdigetState extends State<PopularWdiget> {
  List populars = [
    {'image': 'images/popular1.png'},
    {'image': 'images/popular2.png'},
    {'image': 'images/popular3.png'},
    {'image': 'images/popular4.png'},
    {'image': 'images/popular5.jpg'},
  ];

  final scrollController = ItemScrollController();
  void scrollToIndex(int index) {
    scrollController.scrollTo(
      index: index,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final scrollState = Provider.of<ScrollState>(context, listen: false);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 16,
            top: 24,
          ),
          child: Row(
            mainAxisAlignment: size.width > 850
                ? MainAxisAlignment.center
                : MainAxisAlignment.spaceBetween,
            children: [
              const CustomTextStyleOne(
                text: 'Populars',
                myColor: kDarkGreenColor,
                fontSize: 24,
                weight: FontWeight.w600,
                fontFamily: redhat,
              ),
              size.width < 850
                  ? Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                        right: 12.0,
                        top: 8.0,
                        bottom: 8.0,
                      ),
                      child: IconButton(
                        icon: Provider.of<ScrollState>(context, listen: true)
                                .isLastPopular
                            ? Transform.rotate(
                                angle: 180 * pi / 180,
                                child: const Icon(Icons.forward_sharp),
                              )
                            : const Icon(Icons.forward_sharp),
                        color: kDarkGreenColor,
                        iconSize: 24,
                        splashColor: kLightGreenColor.withOpacity(0.3),
                        splashRadius: 30.0,
                        onPressed: () {
                          if (scrollState.isLastPopular) {
                            scrollState.changePopularCurrentIndex(
                                scrollState.popularCurrentIndex - 1);
                            if (scrollState.popularCurrentIndex == 0) {
                              scrollState.changePopularState(false);
                              setState(() {});
                            }
                          } else {
                            scrollState.changePopularCurrentIndex(
                                scrollState.popularCurrentIndex + 1);
                            if (scrollState.popularCurrentIndex + 1 ==
                                scrollState.popularListLength) {
                              scrollState.changePopularState(true);
                              setState(() {});
                            }
                          }
                          scrollToIndex(scrollState.popularCurrentIndex);
                        },
                      ),
                    )
                  : Container(),
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
            child: ScrollablePositionedList.builder(
              itemScrollController: scrollController,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: populars.length,
              itemBuilder: (context, index) {
                scrollState.changePopularListLength(populars.length);
                final popular = populars[index];
                return InkWell(
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
                            lightSource: LightSource.top,
                            color: kWhiteColor,
                          ),
                          child: Image.asset(
                            popular['image'],
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
