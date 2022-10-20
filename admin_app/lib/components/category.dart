import 'package:admin_app/services/database.dart';
import 'package:admin_app/state/fliter_type_state.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:admin_app/custom_components/customText.dart';
import 'package:admin_app/constants/constants.dart';
import 'package:admin_app/models/category_model.dart';
import 'package:provider/provider.dart';

class CategorysWidget extends StatefulWidget {
  const CategorysWidget({Key? key}) : super(key: key);

  @override
  State<CategorysWidget> createState() => _CategorysWidgetState();
}

class _CategorysWidgetState extends State<CategorysWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 16,
            top: 24,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.only(bottom: 10.0),
              child: const CustomTextStyleOne(
                text: 'Category',
                fontSize: 24,
                weight: FontWeight.w600,
                myColor: kDarkGreenColor,
                fontFamily: 'RedHatDisplay',
              ),
            ),
          ),
        ),
        FutureBuilder<List>(
            future: Database.getCategories(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator(
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    kDarkGreenColor,
                  ),
                  backgroundColor: kDarkGreenColor.withOpacity(0.5),
                );
              }
              if (snapshot.hasError) {
                return const Center(
                  child: Text(
                    'Network Error!',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                    ),
                  ),
                );
              }

              if (snapshot.data!.isEmpty) {
                return const Center(
                  child: Text(
                    'No categories!',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                    ),
                  ),
                );
              }
              final categories = snapshot.data!;
              categories.insert(0, {"_id": "All", "title": "All"});
              return Padding(
                padding: const EdgeInsets.only(
                  left: 12.0,
                  right: 12.0,
                ),
                child: SizedBox(
                  height: 50,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category =
                          Category.fromData(data: categories[index]);
                      return InkWell(
                        onTap: () {
                          Provider.of<FilterTypeState>(context, listen: false)
                              .changeState(category);
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
                                  lightSource: LightSource.top,
                                  color: kWhiteColor,
                                ),
                                child: Row(
                                  children: [
                                    index != 0
                                        ? Padding(
                                            padding: const EdgeInsets.all(4),
                                            child: category.image == null
                                                ? Container(
                                                    height: 32,
                                                    width: 32,
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: kDarkGreenColor,
                                                      shape: BoxShape.circle,
                                                    ),
                                                  )
                                                : Image.network(
                                                    category.image!,
                                                    height: 32.0,
                                                    width: 32.0,
                                                    loadingBuilder: (BuildContext
                                                            context,
                                                        Widget child,
                                                        ImageChunkEvent?
                                                            loadingProgress) {
                                                      if (loadingProgress ==
                                                          null) {
                                                        return child;
                                                      }
                                                      return Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                          value: loadingProgress
                                                                      .expectedTotalBytes !=
                                                                  null
                                                              ? loadingProgress
                                                                      .cumulativeBytesLoaded /
                                                                  loadingProgress
                                                                      .expectedTotalBytes!
                                                              : null,
                                                          valueColor:
                                                              const AlwaysStoppedAnimation<
                                                                  Color>(
                                                            kDarkGreenColor,
                                                          ),
                                                          backgroundColor:
                                                              kDarkGreenColor
                                                                  .withOpacity(
                                                                      0.5),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                          )
                                        : Container(
                                            padding: const EdgeInsets.only(
                                              left: 8.0,
                                            ),
                                          ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        right: 8,
                                      ),
                                      child: CustomTextStyleOne(
                                        text: category.title,
                                        myColor: kBlackColor,
                                        fontFamily: 'ReadHatDisplay',
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
              );
            }),
      ],
    );
  }
}
