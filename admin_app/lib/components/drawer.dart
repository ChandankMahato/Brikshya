import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:admin_app/constants/constants.dart';
import 'package:admin_app/main.dart';
import 'package:admin_app/screens/free_event.dart';
// import 'package:admin_app/services/storage.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  List data = [
    //menu data item
    {
      'level': 0,
      'icon': Icons.account_circle_rounded,
      'title': 'Brikshya',
    },

    //menu data item
    {
      "icon": Icons.dataset,
      "title": "Data",
      "route": "/data",
    },

    //menu data item
    {
      "icon": Icons.shopping_bag_outlined,
      "title": "Products",
      "route": "/products",
    },

    //menu data item
    {
      "icon": Icons.sell_outlined,
      "title": "Listings",
      "route": "/listings",
    },

    //menu data item
    {
      "icon": Icons.event,
      "title": "Events",
      "route": "/events",
    },

    //menu data item
    {
      "icon": Icons.work_outline,
      "title": "Jobs",
      "route": "/jobs",
    },
  ];
  // void navigate(menuItem) {
  //   if (menuItem == 'Sign In') {
  //     navigatorKey.currentState!.popAndPushNamed(Signin.id);
  //   }
  //   if (menuItem == 'Logout') {
  //     Storage.removeToken();
  //     Provider.of<LoggedInState>(context, listen: false).changeState(false);
  //   }
  //   if (menuItem == 'Free Event') {
  //     navigatorKey.currentState!.popAndPushNamed(FreeEvent.id);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // final logInState = Provider.of<LoggedInState>(context);

    // logInState.isLoggedIn
    //     ? data[1]['children'] = accountItemSignedIn
    //     : data[1]['children'] = accountItem;

    return Drawer(
      backgroundColor: kGreyLightColor,
      child: _buildDrawer(),
    );
  }

  //widget building drawer
  Widget _buildDrawer() {
    return ListView.separated(
      padding: const EdgeInsets.only(top: 0),
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return _buildDrawerHeader(data[index]);
        }
        return _buildMenuList(data[index]);
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(
        height: 1,
        thickness: 2,
      ),
    );
  }

  //widget building drawer header
  Widget _buildDrawerHeader(Map headItem) {
    return DrawerHeader(
      margin: const EdgeInsets.only(bottom: 0),
      decoration: const BoxDecoration(
        color: kDarkGreenColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            headItem['icon'],
            color: kWhiteColor,
            size: 60,
          ),
          const Spacer(),
          Text(
            headItem['title'],
            style: const TextStyle(
              color: kWhiteColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  //widget building menulist
  Widget _buildMenuList(Map menuItem) {
    //building children
    return Builder(
      builder: (context) {
        return InkWell(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: ListTile(
              leading: Icon(
                menuItem['icon'],
                color: kDarkGreenColor,
              ),
              title: Text(
                menuItem['title'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: kLightGreenColor,
                ),
              ),
              onTap: () {
                // navigate(menuItem['title']);
                navigatorKey.currentState!.pushNamedAndRemoveUntil(
                    menuItem["route"], (route) => false);
              },
            ),
          ),
        );
      },
    );
  }
}
