import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_app/constants.dart';
import 'package:user_app/provider/cart_provider.dart';
import 'package:user_app/provider/check_box_state.dart';
import 'package:user_app/provider/event_register_state.dart';
import 'package:user_app/provider/expansion_tile_state.dart';
import 'package:user_app/provider/favorite_provider.dart';
import 'package:user_app/provider/filter_state.dart';
import 'package:user_app/provider/horizontal_scroll.dart';
import 'package:user_app/provider/location_state.dart';
import 'package:user_app/provider/logged_in_state.dart';
import 'package:user_app/provider/password_eye.dart';
import 'package:user_app/provider/phone_verification_state.dart';
import 'package:user_app/provider/quantity_controller_state.dart';
import 'package:user_app/provider/text_controller_state.dart';
import 'package:user_app/screens/buy.dart';
import 'package:user_app/screens/buyCart.dart';
import 'package:user_app/screens/changePassword.dart';
import 'package:user_app/screens/changePhonenumber.dart';
import 'package:user_app/screens/changeUsername.dart';
import 'package:user_app/screens/profile.dart';
import 'package:user_app/screens/userOrder.dart';
import 'package:user_app/screens/userOrderHistory.dart';
import 'package:user_app/screens/cart.dart';
import 'package:user_app/screens/favorite.dart';
import 'package:user_app/screens/free_event.dart';
import 'package:user_app/screens/home.dart';
import 'package:user_app/screens/job.dart';
import 'package:user_app/screens/my_event.dart';
import 'package:user_app/screens/onboarding_screen.dart';
import 'package:user_app/screens/order.dart';
import 'package:user_app/screens/signin.dart';
import 'package:user_app/screens/signup.dart';
import 'package:user_app/screens/splash_screen.dart';
import 'package:user_app/screens/phone_verification.dart';
import 'package:user_app/screens/training.dart';
import 'package:user_app/screens/buyOrder.dart';
import 'package:user_app/screens/buyHistory.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Brikshya());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Brikshya extends StatelessWidget {
  const Brikshya({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => FavoriteProvider()),
        ChangeNotifierProvider(create: (context) => PhoneVerificationSate()),
        ChangeNotifierProvider(create: (context) => PasswordEyeState()),
        ChangeNotifierProvider(create: (context) => LoggedInState()),
        ChangeNotifierProvider(create: (context) => QuantityControllerState()),
        ChangeNotifierProvider(create: (context) => FreeEventState()),
        ChangeNotifierProvider(create: (context) => FilterTypeState()),
        ChangeNotifierProvider(create: (context) => CashInHandState()),
        ChangeNotifierProvider(create: (context) => DropDownState()),
        ChangeNotifierProvider(create: (context) => LocationState()),
        ChangeNotifierProvider(create: (context) => ExpandTileState()),
        ChangeNotifierProvider(create: (context) => JobTextControllerState()),
        ChangeNotifierProvider(create: (context) => ScrollState()),
      ],
      child: Builder(
        builder: (BuildContext context) {
          return MaterialApp(
            title: 'Brikshya',
            theme: ThemeData(
              fontFamily: ubuntu,
            ),
            initialRoute: SplashScreen.id,
            debugShowCheckedModeBanner: false,
            navigatorKey: navigatorKey,
            routes: {
              SplashScreen.id: (context) => const SplashScreen(),
              OnBoarding.id: (context) => const OnBoarding(),
              Home.id: (context) => const Home(),
              CartScreen.id: (context) => const CartScreen(),
              OrderScreen.id: (context) => const OrderScreen(),
              FavoriteScreen.id: (context) => const FavoriteScreen(),
              FreeEvent.id: (context) => const FreeEvent(),
              MyEvent.id: (context) => const MyEvent(),
              UserOrderHistory.id: (context) => const UserOrderHistory(),
              UserOrder.id: (context) => const UserOrder(),
              BuyOrderHistory.id: (context) => const BuyOrderHistory(),
              BuyItemListing.id: (context) => const BuyItemListing(),
              MyJob.id: (context) => const MyJob(),
              MyTraining.id: (context) => const MyTraining(),
              BuyOrder.id: (context) => const BuyOrder(),
              Signup.id: (context) => const Signup(),
              Signin.id: (context) => const Signin(),
              UserProfile.id: (context) => const UserProfile(),
              ChangeUsername.id: (context) => const ChangeUsername(),
              ChangePassword.id: (context) => const ChangePassword(),
              ChangePhone.id: (context) => const ChangePhone(),
              BuyCart.id: (context) => BuyCart(
                  args: ModalRoute.of(context)!.settings.arguments
                      as Map<String, dynamic>),
              PhoneVerification.id: (context) => PhoneVerification(
                  args: ModalRoute.of(context)!.settings.arguments
                      as Map<String, dynamic>),
            },
          );
        },
      ),
    );
  }
}
