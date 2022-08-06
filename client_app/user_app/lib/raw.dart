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