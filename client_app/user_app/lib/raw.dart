//  Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Neumorphic(
//           style: const NeumorphicStyle(
//             border: NeumorphicBorder(width: 1),
//             depth: -5,
//             boxShape: NeumorphicBoxShape.stadium(),
//             shadowLightColorEmboss: Colors.white,
//             shadowDarkColorEmboss: Color.fromARGB(255, 162, 162, 162),
//             oppositeShadowLightSource: false,
//             intensity: 10,
//             surfaceIntensity: 0.25,
//             lightSource: LightSource.top,
//           ),
//           child: Container(
//             height: 48,
//             width: (16 * 1.2 * 16 / 2 + 96).toDouble(),
//             color: Colors.white,
//             child: Row(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(left: 24.0),
//                   child: SizedBox(
//                     height: 32,
//                     width: 32,
//                     child: Image.asset('images/categorys/cactus.png'),
//                   ),
//                 ),
//                 const Padding(
//                   padding: EdgeInsets.only(left: 24.0),
//                   child: Text(
//                     'Decorative Plant',
//                     style: TextStyle(
//                       color: kBlackColor,
//                       fontFamily: 'Ubuntu',
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),




// decoration: BoxDecoration(
//                         color: Colors.grey[300],
//                         shape: BoxShape.rectangle,
//                         borderRadius: BorderRadius.circular(10),
//                         boxShadow: const [
//                           BoxShadow(
//                             color: Colors.white,
//                             offset: Offset(0, -4),
//                             blurRadius: 15.0,
//                             spreadRadius: 1.0,
//                           ),
//                           BoxShadow(
//                             color: Color.fromARGB(255, 117, 117, 117),
//                             offset: Offset(0, 4),
//                             blurRadius: 15.0,
//                             spreadRadius: 1.0,
//                           ),
//                         ],
//                         gradient: const LinearGradient(
//                             begin: Alignment.topCenter,
//                             end: Alignment.bottomCenter,
//                             colors: [
//                               Color.fromARGB(255, 238, 238, 238),
//                               Color.fromARGB(255, 224, 224, 224),
//                               Color.fromARGB(255, 189, 189, 189),
//                               Color.fromARGB(255, 158, 158, 158),
//                             ],
//                             stops: [
//                               0.1,
//                               0.3,
//                               0.8,
//                               0.9
//                             ]),
//                       ),



