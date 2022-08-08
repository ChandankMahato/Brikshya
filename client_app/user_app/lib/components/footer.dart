// Responsive footer

import 'package:flutter/material.dart';
import 'package:user_app/constants.dart';
import 'package:user_app/models/category_model.dart';
import 'package:user_app/models/onboarding_model.dart';

class FooterWidget extends StatefulWidget {
  const FooterWidget({Key? key}) : super(key: key);

  @override
  State<FooterWidget> createState() => _FooterWidgetState();
}

class _FooterWidgetState extends State<FooterWidget> {
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
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(
            color: kBlackColor,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              top: 16,
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 72,
                  height: 72,
                  child: Image.asset(
                    splashContents[0].image,
                  ),
                ),
                Text(
                  'Brikshya',
                  style: kAppName.copyWith(
                    color: kMediumGreenColor,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'RedHatDisplay',
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
          size.width > 950
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 16.0,
                            top: 32.0,
                          ),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            width: 270,
                            height: 64,
                            decoration: BoxDecoration(
                              border: Border.all(),
                            ),
                            child: const ListTile(
                              leading: Icon(
                                Icons.location_on_outlined,
                                size: 48,
                                color: kMediumGreenColor,
                              ),
                              title: Text(
                                'Raghunathpur, Lahan3 Siraha, Nepal',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 16.0,
                            top: 8.0,
                          ),
                          child: Text(
                            'Always open',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 16.0,
                          ),
                          child: Text(
                            'Need help',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: kBlackColor,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            print('Call now');
                          },
                          child: const SizedBox(
                            width: 300,
                            child: ListTile(
                              leading: Icon(
                                Icons.phone_in_talk_outlined,
                                size: 48,
                                color: kOrangeColor,
                              ),
                              title: HeadingCustomTextStyle(
                                text: '+977-9811771892',
                              ),
                              subtitle: Text(
                                'Sun-Fri: 9:00 - 20:00',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        print('Send email');
                      },
                      child: const SizedBox(
                        width: 360,
                        child: ListTile(
                          leading: Icon(
                            Icons.mail_outlined,
                            size: 48,
                            color: kOrangeColor,
                          ),
                          title: Text(
                            'brikshya.nursery@gmail.com',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 16.0,
                            top: 32.0,
                          ),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            width: 270,
                            height: 64,
                            decoration: BoxDecoration(
                              border: Border.all(),
                            ),
                            child: const ListTile(
                              leading: Icon(
                                Icons.location_on_outlined,
                                size: 48,
                                color: kMediumGreenColor,
                              ),
                              title: Text(
                                'Raghunathpur, Lahan3 Siraha, Nepal',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 16.0,
                            top: 8.0,
                          ),
                          child: Text(
                            'Always open',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 16.0,
                            top: 48.0,
                          ),
                          child: Text(
                            'Need help',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: kBlackColor,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            print('Call now');
                          },
                          child: const ListTile(
                            leading: Icon(
                              Icons.phone_in_talk_outlined,
                              size: 48,
                              color: kOrangeColor,
                            ),
                            title: HeadingCustomTextStyle(
                              text: '+977-9811771892',
                            ),
                            subtitle: Text(
                              'Sun-Fri: 9:00 - 20:00',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        print('Send email');
                      },
                      child: const ListTile(
                        leading: Icon(
                          Icons.mail_outlined,
                          size: 48,
                          color: kOrangeColor,
                        ),
                        title: Text(
                          'brikshya.nursery@gmail.com',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
          size.width < 850
              ? const Padding(
                  padding: EdgeInsets.only(
                    left: 16.0,
                    top: 48.0,
                  ),
                  child: HeadingCustomTextStyle(
                    text: 'Categories',
                  ),
                )
              : Container(),
          size.width > 850
              ? Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: size.width / 2,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 20.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(
                                  bottom: 32.0,
                                ),
                                child: HeadingCustomTextStyle(
                                  text: 'Categories',
                                ),
                              ),
                              GridView.builder(
                                itemCount: categorys.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 8,
                                  mainAxisExtent: 32,
                                ),
                                itemBuilder: (contex, index) {
                                  final category = Categorys.fromData(
                                      data: categorys[index]);
                                  return InkWell(
                                    onTap: () {
                                      print('Category Clicked');
                                    },
                                    child: CustomTextStyle(
                                      text: category.title,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const HeadingCustomTextStyle(
                                  text: 'Account',
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 16.0),
                                  child: InkWell(
                                    onTap: () {
                                      print('my account');
                                    },
                                    child: const CustomTextStyle(
                                      text: 'My account',
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 16.0),
                                  child: InkWell(
                                    onTap: () {
                                      print('My orders');
                                    },
                                    child: const CustomTextStyle(
                                      text: 'My orders',
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 16.0),
                                  child: InkWell(
                                    onTap: () {
                                      print('Jobs');
                                    },
                                    child: const CustomTextStyle(
                                      text: 'Jobs',
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 16.0),
                                  child: InkWell(
                                    onTap: () {
                                      print('Events');
                                    },
                                    child: const CustomTextStyle(
                                      text: 'Events',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 96.0,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const HeadingCustomTextStyle(
                                    text: 'Store',
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 16.0),
                                    child: InkWell(
                                      onTap: () {
                                        print('Store location');
                                      },
                                      child: const CustomTextStyle(
                                        text: 'Store Location',
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 16.0),
                                    child: InkWell(
                                      onTap: () {
                                        print('Offers');
                                      },
                                      child: const CustomTextStyle(
                                        text: 'Offer',
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 16.0),
                                    child: InkWell(
                                      onTap: () {
                                        print('Latest products');
                                      },
                                      child: const CustomTextStyle(
                                        text: 'Latest products',
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 16.0),
                                    child: InkWell(
                                      onTap: () {
                                        print('sale');
                                      },
                                      child: const CustomTextStyle(
                                        text: 'sale',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20.0,
                        top: 16.0,
                      ),
                      child: GridView.builder(
                        itemCount: categorys.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: 32,
                        ),
                        itemBuilder: (contex, index) {
                          final category =
                              Categorys.fromData(data: categorys[index]);
                          return InkWell(
                            onTap: () {
                              print('Category Clicked');
                            },
                            child: CustomTextStyle(
                              text: category.title,
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 32.0,
                        left: 16.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const HeadingCustomTextStyle(
                                text: 'Account',
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 16.0),
                                child: InkWell(
                                  onTap: () {
                                    print('my account');
                                  },
                                  child: const CustomTextStyle(
                                    text: 'My account',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 16.0),
                                child: InkWell(
                                  onTap: () {
                                    print('My orders');
                                  },
                                  child: const CustomTextStyle(
                                    text: 'My orders',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 16.0),
                                child: InkWell(
                                  onTap: () {
                                    print('Jobs');
                                  },
                                  child: const CustomTextStyle(
                                    text: 'Jobs',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 16.0),
                                child: InkWell(
                                  onTap: () {
                                    print('Events');
                                  },
                                  child: const CustomTextStyle(
                                    text: 'Events',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: size.width > 450
                                  ? size.width > 550
                                      ? size.width > 650
                                          ? 228
                                          : 180
                                      : 132
                                  : 48.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const HeadingCustomTextStyle(
                                  text: 'Store',
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 16.0),
                                  child: InkWell(
                                    onTap: () {
                                      print('Store location');
                                    },
                                    child: const CustomTextStyle(
                                      text: 'Store Location',
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 16.0),
                                  child: InkWell(
                                    onTap: () {
                                      print('Offers');
                                    },
                                    child: const CustomTextStyle(
                                      text: 'Offer',
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 16.0),
                                  child: InkWell(
                                    onTap: () {
                                      print('Latest products');
                                    },
                                    child: const CustomTextStyle(
                                      text: 'Latest products',
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 16.0),
                                  child: InkWell(
                                    onTap: () {
                                      print('sale');
                                    },
                                    child: const CustomTextStyle(
                                      text: 'sale',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
          Padding(
            padding: const EdgeInsets.only(
              top: 32.0,
            ),
            child: Column(
              crossAxisAlignment: size.width > 850
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: size.width > 850 ? 0.0 : 16.0),
                  child: InkWell(
                    onTap: () {
                      print('About us');
                    },
                    child: const HeadingCustomTextStyle(
                      text: 'About us',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 32.0,
                  ),
                  child: Row(
                    mainAxisAlignment: size.width > 850
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 32.0),
                        child: InkWell(
                          onTap: () {
                            print('Privacy policy');
                          },
                          child: const CustomTextStyle(
                            text: 'Privacy Policy',
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          print('Terms & Conditions');
                        },
                        child: const CustomTextStyle(
                          text: 'Terms & Conditions',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(
              top: 16.0,
              bottom: 16.0,
            ),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'Copyright Ⓒ 2022 Brikshya. All Right Reserved',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black54,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTextStyle extends StatelessWidget {
  final String text;
  const CustomTextStyle({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.black54,
        fontSize: 20,
      ),
    );
  }
}

class HeadingCustomTextStyle extends StatelessWidget {
  final String text;
  const HeadingCustomTextStyle({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: kBlackColor,
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:user_app/constants.dart';
// import 'package:user_app/models/category_content.dart';
// import 'package:user_app/models/onboarding_content.dart';

// class FooterWidget extends StatefulWidget {
//   const FooterWidget({Key? key}) : super(key: key);

//   @override
//   State<FooterWidget> createState() => _FooterWidgetState();
// }

// class _FooterWidgetState extends State<FooterWidget> {
//   List categorys = [
//     {'image': 'images/categorys/bonsai.png', 'title': 'Bonsai'},
//     {'image': 'images/categorys/cactus.png', 'title': 'Cactus'},
//     {'image': 'images/categorys/decorative.png', 'title': 'Decorative'},
//     {'image': 'images/categorys/garden.png', 'title': 'Garden'},
//     {'image': 'images/categorys/hanging.png', 'title': 'Hanging'},
//     {'image': 'images/categorys/office.jpg', 'title': 'Office'},
//     {'image': 'images/categorys/ornamental.png', 'title': 'Ornamental'},
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 24.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(
//               left: 8.0,
//               top: 16,
//             ),
//             child: Row(
//               children: [
//                 SizedBox(
//                   width: 72,
//                   height: 72,
//                   child: Image.asset(
//                     splashContents[0].image,
//                   ),
//                 ),
//                 Text(
//                   'Brikshya',
//                   style: kAppName.copyWith(
//                     color: kMediumGreenColor,
//                     fontWeight: FontWeight.w600,
//                     fontFamily: 'RedHatDisplay',
//                     fontSize: 24,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(
//               left: 16.0,
//               top: 32.0,
//             ),
//             child: Container(
//               alignment: Alignment.centerLeft,
//               width: 270,
//               height: 64,
//               decoration: BoxDecoration(
//                 border: Border.all(),
//               ),
//               child: const ListTile(
//                 leading: Icon(
//                   Icons.location_on_outlined,
//                   size: 48,
//                   color: kMediumGreenColor,
//                 ),
//                 title: Text(
//                   'Raghunathpur, Lahan3 Siraha, Nepal',
//                   style: TextStyle(
//                     fontSize: 16,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           const Padding(
//             padding: EdgeInsets.only(
//               left: 16.0,
//               top: 8.0,
//             ),
//             child: Text(
//               'Always open',
//               style: TextStyle(
//                 fontSize: 15,
//                 color: Colors.black54,
//               ),
//             ),
//           ),
//           const Padding(
//             padding: EdgeInsets.only(
//               left: 16.0,
//               top: 48.0,
//             ),
//             child: Text(
//               'Need help',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//                 color: kBlackColor,
//               ),
//             ),
//           ),
//           InkWell(
//             onTap: () {
//               print('Call now');
//             },
//             child: const ListTile(
//               leading: Icon(
//                 Icons.phone_in_talk_outlined,
//                 size: 48,
//                 color: kOrangeColor,
//               ),
//               title: HeadingCustomTextStyle(
//                 text: '+977-9811771892',
//               ),
//               subtitle: Text(
//                 'Sun-Fri: 9:00 - 20:00',
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Colors.black54,
//                 ),
//               ),
//             ),
//           ),
//           const Divider(
//             color: kBlackColor,
//           ),
//           InkWell(
//             onTap: () {
//               print('Send email');
//             },
//             child: const ListTile(
//               leading: Icon(
//                 Icons.mail_outlined,
//                 size: 48,
//                 color: kOrangeColor,
//               ),
//               title: Text(
//                 'brikshya.nursery@gmail.com',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.black54,
//                 ),
//               ),
//             ),
//           ),
//           const Padding(
//             padding: EdgeInsets.only(
//               left: 16.0,
//               top: 48.0,
//             ),
//             child: HeadingCustomTextStyle(
//               text: 'Categories',
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(
//               left: 20.0,
//               top: 16.0,
//             ),
//             child: GridView.builder(
//               itemCount: categorys.length,
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 mainAxisExtent: 32,
//               ),
//               itemBuilder: (contex, index) {
//                 final category = Categorys.fromData(data: categorys[index]);
//                 return InkWell(
//                   onTap: () {
//                     print('Category Clicked');
//                   },
//                   child: CustomTextStyle(
//                     text: category.title,
//                   ),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(
//               top: 32.0,
//               left: 16.0,
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const HeadingCustomTextStyle(
//                       text: 'Account',
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 16.0),
//                       child: InkWell(
//                         onTap: () {
//                           print('my account');
//                         },
//                         child: const CustomTextStyle(
//                           text: 'My account',
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 16.0),
//                       child: InkWell(
//                         onTap: () {
//                           print('My orders');
//                         },
//                         child: const CustomTextStyle(
//                           text: 'My orders',
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 16.0),
//                       child: InkWell(
//                         onTap: () {
//                           print('Jobs');
//                         },
//                         child: const CustomTextStyle(
//                           text: 'Jobs',
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 16.0),
//                       child: InkWell(
//                         onTap: () {
//                           print('Events');
//                         },
//                         child: const CustomTextStyle(
//                           text: 'Events',
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 96.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const HeadingCustomTextStyle(
//                         text: 'Store',
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 16.0),
//                         child: InkWell(
//                           onTap: () {
//                             print('Store location');
//                           },
//                           child: const CustomTextStyle(
//                             text: 'Store Location',
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 16.0),
//                         child: InkWell(
//                           onTap: () {
//                             print('Offers');
//                           },
//                           child: const CustomTextStyle(
//                             text: 'Offer',
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 16.0),
//                         child: InkWell(
//                           onTap: () {
//                             print('Latest products');
//                           },
//                           child: const CustomTextStyle(
//                             text: 'Latest products',
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 16.0),
//                         child: InkWell(
//                           onTap: () {
//                             print('sale');
//                           },
//                           child: const CustomTextStyle(
//                             text: 'sale',
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(
//               top: 32.0,
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(left: 16.0),
//                   child: InkWell(
//                     onTap: () {
//                       print('About us');
//                     },
//                     child: const HeadingCustomTextStyle(
//                       text: 'About us',
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(
//                     top: 32.0,
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       InkWell(
//                         onTap: () {
//                           print('Privacy policy');
//                         },
//                         child: const CustomTextStyle(
//                           text: 'Privacy Policy',
//                         ),
//                       ),
//                       InkWell(
//                         onTap: () {
//                           print('Terms & Conditions');
//                         },
//                         child: const CustomTextStyle(
//                           text: 'Terms & Conditions',
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const Padding(
//             padding: EdgeInsets.only(
//               top: 16.0,
//               bottom: 16.0,
//             ),
//             child: Align(
//               alignment: Alignment.center,
//               child: Text(
//                 'Copyright Ⓒ 2022 Brikshya. All Right Reserved',
//                 style: TextStyle(
//                   fontSize: 15,
//                   color: Colors.black54,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CustomTextStyle extends StatelessWidget {
//   final String text;
//   const CustomTextStyle({
//     Key? key,
//     required this.text,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       text,
//       style: const TextStyle(
//         color: kBlackColor,
//         fontSize: 20,
//       ),
//     );
//   }
// }

// class HeadingCustomTextStyle extends StatelessWidget {
//   final String text;
//   const HeadingCustomTextStyle({
//     Key? key,
//     required this.text,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       text,
//       style: const TextStyle(
//         fontSize: 24,
//         fontWeight: FontWeight.w600,
//         color: kBlackColor,
//       ),
//     );
//   }
// }


