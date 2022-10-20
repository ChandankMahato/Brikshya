// import 'dart:io';

// // import 'package:badges/badges.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
// // import 'package:provider/provider.dart';
// import 'package:admin_app/components/drawer.dart';
// import 'package:admin_app/constants/constants.dart';
// import 'package:admin_app/custom_components/customText.dart';
// import 'package:admin_app/custom_components/custom_button.dart';
// import 'package:admin_app/main.dart';
// // import 'package:admin_app/provider/cart_provider.dart';
// // import 'package:admin_app/provider/event_register_state.dart';
// // import 'package:admin_app/provider/favorite_provider.dart';
// // import 'package:admin_app/provider/logged_in_state.dart';
// // import 'package:admin_app/screens/cart.dart';
// // import 'package:admin_app/screens/favorite.dart';
// import 'package:admin_app/screens/home.dart';
// // import 'package:admin_app/screens/signin.dart';

// class FreeEvent extends StatefulWidget {
//   const FreeEvent({Key? key}) : super(key: key);

//   static const String id = '/freeevent';

//   @override
//   State<FreeEvent> createState() => _FreeEventState();
// }

// class _FreeEventState extends State<FreeEvent> {
//   List eventData = [
//     {
//       'id': '1',
//       'image': 'images/events/event1.png',
//       'title': 'Training Program on Bark Grafting',
//       'date': '19-9-2022 10A.M',
//       'location': 'Tikathali, lalitpur',
//     },
//     {
//       'id': '2',
//       'image': 'images/events/event2.png',
//       'title': 'Training Program on Slice & Whip grafting',
//       'date': '22-9-2022 6A.M',
//       'location': 'jadibuti, Kathmandu',
//     },
//     {
//       'id': '3',
//       'image': 'images/events/event3.png',
//       'title': 'Cactus Plant Exhibition',
//       'date': '10-10-2022 9A.M',
//       'location': 'Kushwaha Nursery, lahan-3',
//     },
//     {
//       'id': '4',
//       'image': 'images/events/event4.png',
//       'title': 'Training On Mushroom Cultivation',
//       'date': '11-12-2022 10A.M',
//       'location': 'ramesh chowk, lahan',
//     },
//     {
//       'id': '5',
//       'image': 'images/events/event5.png',
//       'title': 'One day fruit sale exhibition',
//       'date': '11-15-2022 10A.M',
//       'location': 'Gramin, lahan',
//     }
//   ];

//   List userAttendintEvent = [];