// Container(
//                   margin: EdgeInsets.symmetric(
//                     horizontal: 16,
//                     vertical: 8,
//                   ),
//                   height: 48,
//                   child: Neumorphic(
//                     style: NeumorphicStyle(
//                       border: const NeumorphicBorder(width: 1),
//                       depth: -3,
//                       boxShape: NeumorphicBoxShape.roundRect(
//                         BorderRadius.circular(15),
//                       ),
//                       shadowLightColorEmboss: Colors.white,
//                       shadowDarkColorEmboss:
//                           const Color.fromARGB(255, 162, 162, 162),
//                       oppositeShadowLightSource: false,
//                       intensity: 1,
//                       surfaceIntensity: 0.25,
//                       lightSource: LightSource.topLeft,
//                       color: kWhiteColor,
//                     ),
//                     child: Row(
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.all(5),
//                           child: Image.asset(
//                             'images/categorys/bonsai.png',
//                             height: 32,
//                             width: 32,
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(
//                             right: 10,
//                           ),
//                           child: Text(
//                             'Category',
//                             style: kAppName.copyWith(
//                               color: kBlackColor,
//                               fontWeight: FontWeight.bold,
//                               fontFamily: 'RedHatDisplay',
//                               fontSize: 16,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),



// Row(
//                 children: [
//                   RotatedBox(
//                     quarterTurns: 2,
//                     child: IconButton(
//                       icon: const Icon(
//                         Icons.forward,
//                       ),
//                       color: kMediumGreenColor,
//                       iconSize: 24,
//                       onPressed: () {},
//                     ),
//                   ),
//                   IconButton(
//                     icon: const Icon(
//                       Icons.forward_sharp,
//                     ),
//                     color: kMediumGreenColor,
//                     iconSize: 24,
//                     onPressed: () {},
//                   ),
//                 ],
//               ),


// responsive footer

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
//     Size size = MediaQuery.of(context).size;
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
//           GestureDetector(
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
//           GestureDetector(
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
//           size.width < 850
//               ? const Padding(
//                   padding: EdgeInsets.only(
//                     left: 16.0,
//                     top: 48.0,
//                   ),
//                   child: HeadingCustomTextStyle(
//                     text: 'Categories',
//                   ),
//                 )
//               : Container(),
//           size.width > 850
//               ? Padding(
//                   padding: const EdgeInsets.only(top: 32.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       SizedBox(
//                         width: size.width / 2,
//                         child: Padding(
//                           padding: const EdgeInsets.only(
//                             left: 20.0,
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const Padding(
//                                 padding: EdgeInsets.only(
//                                   bottom: 32.0,
//                                 ),
//                                 child: HeadingCustomTextStyle(
//                                   text: 'Categories',
//                                 ),
//                               ),
//                               GridView.builder(
//                                 itemCount: categorys.length,
//                                 shrinkWrap: true,
//                                 physics: const NeverScrollableScrollPhysics(),
//                                 gridDelegate:
//                                     const SliverGridDelegateWithFixedCrossAxisCount(
//                                   crossAxisCount: 2,
//                                   mainAxisSpacing: 8,
//                                   mainAxisExtent: 32,
//                                 ),
//                                 itemBuilder: (contex, index) {
//                                   final category = Categorys.fromData(
//                                       data: categorys[index]);
//                                   return GestureDetector(
//                                     onTap: () {
//                                       print('Category Clicked');
//                                     },
//                                     child: CustomTextStyle(
//                                       text: category.title,
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(
//                           left: 16.0,
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const HeadingCustomTextStyle(
//                                   text: 'Account',
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.only(top: 16.0),
//                                   child: GestureDetector(
//                                     onTap: () {
//                                       print('my account');
//                                     },
//                                     child: const CustomTextStyle(
//                                       text: 'My account',
//                                     ),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.only(top: 16.0),
//                                   child: GestureDetector(
//                                     onTap: () {
//                                       print('My orders');
//                                     },
//                                     child: const CustomTextStyle(
//                                       text: 'My orders',
//                                     ),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.only(top: 16.0),
//                                   child: GestureDetector(
//                                     onTap: () {
//                                       print('Jobs');
//                                     },
//                                     child: const CustomTextStyle(
//                                       text: 'Jobs',
//                                     ),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.only(top: 16.0),
//                                   child: GestureDetector(
//                                     onTap: () {
//                                       print('Events');
//                                     },
//                                     child: const CustomTextStyle(
//                                       text: 'Events',
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                 left: 96.0,
//                               ),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   const HeadingCustomTextStyle(
//                                     text: 'Store',
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(top: 16.0),
//                                     child: GestureDetector(
//                                       onTap: () {
//                                         print('Store location');
//                                       },
//                                       child: const CustomTextStyle(
//                                         text: 'Store Location',
//                                       ),
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(top: 16.0),
//                                     child: GestureDetector(
//                                       onTap: () {
//                                         print('Offers');
//                                       },
//                                       child: const CustomTextStyle(
//                                         text: 'Offer',
//                                       ),
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(top: 16.0),
//                                     child: GestureDetector(
//                                       onTap: () {
//                                         print('Latest products');
//                                       },
//                                       child: const CustomTextStyle(
//                                         text: 'Latest products',
//                                       ),
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(top: 16.0),
//                                     child: GestureDetector(
//                                       onTap: () {
//                                         print('sale');
//                                       },
//                                       child: const CustomTextStyle(
//                                         text: 'sale',
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//               : Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(
//                         left: 20.0,
//                         top: 16.0,
//                       ),
//                       child: GridView.builder(
//                         itemCount: categorys.length,
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         gridDelegate:
//                             const SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 2,
//                           mainAxisExtent: 32,
//                         ),
//                         itemBuilder: (contex, index) {
//                           final category =
//                               Categorys.fromData(data: categorys[index]);
//                           return GestureDetector(
//                             onTap: () {
//                               print('Category Clicked');
//                             },
//                             child: CustomTextStyle(
//                               text: category.title,
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(
//                         top: 32.0,
//                         left: 16.0,
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const HeadingCustomTextStyle(
//                                 text: 'Account',
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 16.0),
//                                 child: GestureDetector(
//                                   onTap: () {
//                                     print('my account');
//                                   },
//                                   child: const CustomTextStyle(
//                                     text: 'My account',
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 16.0),
//                                 child: GestureDetector(
//                                   onTap: () {
//                                     print('My orders');
//                                   },
//                                   child: const CustomTextStyle(
//                                     text: 'My orders',
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 16.0),
//                                 child: GestureDetector(
//                                   onTap: () {
//                                     print('Jobs');
//                                   },
//                                   child: const CustomTextStyle(
//                                     text: 'Jobs',
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 16.0),
//                                 child: GestureDetector(
//                                   onTap: () {
//                                     print('Events');
//                                   },
//                                   child: const CustomTextStyle(
//                                     text: 'Events',
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(
//                               left: size.width > 450
//                                   ? size.width > 550
//                                       ? size.width > 650
//                                           ? 228
//                                           : 180
//                                       : 132
//                                   : 48.0,
//                             ),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const HeadingCustomTextStyle(
//                                   text: 'Store',
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.only(top: 16.0),
//                                   child: GestureDetector(
//                                     onTap: () {
//                                       print('Store location');
//                                     },
//                                     child: const CustomTextStyle(
//                                       text: 'Store Location',
//                                     ),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.only(top: 16.0),
//                                   child: GestureDetector(
//                                     onTap: () {
//                                       print('Offers');
//                                     },
//                                     child: const CustomTextStyle(
//                                       text: 'Offer',
//                                     ),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.only(top: 16.0),
//                                   child: GestureDetector(
//                                     onTap: () {
//                                       print('Latest products');
//                                     },
//                                     child: const CustomTextStyle(
//                                       text: 'Latest products',
//                                     ),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.only(top: 16.0),
//                                   child: GestureDetector(
//                                     onTap: () {
//                                       print('sale');
//                                     },
//                                     child: const CustomTextStyle(
//                                       text: 'sale',
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//           Padding(
//             padding: const EdgeInsets.only(
//               top: 32.0,
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(left: 16.0),
//                   child: GestureDetector(
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
//                       GestureDetector(
//                         onTap: () {
//                           print('Privacy policy');
//                         },
//                         child: const CustomTextStyle(
//                           text: 'Privacy Policy',
//                         ),
//                       ),
//                       GestureDetector(
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
