import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:user_app/components/drawer.dart';
import 'package:user_app/constants.dart';
import 'package:user_app/custom_components/customText.dart';
import 'package:user_app/custom_components/custom_widget.dart';
import 'package:user_app/custom_components/snack_bar.dart';
import 'package:user_app/main.dart';
import 'package:user_app/models/freeevent_model.dart';
import 'package:user_app/provider/logged_in_state.dart';
import 'package:user_app/screens/home.dart';
import 'package:user_app/screens/signin.dart';
import 'package:user_app/services/free_event.dart';

class MyEvent extends StatefulWidget {
  const MyEvent({Key? key}) : super(key: key);

  static const String id = '/myevent';

  @override
  State<MyEvent> createState() => _MyEventState();
}

class _MyEventState extends State<MyEvent> {
  List eventData = [
    {
      'id': '1',
      'image': 'images/events/event1.png',
      'title': 'Training Program on Bark Grafting',
      'date': '19-9-2022 10A.M',
      'location': 'Tikathali, lalitpur',
    },
    {
      'id': '2',
      'image': 'images/events/event2.png',
      'title': 'Training Program on Slice & Whip grafting',
      'date': '22-9-2022 6A.M',
      'location': 'jadibuti, Kathmandu',
    },
    {
      'id': '3',
      'image': 'images/events/event3.png',
      'title': 'Cactus Plant Exhibition',
      'date': '10-10-2022 9A.M',
      'location': 'Kushwaha Nursery, lahan-3',
    },
    {
      'id': '4',
      'image': 'images/events/event4.png',
      'title': 'Training On Mushroom Cultivation',
      'date': '11-12-2022 10A.M',
      'location': 'ramesh chowk, lahan',
    },
    {
      'id': '5',
      'image': 'images/events/event5.png',
      'title': 'One day fruit sale exhibition',
      'date': '11-15-2022 10A.M',
      'location': 'Gramin, lahan',
    }
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: kGreyLightColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: AppBar(
            toolbarHeight: 80,
            backgroundColor: kWhiteColor,
            elevation: 0.0,
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(
                    Icons.menu,
                    color: kDarkGreenColor,
                    size: 32, // Changing Drawer Icon Size
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: IconButton(
                    icon: const Icon(Icons.home),
                    color: kDarkGreenColor,
                    iconSize: 32,
                    tooltip: 'Navigate to Home',
                    onPressed: () {
                      navigatorKey.currentState!
                          .pushNamedAndRemoveUntil(Home.id, (route) => false);
                    }),
              )
            ],
            title: InkWell(
              onTap: () {},
              child: const CustomTextStyleOne(
                text: 'My Events',
                fontSize: 24,
                myColor: kDarkGreenColor,
                fontFamily: redhat,
              ),
            ),
          ),
        ),
        drawer: const AppDrawer(),
        body: SafeArea(
          child: TabBarView(
            children: [
              RefreshIndicator(
                color: kLightGreenColor,
                onRefresh: () async {
                  setState(() {});
                  await Future.delayed(const Duration(seconds: 4));
                },
                child: Center(
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Provider.of<LoggedInState>(context, listen: true)
                            .isLoggedIn
                        ? FutureBuilder<List>(
                            future: FreeEventDatabase
                                .upcommingRegisteredFreeEvent(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return brikshyaLoader();
                              }
                              if (snapshot.hasError) {
                                return networkError();
                              }
                              if (snapshot.data!.isEmpty) {
                                return const NoDataWidget(
                                  title: 'No Event Registered!',
                                  icondata: Icons.event_busy_sharp,
                                );
                              }
                              final events = snapshot.data!;
                              return Column(
                                children: [
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: const ScrollPhysics(),
                                    itemCount: events.length,
                                    itemBuilder: (context, index) {
                                      FreeEvents event = FreeEvents.fromData(
                                          data: events[index]);

                                      return Card(
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 12,
                                          horizontal: 16,
                                        ),
                                        elevation: 4,
                                        color: kWhiteColor,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(12),
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(12),
                                                topRight: Radius.circular(12),
                                              ),
                                              child: Image.network(
                                                event.image,
                                                height: 150,
                                                fit: BoxFit.fitWidth,
                                                errorBuilder: ((context, error,
                                                    stackTrace) {
                                                  return const SizedBox(
                                                    height: 150,
                                                    child: Icon(
                                                        Icons
                                                            .image_not_supported,
                                                        size: 96,
                                                        color: Colors.black45),
                                                  );
                                                }),
                                                loadingBuilder:
                                                    (BuildContext context,
                                                        Widget child,
                                                        ImageChunkEvent?
                                                            loadingProgress) {
                                                  if (loadingProgress == null) {
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
                                                              .withOpacity(0.5),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: CustomTextStyleOne(
                                                text: event.title,
                                                myColor: kBlackColor,
                                                fontSize: 16,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 8.0,
                                                bottom: 8.0,
                                                right: 8.0,
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                        Icons
                                                            .location_on_outlined,
                                                        color: kDarkGreenColor,
                                                        size: 24,
                                                      ),
                                                      const SizedBox(
                                                        width: 4.0,
                                                      ),
                                                      CustomTextStyleOne(
                                                        text: event.location,
                                                        myColor: kBlackColor,
                                                        fontSize: 16,
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 8.0,
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.timelapse_sharp,
                                                        color: kDarkGreenColor,
                                                        size: 24,
                                                      ),
                                                      const SizedBox(
                                                        width: 4.0,
                                                      ),
                                                      CustomTextStyleOne(
                                                        text: DateFormat
                                                                .yMMMMEEEEd()
                                                            .add_jm()
                                                            .format(
                                                              DateTime.parse(
                                                                  event.date),
                                                            ),
                                                        myColor: kBlackColor,
                                                        fontSize: 14,
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: double.infinity,
                                                    child: ElevatedButton(
                                                      onPressed: () async {
                                                        final statusCode =
                                                            await FreeEventDatabase
                                                                .unregisterFreeEvent(
                                                                    event.id);
                                                        if (statusCode == 200) {
                                                          setState(() {});
                                                          showSnackBar(
                                                              context,
                                                              'Event unregistered successfully!',
                                                              kLightGreenColor);
                                                        }
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        primary: kOrangeColor,
                                                        onPrimary: kWhiteColor,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                      child:
                                                          const CustomTextStyleOne(
                                                        text:
                                                            'Unregister Event',
                                                        fontSize: 20,
                                                        myColor: kWhiteColor,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              );
                            },
                          )
                        : SizedBox(
                            height: size.height - 200,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                loginIconWidget(),
                                ElevatedButton(
                                  onPressed: () async {
                                    navigatorKey.currentState!
                                        .pushNamed(Signin.id)
                                        .then((_) => setState(() {}));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: kLightGreenColor,
                                    onPrimary: kWhiteColor,
                                  ),
                                  child: const CustomTextStyleOne(
                                    text: 'LogIn to Continue',
                                    fontSize: 20,
                                    myColor: kWhiteColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                ),
              ),
              onConstruction(context, setState, size),
            ],
          ),
        ),
        bottomNavigationBar: menu(),
      ),
    );
  }
}

Widget menu() {
  return Container(
    color: kLightGreenColor,
    child: const TabBar(
      labelColor: kWhiteColor,
      unselectedLabelColor: kBlackColor,
      indicatorColor: kWhiteColor,
      tabs: [
        Tab(
          text: "Upcoming",
          icon: Icon(Icons.update),
        ),
        Tab(
          text: "History",
          icon: Icon(Icons.history),
        ),
      ],
    ),
  );
}

Widget onConstruction(context, setState, size) {
  return RefreshIndicator(
    color: kLightGreenColor,
    onRefresh: () async {
      setState(() {});
      await Future.delayed(const Duration(seconds: 4));
    },
    child: Center(
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Provider.of<LoggedInState>(context, listen: true).isLoggedIn
            ? FutureBuilder<List>(
                future: FreeEventDatabase.historyRegisteredFreeEvent(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return brikshyaLoader();
                  }
                  if (snapshot.hasError) {
                    return networkError();
                  }
                  if (snapshot.data!.isEmpty) {
                    return const NoDataWidget(
                      title: 'No Event Attended!',
                      icondata: Icons.event_busy_sharp,
                    );
                  }
                  final events = snapshot.data!;
                  return Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemCount: events.length,
                        itemBuilder: (context, index) {
                          FreeEvents event =
                              FreeEvents.fromData(data: events[index]);

                          return Card(
                            margin: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 16,
                            ),
                            elevation: 4,
                            color: kWhiteColor,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                  ),
                                  child: Image.network(
                                    event.image,
                                    height: 150,
                                    fit: BoxFit.fitWidth,
                                    errorBuilder:
                                        ((context, error, stackTrace) {
                                      return const SizedBox(
                                        height: 150,
                                        child: Icon(Icons.image_not_supported,
                                            size: 96, color: Colors.black45),
                                      );
                                    }),
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      }
                                      return Center(
                                        child: CircularProgressIndicator(
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
                                              kDarkGreenColor.withOpacity(0.5),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: CustomTextStyleOne(
                                    text: event.title,
                                    myColor: kBlackColor,
                                    fontSize: 16,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8.0,
                                    bottom: 8.0,
                                    right: 8.0,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.location_on_outlined,
                                            color: kDarkGreenColor,
                                            size: 24,
                                          ),
                                          const SizedBox(
                                            width: 4.0,
                                          ),
                                          CustomTextStyleOne(
                                            text: event.location,
                                            myColor: kBlackColor,
                                            fontSize: 16,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8.0,
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.timelapse_sharp,
                                            color: kDarkGreenColor,
                                            size: 24,
                                          ),
                                          const SizedBox(
                                            width: 4.0,
                                          ),
                                          CustomTextStyleOne(
                                            text: DateFormat.yMMMMEEEEd()
                                                .add_jm()
                                                .format(
                                                  DateTime.parse(event.date),
                                                ),
                                            myColor: kBlackColor,
                                            fontSize: 14,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            primary: kLightGreenColor,
                                            onPrimary: kWhiteColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          child: const CustomTextStyleOne(
                                            text: 'Event Attended',
                                            fontSize: 20,
                                            myColor: kWhiteColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
              )
            : SizedBox(
                height: size.height - 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    loginIconWidget(),
                    ElevatedButton(
                      onPressed: () async {
                        navigatorKey.currentState!
                            .pushNamed(Signin.id)
                            .then((_) => setState(() {}));
                      },
                      style: ElevatedButton.styleFrom(
                        primary: kLightGreenColor,
                        onPrimary: kWhiteColor,
                      ),
                      child: const CustomTextStyleOne(
                        text: 'LogIn to Continue',
                        fontSize: 20,
                        myColor: kWhiteColor,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    ),
  );
}