//   @override
//   Widget build(BuildContext context) {
//     // final logInState = Provider.of<LoggedInState>(context);
//     // final freeEventState = Provider.of<FreeEventState>(context);
//     String buttonText = 'Register';
//     // logInState.isLoggedIn
//     //     ? buttonText = 'Register'
//     //     : buttonText = 'Signin to Register';
//     return Scaffold(
//       backgroundColor: kGreyLightColor,
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(80),
//         child: AppBar(
//           toolbarHeight: 80,
//           backgroundColor: kWhiteColor,
//           elevation: 0.0,
//           leading: Builder(
//             builder: (BuildContext context) {
//               return IconButton(
//                 icon: const Icon(
//                   Icons.menu,
//                   color: kDarkGreenColor,
//                   size: 32, // Changing Drawer Icon Size
//                 ),
//                 onPressed: () {
//                   Scaffold.of(context).openDrawer();
//                 },
//                 tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
//               );
//             },
//           ),
//           title: InkWell(
//             onTap: () {
//               navigatorKey.currentState!
//                   .pushNamedAndRemoveUntil(Home.id, (route) => false);
//             },
//             child: const CustomTextStyleOne(
//               text: 'Brikshya',
//               fontSize: 24,
//               myColor: kDarkGreenColor,
//               fontFamily: 'RedHatDisplay',
//             ),
//           ),
//           actions: [
//             Padding(
//               padding: const EdgeInsets.only(right: 20.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // Badge(
//                   //   badgeColor: kOrangeColor,
//                   //   padding: const EdgeInsets.all(7),
//                   //   badgeContent: Consumer<FavoriteProvider>(
//                   //     builder: (context, value, child) {
//                   //       return Text(
//                   //         value.getFavoriteItemCount().toString(),
//                   //         style: const TextStyle(
//                   //           color: kWhiteColor,
//                   //         ),
//                   //       );
//                   //     },
//                   //   ),
//                   //   child: IconButton(
//                   //     icon: const Icon(Icons.favorite_border_rounded),
//                   //     color: kLightGreenColor,
//                   //     iconSize: 32,
//                   //     onPressed: () {
//                   //       navigatorKey.currentState!.pushNamed(FavoriteScreen.id);
//                   //     },
//                   //     tooltip: 'Navigate To Favorite',
//                   //   ),
//                   // ),
//                   // Badge(
//                   //   badgeColor: kOrangeColor,
//                   //   padding: const EdgeInsets.all(7),
//                   //   badgeContent: Consumer<CartProvider>(
//                   //       builder: (context, value, child) {
//                   //     return Text(
//                   //       value.getCartItemCount().toString(),
//                   //       style: const TextStyle(
//                   //         color: kWhiteColor,
//                   //       ),
//                   //     );
//                   //   }),
//                   //   child: IconButton(
//                   //     icon: const Icon(Icons.add_shopping_cart_rounded),
//                   //     color: kLightGreenColor,
//                   //     iconSize: 32,
//                   //     onPressed: () {
//                   //       navigatorKey.currentState!.pushNamed(CartScreen.id);
//                   //     },
//                   //     tooltip: 'Navigate To Cart',
//                   //   ),
//                   // ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       drawer: const AppDrawer(),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               const Padding(
//                 padding: EdgeInsets.only(
//                   top: 16.0,
//                   bottom: 16.0,
//                 ),
//                 child: CustomTextStyleOne(
//                   text: 'Free Events',
//                   fontSize: 20,
//                   myColor: kDarkGreenColor,
//                   fontFamily: 'RedHatDisplay',
//                 ),
//               ),
//               ListView.builder(
//                   shrinkWrap: true,
//                   physics: const ScrollPhysics(),
//                   itemCount: eventData.length,
//                   itemBuilder: (context, index) {
//                     final event = eventData[index];
//                     return Card(
//                       margin: const EdgeInsets.symmetric(
//                         vertical: 12,
//                         horizontal: 16,
//                       ),
//                       elevation: 4,
//                       color: kWhiteColor,
//                       shape: const RoundedRectangleBorder(
//                         borderRadius: BorderRadius.all(
//                           Radius.circular(12),
//                         ),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         children: [
//                           ClipRRect(
//                             borderRadius: const BorderRadius.only(
//                               topLeft: Radius.circular(12),
//                               topRight: Radius.circular(12),
//                             ),
//                             child: Image.asset(
//                               event['image'],
//                               height: 150,
//                               fit: BoxFit.fitWidth,
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(12.0),
//                             child: CustomTextStyleOne(
//                               text: event['title'],
//                               myColor: kBlackColor,
//                               fontSize: 16,
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(
//                               left: 8.0,
//                               bottom: 8.0,
//                               right: 8.0,
//                             ),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   children: [
//                                     const Icon(
//                                       Icons.location_on_outlined,
//                                       color: kDarkGreenColor,
//                                       size: 24,
//                                     ),
//                                     const SizedBox(
//                                       width: 4.0,
//                                     ),
//                                     CustomTextStyleOne(
//                                       text: event['location'],
//                                       myColor: kBlackColor,
//                                       fontSize: 16,
//                                     ),
//                                   ],
//                                 ),
//                                 const SizedBox(
//                                   height: 8.0,
//                                 ),
//                                 Row(
//                                   children: [
//                                     const Icon(
//                                       Icons.timelapse_sharp,
//                                       color: kDarkGreenColor,
//                                       size: 24,
//                                     ),
//                                     const SizedBox(
//                                       width: 4.0,
//                                     ),
//                                     CustomTextStyleOne(
//                                       text: event['date'],
//                                       myColor: kBlackColor,
//                                       fontSize: 16,
//                                     ),
//                                   ],
//                                 ),
//                                 // SizedBox(
//                                 //   width: double.infinity,
//                                 //   child: !freeEventState.userAttendingEvent
//                                 //           .contains(int.parse(event['id']))
//                                 //       ? ElevatedButton(
//                                 //           child: CustomTextStyleOne(
//                                 //             text: buttonText,
//                                 //             fontSize: 20,
//                                 //             myColor: kWhiteColor,
//                                 //           ),
//                                 //           onPressed: () {
//                                 //             if (!logInState.isLoggedIn) {
//                                 //               //navigate to signin
//                                 //               logInState.changeState(true);
//                                 //             }
//                                 //             if (!freeEventState
//                                 //                 .userAttendingEvent
//                                 //                 .contains(
//                                 //                     int.parse(event['id']))) {
//                                 //               //add event id to exiting or create user event account
//                                 //               freeEventState.addUserEventList(
//                                 //                   int.parse(event['id']));
//                                 //             }
//                                 //           },
//                                 //           style: ElevatedButton.styleFrom(
//                                 //             primary: kLightGreenColor,
//                                 //             onPrimary: kWhiteColor,
//                                 //             shape: RoundedRectangleBorder(
//                                 //               borderRadius:
//                                 //                   BorderRadius.circular(10),
//                                 //             ),
//                                 //           ),
//                                 //         )
//                                 //       : ElevatedButton(
//                                 //           child: const CustomTextStyleOne(
//                                 //             text: 'Unregister',
//                                 //             fontSize: 20,
//                                 //             myColor: kWhiteColor,
//                                 //           ),
//                                 //           onPressed: () {
//                                 //             if (freeEventState
//                                 //                 .userAttendingEvent
//                                 //                 .contains(
//                                 //                     int.parse(event['id']))) {
//                                 //               //remove event from user event account
//                                 //               freeEventState
//                                 //                   .removeUserEventList(
//                                 //                       int.parse(event['id']));
//                                 //             }
//                                 //           },
//                                 //           style: ElevatedButton.styleFrom(
//                                 //             primary: kOrangeColor,
//                                 //             onPrimary: kWhiteColor,
//                                 //             shape: RoundedRectangleBorder(
//                                 //               borderRadius:
//                                 //                   BorderRadius.circular(10),
//                                 //             ),
//                                 //           ),
//                                 //         ),
//                                 // ),
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                     );
//                   }),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
