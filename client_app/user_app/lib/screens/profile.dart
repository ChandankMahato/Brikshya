import 'dart:io';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:user_app/components/drawer.dart';
import 'package:user_app/constants.dart';
import 'package:user_app/custom_components/customText.dart';
import 'package:user_app/custom_components/custom_widget.dart';
import 'package:user_app/custom_components/snack_bar.dart';
import 'package:user_app/custom_components/waiting_dialog.dart';
import 'package:user_app/main.dart';
import 'package:user_app/screens/home.dart';
import 'package:user_app/services/auth.dart';
import 'package:user_app/services/cloudStorage.dart';
import 'package:user_app/services/storage.dart';
import 'package:image_picker/image_picker.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  static const String id = "/userprofile";

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  void uploadImage(String name, File tempImage) async {
    showDialog(
      context: context,
      builder: (context) => const WaitingDialog(title: 'Uploading...'),
    );
    final uploadResult = await CloudStorage.uploadImage(
      'users',
      tempImage,
      name.trim().split(" ").join("-"),
    );
    if (uploadResult == "error") {
      navigatorKey.currentState!.pop();
      showSnackBar(
        context,
        "Image couldnot be uploaded",
        Colors.red,
      );
      return;
    }
    try {
      Map<String, dynamic> data = {"image": uploadResult};
      final result = await Authentication.updateProfileImage(data);
      if (result! ~/ 100 == 2) {
        setState(() {});
        navigatorKey.currentState!.pop();
        showSnackBar(
          context,
          'Image uploaded successfully!',
          kLightGreenColor,
        );
      } else {
        navigatorKey.currentState!.pop();
        showSnackBar(
          context,
          "Image couldnot be uploaded",
          Colors.red,
        );
      }
    } catch (ex) {
      navigatorKey.currentState!.pop();
      showSnackBar(
        context,
        "Something went wrong, try again!",
        Colors.red,
      );
    }
  }

  Future getCameraImage(String name) async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.camera,
      );
      if (image == null) return;
      final tempImage = File(image.path);
      uploadImage(name, tempImage);
    } catch (ex) {
      showSnackBar(
        context,
        "something went wrong, try again!",
        Colors.red,
      );
    }
  }

  Future getGalleryImage(String name) async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      if (image == null) return;
      final tempImage = File(image.path);
      uploadImage(name, tempImage);
    } catch (ex) {
      showSnackBar(
        context,
        "something went wrong, try again!",
        Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  size: 32,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
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
              text: 'My Profile',
              fontSize: 24,
              myColor: kDarkGreenColor,
              fontFamily: redhat,
            ),
          ),
        ),
      ),
      drawer: const AppDrawer(),
      body: SafeArea(
        child: RefreshIndicator(
          color: kLightGreenColor,
          onRefresh: () async {
            setState(() {});
            await Future.delayed(const Duration(seconds: 4));
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FutureBuilder(
                future: Storage.getToken(),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return loginIconWidget();
                  } else {
                    return FutureBuilder<Map>(
                      future: Authentication.userProfile(),
                      builder: ((context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: brikshyaLoader());
                        }
                        if (snapshot.hasError) {
                          return const Center(
                            heightFactor: 2.0,
                            child: NoDataWidget(
                              title: 'No User Info, try refreshing!',
                              icondata: Icons.person_off_outlined,
                            ),
                          );
                        }
                        if (snapshot.data!.isEmpty) {
                          return const Center(
                            heightFactor: 2.0,
                            child: NoDataWidget(
                              title: 'No User Info, try refreshing!',
                              icondata: Icons.person_off_outlined,
                            ),
                          );
                        }
                        final userData = snapshot.data;
                        return Center(
                          child: Column(
                            children: [
                              Center(
                                child: Stack(
                                  children: [
                                    CircleAvatar(
                                      radius: 80.0,
                                      backgroundImage: (userData!['image']
                                              .isEmpty)
                                          ? Image.asset("images/default.png")
                                              .image
                                          : Image.network(
                                              userData['image'],
                                              fit: BoxFit.fill,
                                            ).image,
                                    ),
                                    Positioned(
                                      bottom: -5.0,
                                      right: -5.0,
                                      child: InkWell(
                                        onTap: () {
                                          showModalBottomSheet(
                                              context: context,
                                              builder: ((builder) =>
                                                  bottomSheet(userData['_id']
                                                      as String)));
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: kGreyLightColor,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.all(2.0),
                                            child: Icon(
                                              Icons.camera,
                                              color: kDarkGreenColor,
                                              size: 40.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 12.0,
                                  bottom: 4.0,
                                ),
                                child: CustomTextStyleOne(
                                  text: userData['name'],
                                  fontSize: 24,
                                  weight: FontWeight.w500,
                                  myColor: kOrangeColor,
                                  fontFamily: redhat,
                                ),
                              ),
                              CustomTextStyleOne(
                                text: userData['phoneNumber'].toString(),
                                fontSize: 20,
                                weight: FontWeight.w500,
                                myColor: kDarkGreenColor,
                                fontFamily: redhat,
                              ),
                            ],
                          ),
                        );
                      }),
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomSheet(String name) {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          const Text(
            "Chose profile photo",
            style: TextStyle(
              fontSize: 24.0,
              color: kDarkGreenColor,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  getCameraImage(name);
                  navigatorKey.currentState!.pop();
                },
                icon: const Icon(Icons.camera),
                label: const Text('Camera'),
                style: ElevatedButton.styleFrom(
                  primary: kDarkGreenColor,
                  onPrimary: kWhiteColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  getGalleryImage(name);
                  navigatorKey.currentState!.pop();
                },
                icon: const Icon(Icons.image),
                label: const Text('Gallery'),
                style: ElevatedButton.styleFrom(
                  primary: kDarkGreenColor,
                  onPrimary: kWhiteColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
