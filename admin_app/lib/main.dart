import 'package:admin_app/screens/events.dart';
import 'package:admin_app/screens/home.dart';
import 'package:admin_app/screens/jobs.dart';
import 'package:admin_app/screens/listings.dart';
import 'package:admin_app/screens/products.dart';
import 'package:admin_app/state/fliter_type_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const BrikshyaAdminApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class BrikshyaAdminApp extends StatelessWidget {
  const BrikshyaAdminApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FilterTypeState()),
      ],
      child: Builder(builder: (context) {
        return MaterialApp(
          initialRoute: Products.id,
          debugShowCheckedModeBanner: false,
          navigatorKey: navigatorKey,
          routes: {
            Home.id: (context) => const Home(),
            Jobs.id: (context) => const Jobs(),
            Products.id: (context) => const Products(),
            Listings.id: (context) => const Listings(),
            Events.id: (context) => const Events(),
          },
        );
      }),
    );
  }
}
