// import 'package:flutter/material.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
// import 'package:user_app/components/appbar.dart';
// import 'package:user_app/components/banner.dart';
// import 'package:user_app/components/category.dart';
// import 'package:user_app/components/footer.dart';
// import 'package:user_app/components/popular.dart';
// import 'package:user_app/components/product.dart';
// import 'package:user_app/constants.dart';

// class Home extends StatefulWidget {
//   const Home({Key? key}) : super(key: key);
//   static const String id = "/home";

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   bool _showBackToTopButton = false;

//   // scroll controller
//   late ScrollController _scrollController;

//   @override
//   void initState() {
//     _scrollController = ScrollController()
//       ..addListener(() {
//         setState(() {
//           if (_scrollController.offset >= 200) {
//             _showBackToTopButton = true; // show the back-to-top button
//           } else {
//             _showBackToTopButton = false; // hide the back-to-top button
//           }
//         });
//       });

//     super.initState();
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose(); // dispose the controller
//     super.dispose();
//   }

//   // This function is triggered when the user presses the back-to-top button
//   void _scrollToTop() {
//     _scrollController.animateTo(0,
//         duration: const Duration(seconds: 1), curve: Curves.linear);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: kWhiteColor,
//       appBar: const PreferredSize(
//         preferredSize: Size.fromHeight(80),
//         child: CustomAppBar(),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           controller: _scrollController,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: const [
//               CustomBanner(),
//               CategorysWidget(),
//               PopularWdiget(),
//               ProductWidget(),
//               FooterWidget(),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: _showBackToTopButton == false
//           ? null
//           : Padding(
//               padding: const EdgeInsets.only(bottom: 64.0),
//               child: FloatingActionButton(
//                 onPressed: _scrollToTop,
//                 backgroundColor: kOrangeColor,
//                 child: const Icon(
//                   Icons.arrow_upward,
//                 ),
//               ),
//             ),
//     );
//   }
// }




// cart text editing controller

// SizedBox(
                                                  //   width: 60,
                                                  //   height: 24,
                                                  //   child: TextFormField(
                                                  //       initialValue: itemObject
                                                  //           .productQuantity
                                                  //           .toString(),
                                                  //       maxLines: 1,
                                                  //       decoration:
                                                  //           const InputDecoration(
                                                  //         hintText: '1',
                                                  //         hintStyle: TextStyle(
                                                  //             fontSize: 12,
                                                  //             fontWeight:
                                                  //                 FontWeight
                                                  //                     .bold),
                                                  //       ),
                                                  //       inputFormatters: [
                                                  //         FilteringTextInputFormatter
                                                  //             .allow(
                                                  //           RegExp(
                                                  //               '[1-9][0-9]*'),
                                                  //         ),
                                                  //         LengthLimitingTextInputFormatter(
                                                  //             6)
                                                  //       ],
                                                  //       cursorColor:
                                                  //           kLightGreenColor,
                                                  //       enabled: true,
                                                  //       keyboardType:
                                                  //           TextInputType
                                                  //               .number,
                                                  //       onFieldSubmitted:
                                                  //           (val) {
                                                  //         quantityController
                                                  //                 .text =
                                                  //             val.toString();

                                                  //         int quantity = itemObject
                                                  //             .productQuantity;
                                                  //         int price = itemObject
                                                  //             .initialPrice;

                                                  //         if (quantityController
                                                  //                 .text ==
                                                  //             "") {
                                                  //           quantityController
                                                  //               .text = "1";
                                                  //           quantity = 1;
                                                  //         } else {
                                                  //           quantity = int.parse(
                                                  //               quantityController
                                                  //                   .text);
                                                  //         }
                                                  //         int? newPrice =
                                                  //             price * quantity;
                                                  //         quantityController
                                                  //                 .text =
                                                  //             quantity
                                                  //                 .toString();
                                                  //         cart.updateCartList(
                                                  //           itemObject.itemId,
                                                  //           itemObject
                                                  //               .productId,
                                                  //           itemObject
                                                  //               .productImage,
                                                  //           itemObject
                                                  //               .productName,
                                                  //           itemObject
                                                  //               .productCategory,
                                                  //           itemObject
                                                  //               .initialPrice,
                                                  //           quantity,
                                                  //         );
                                                  //         cart.addTotalPrice(
                                                  //             double.parse(newPrice
                                                  //                 .toString()));
                                                  //         cart.removeTotalPrice(
                                                  //             double.parse((itemObject
                                                  //                         .productQuantity *
                                                  //                     itemObject
                                                  //                         .initialPrice)
                                                  //                 .toString()));
                                                  //         newPrice = 0;
                                                  //         quantity = 0;
                                                  //       }),
                                                  // ),