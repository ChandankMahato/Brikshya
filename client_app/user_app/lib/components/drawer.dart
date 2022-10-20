import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:user_app/constants.dart';
import 'package:user_app/main.dart';
import 'package:user_app/provider/logged_in_state.dart';
import 'package:user_app/services/storage.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  List accountItem = [
    {
      "level": 1,
      "icon": Icons.login_rounded,
      "title": "Sign In",
      "route": "/signin",
    },
  ];

  List accountItemSignedIn = [
    {
      "level": 1,
      "icon": Icons.account_circle,
      "title": "User Profile",
      "route": "/userprofile",
    },
    {
      "level": 1,
      "icon": Icons.manage_accounts,
      "title": 'Manage',
      "children": [
        {
          'level': 2,
          "title": "Change Username",
          "route": "/changeusername",
          "icon": Icons.drive_file_rename_outline
        },
        {
          'level': 2,
          "title": "Change Number",
          "route": "/changephone",
          "icon": Icons.drive_file_rename_outline
        },
        {
          'level': 2,
          "title": "Change Password",
          "route": "/changepassword",
          "icon": Icons.drive_file_rename_outline
        },
      ],
    },
    {
      "level": 1,
      "icon": Icons.logout_rounded,
      "title": "Logout",
      "route": "Logout",
    },
  ];
//menu data List
  List data = [
    //menu data item
    {
      'level': 0,
      'icon': Icons.energy_savings_leaf_sharp,
      'title': 'Brikshya',
      "route": '',
    },

    {
      'level': 0,
      'icon': Icons.home,
      'title': 'Home',
      "route": '/home',
    },

    //menu data item
    {
      "level": 0,
      "icon": Icons.verified_outlined,
      "title": "Account",
      "children": [
        {
          "level": 1,
          "icon": Icons.login_rounded,
          "title": "Sign In",
          "route": "/Sign In",
        },
      ]
    },

    //menu data item
    {
      "level": 0,
      "icon": Icons.event_available_outlined,
      "title": "Events",
      "children": [
        {
          "level": 1,
          "icon": Icons.event_available_outlined,
          "title": "My Event",
          "route": "/myevent",
        },
        {
          "level": 1,
          "icon": Icons.event,
          "title": "All Event",
          "route": "/freeevent",
        },
      ]
    },

    //menu data item
    {
      "level": 0,
      "icon": Icons.add_business_outlined,
      "title": "Employment",
      "children": [
        {
          "level": 1,
          "icon": Icons.add_reaction_outlined,
          "title": "Job Inquery",
          "route": "/job",
        },
        {
          "level": 1,
          "icon": Icons.model_training_outlined,
          "title": "Training Inquery",
          "route": "/training",
        },
      ]
    },

    //menu data item
    {
      "level": 0,
      "icon": Icons.group,
      'title': 'Sell Items',
      "children": [
        {
          "level": 0,
          "icon": Icons.list,
          "title": "View Listing",
          "route": "/buy",
        },
      ]
    },

    {
      "level": 0,
      "icon": Icons.manage_accounts,
      'title': 'Manage Buy & Sell',
      "children": [
        {
          "level": 1,
          "icon": Icons.edit,
          "title": "Manage Sells",
          "route": "/buyOrder",
        },
        {
          "level": 1,
          "icon": Icons.edit,
          "title": "Manage Purchase",
          "route": "/userorder",
        },
      ]
    },

    {
      "level": 0,
      "icon": Icons.history,
      "title": "History",
      "children": [
        {
          "level": 1,
          "icon": Icons.attach_money,
          "title": "Sells History",
          "route": "/buyorderhistory",
        },
        {
          "level": 1,
          "icon": Icons.money_off,
          "title": "Purchase History",
          "route": "/userOrderhistory",
        },
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    final logInState = Provider.of<LoggedInState>(context);

    logInState.isLoggedIn
        ? data[2]['children'] = accountItemSignedIn
        : data[2]['children'] = accountItem;

    return Drawer(
      backgroundColor: kGreyLightColor,
      child: _buildDrawer(),
    );
  }

  //widget building drawer
  Widget _buildDrawer() {
    return ListView.separated(
      padding: const EdgeInsets.only(
        top: 0,
        bottom: 16.0,
      ),
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

  Widget _buildMenuList(Map menuItem) {
    double leftPadding = 0;
    double fontSize = 20;

    if (menuItem['level'] == 1) {
      leftPadding = 20;
      fontSize = 16;
    }

    if (menuItem['level'] == 2) {
      leftPadding = 30;
      fontSize = 14;
    }

    if (menuItem['children'] == null) {
      return Builder(
        builder: (context) {
          return InkWell(
            child: Padding(
              padding: EdgeInsets.only(left: leftPadding),
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
                  if (menuItem['route'] == '/home') {
                    navigatorKey.currentState!.pushNamedAndRemoveUntil(
                        menuItem["route"], (route) => false);
                  }
                  if (menuItem['route'] == 'Logout') {
                    Storage.removeToken();
                    Provider.of<LoggedInState>(context, listen: false)
                        .changeState(false);
                  }
                  if (menuItem['route'] != '/home' &&
                      menuItem['route'] != 'Logout') {
                    navigatorKey.currentState!
                        .popAndPushNamed(menuItem["route"]);
                  }
                },
              ),
            ),
          );
        },
      );
    }
    return Padding(
      padding: EdgeInsets.only(left: leftPadding),
      child: ExpansionTile(
          leading: Icon(
            menuItem['icon'],
            color: kMediumGreenColor,
          ),
          title: Text(
            menuItem['title'],
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: kDarkGreenColor,
            ),
          ),
          children: menuItem['children']
              .map<Widget>((value) => _buildMenuList(value))
              .toList()),
    );
  }
}
