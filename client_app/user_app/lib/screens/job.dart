import 'dart:convert';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:user_app/components/drawer.dart';
import 'package:user_app/constants.dart';
import 'package:user_app/custom_components/customText.dart';
import 'package:user_app/custom_components/custom_widget.dart';
import 'package:user_app/custom_components/multiselect_checkbox.dart';
import 'package:user_app/custom_components/snack_bar.dart';
import 'package:user_app/custom_components/waiting_dialog.dart';
import 'package:user_app/main.dart';
import 'package:user_app/provider/check_box_state.dart';
import 'package:user_app/provider/text_controller_state.dart';
import 'package:user_app/screens/home.dart';
import 'package:user_app/screens/signin.dart';
import 'package:user_app/services/auth.dart';
import 'package:user_app/services/job.dart';
import 'package:user_app/services/storage.dart';

class MyJob extends StatefulWidget {
  const MyJob({Key? key}) : super(key: key);

  static const String id = '/job';
  @override
  State<MyJob> createState() => _MyJobState();
}

class _MyJobState extends State<MyJob> {
  String userId = '';

  List<String> jobPost = [];

  var jobTime = [
    'Full Time',
    'Part Time',
  ];

  List<String> _selectedItems = [];

  void _showMultiSelect() async {
    final List<String> items = [
      'Tractor Driving',
      'Grafting',
      'Accounting',
      'Marketing',
      'Planting',
      'Pot Making',
      'Bonsai Specialist',
      'Cooking',
      'Decoration',
      'Floriculture',
    ];

    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(items: items);
      },
    );
    // Update UI
    if (results != null) {
      setState(() {
        _selectedItems = results;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final dropDown = Provider.of<DropDownState>(context, listen: true);
    final textController =
        Provider.of<JobTextControllerState>(context, listen: false);
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
                  size: 32, // Changing Drawer Icon Size
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
              text: 'Job Inquiry',
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
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 16.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FutureBuilder(
                          future: Storage.getToken(),
                          builder: (context, snapshot) {
                            if (snapshot.data == null) {
                              return SizedBox(
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
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        bottom: 12.0,
                      ),
                      child: FutureBuilder(
                        future: Storage.getToken(),
                        builder: (context, snapshot) {
                          if (snapshot.data == null) {
                            return const Text(
                              'Please, signin to send job request',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 20,
                              ),
                            );
                          } else {
                            Object? token = snapshot.data;
                            final auth = jsonDecode(token.toString());
                            userId = auth['id'];
                            return FutureBuilder<Map>(
                              future: Authentication.userProfile(),
                              builder: ((context, snapshot) {
                                if (!snapshot.hasData) {
                                  return brikshyaLoader();
                                }
                                if (snapshot.hasError) {
                                  return networkError();
                                }
                                if (snapshot.data!.isEmpty) {
                                  return const NoDataWidget(
                                    title: 'No User Info, try refreshing!',
                                    icondata: Icons.person_off_outlined,
                                  );
                                }
                                final userData = snapshot.data;
                                return FutureBuilder<List>(
                                    future: JobDatabase.getVaccancyData(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return brikshyaLoader();
                                      }
                                      if (snapshot.hasError) {
                                        return networkError();
                                      }
                                      if (snapshot.data!.isEmpty) {
                                        return const NoDataWidget(
                                            title: 'Job vaccancy not available',
                                            icondata: Icons
                                                .notifications_off_rounded);
                                      }
                                      final vaccancyData = snapshot.data;
                                      jobPost = List<String>.from(
                                          vaccancyData![0]['job'] as List);

                                      return Column(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(
                                              top: 12.0,
                                            ),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'User Details:',
                                                style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ),
                                          ),
                                          ListTile(
                                            leading: const Icon(
                                              Icons.person,
                                              size: 32,
                                              color: kOrangeColor,
                                            ),
                                            title: Text(
                                              userData!['name'],
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black54,
                                              ),
                                            ),
                                          ),
                                          ListTile(
                                            leading: const Icon(
                                              Icons.phone,
                                              size: 32,
                                              color: kOrangeColor,
                                            ),
                                            title: Text(
                                              userData['phoneNumber']
                                                  .toString(),
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black54,
                                              ),
                                            ),
                                          ),
                                          FutureBuilder<List>(
                                              future: JobDatabase.getJobData(),
                                              builder: (context, snapshot) {
                                                if (!snapshot.hasData) {
                                                  return brikshyaLoader();
                                                }
                                                if (snapshot.hasError) {
                                                  return networkError();
                                                }
                                                if (snapshot.data!.isEmpty) {
                                                  return Column(
                                                    children: [
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          top: 14.0,
                                                        ),
                                                        child: Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            'Enter the following details:',
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .black54,
                                                              fontSize: 20,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          top: 8.0,
                                                          bottom: 4.0,
                                                        ),
                                                        child:
                                                            JobDataInputWidget(
                                                          hintText:
                                                              'Enter Custom Address',
                                                          labelText: 'address',
                                                          inputController: Provider
                                                                  .of<JobTextControllerState>(
                                                                      context,
                                                                      listen:
                                                                          true)
                                                              .userAddressController,
                                                          fieldIcon: Icons
                                                              .add_location_alt_outlined,
                                                          inputType:
                                                              TextInputType
                                                                  .streetAddress,
                                                        ),
                                                      ),
                                                      Provider.of<JobTextControllerState>(
                                                                      context,
                                                                      listen:
                                                                          true)
                                                                  .userAddressController
                                                                  .text ==
                                                              ''
                                                          ? const Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Text(
                                                                ' Address Required',
                                                                style:
                                                                    TextStyle(
                                                                  color:
                                                                      kOrangeColor,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                ),
                                                              ),
                                                            )
                                                          : Container(),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          top: 16.0,
                                                        ),
                                                        child:
                                                            JobDataInputWidget(
                                                          hintText:
                                                              'Enter Your Email',
                                                          labelText: 'email',
                                                          inputController: Provider
                                                                  .of<JobTextControllerState>(
                                                                      context,
                                                                      listen:
                                                                          true)
                                                              .userEmailController,
                                                          fieldIcon: Icons
                                                              .email_outlined,
                                                          inputType:
                                                              TextInputType
                                                                  .emailAddress,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          top: 16.0,
                                                        ),
                                                        child:
                                                            JobDataInputWidget(
                                                          hintText:
                                                              'Alternate mobile number',
                                                          labelText:
                                                              'mobile number',
                                                          inputController: Provider
                                                                  .of<JobTextControllerState>(
                                                                      context,
                                                                      listen:
                                                                          true)
                                                              .userPhoneController,
                                                          fieldIcon:
                                                              Icons.phone,
                                                          inputType:
                                                              TextInputType
                                                                  .number,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          top: 16.0,
                                                          bottom: 4.0,
                                                        ),
                                                        child:
                                                            JobDataInputWidget(
                                                          hintText:
                                                              'Enter Your Age',
                                                          labelText: 'age',
                                                          inputController: Provider
                                                                  .of<JobTextControllerState>(
                                                                      context,
                                                                      listen:
                                                                          true)
                                                              .userAgeController,
                                                          fieldIcon: Icons
                                                              .date_range_outlined,
                                                          inputType:
                                                              TextInputType
                                                                  .number,
                                                        ),
                                                      ),
                                                      Provider.of<JobTextControllerState>(
                                                                      context,
                                                                      listen:
                                                                          true)
                                                                  .userAgeController
                                                                  .text ==
                                                              ''
                                                          ? const Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Text(
                                                                ' Age Required',
                                                                style:
                                                                    TextStyle(
                                                                  color:
                                                                      kOrangeColor,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                ),
                                                              ),
                                                            )
                                                          : Container(),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          top: 20.0,
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                              width:
                                                                  size.width /
                                                                          2 -
                                                                      20,
                                                              height: 48,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                color:
                                                                    kDarkGreenColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .all(
                                                                  Radius
                                                                      .circular(
                                                                          5),
                                                                ),
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            8.0),
                                                                child:
                                                                    DropdownButton(
                                                                  hint: Text(
                                                                    dropDown.jobPost ==
                                                                            ''
                                                                        ? 'Select Job Post'
                                                                        : dropDown
                                                                            .jobPost,
                                                                    style:
                                                                        const TextStyle(
                                                                      color:
                                                                          kWhiteColor,
                                                                      fontSize:
                                                                          16,
                                                                    ),
                                                                  ),
                                                                  isDense: true,
                                                                  borderRadius:
                                                                      const BorderRadius
                                                                          .all(
                                                                    Radius
                                                                        .circular(
                                                                            5),
                                                                  ),
                                                                  enableFeedback:
                                                                      true,
                                                                  isExpanded:
                                                                      true,
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .keyboard_arrow_down),
                                                                  iconEnabledColor:
                                                                      kWhiteColor,
                                                                  items: jobPost
                                                                      .map((String
                                                                          items) {
                                                                    return DropdownMenuItem(
                                                                      value:
                                                                          items,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(
                                                                          top:
                                                                              8.0,
                                                                        ),
                                                                        child: Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Text(items),
                                                                              const Divider(
                                                                                color: kMediumGreenColor,
                                                                              ),
                                                                            ]),
                                                                      ),
                                                                    );
                                                                  }).toList(),
                                                                  onChanged:
                                                                      (String?
                                                                          newValue) {
                                                                    dropDown.changeJobPost(
                                                                        newValue!);
                                                                  },
                                                                  dropdownColor:
                                                                      kWhiteColor,
                                                                  style:
                                                                      const TextStyle(
                                                                    color:
                                                                        kDarkGreenColor,
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              width:
                                                                  size.width /
                                                                          2 -
                                                                      20,
                                                              height: 48,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                color:
                                                                    kDarkGreenColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .all(
                                                                  Radius
                                                                      .circular(
                                                                          5),
                                                                ),
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            8.0),
                                                                child:
                                                                    DropdownButton(
                                                                  hint: Text(
                                                                    dropDown.jobTime ==
                                                                            ''
                                                                        ? 'Select Job Type'
                                                                        : dropDown
                                                                            .jobTime,
                                                                    style:
                                                                        const TextStyle(
                                                                      color:
                                                                          kWhiteColor,
                                                                      fontSize:
                                                                          16,
                                                                    ),
                                                                  ),
                                                                  isDense: true,
                                                                  isExpanded:
                                                                      true,
                                                                  borderRadius:
                                                                      const BorderRadius
                                                                          .all(
                                                                    Radius
                                                                        .circular(
                                                                            5),
                                                                  ),
                                                                  enableFeedback:
                                                                      true,
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .keyboard_arrow_down),
                                                                  iconEnabledColor:
                                                                      kWhiteColor,
                                                                  items: jobTime
                                                                      .map((String
                                                                          items) {
                                                                    return DropdownMenuItem(
                                                                      value:
                                                                          items,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(
                                                                          top:
                                                                              8.0,
                                                                        ),
                                                                        child: Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Text(items),
                                                                              const Divider(
                                                                                color: kMediumGreenColor,
                                                                              ),
                                                                            ]),
                                                                      ),
                                                                    );
                                                                  }).toList(),
                                                                  onChanged:
                                                                      (String?
                                                                          newValue) {
                                                                    dropDown.changeJobTime(
                                                                        newValue!);
                                                                  },
                                                                  dropdownColor:
                                                                      kWhiteColor,
                                                                  style:
                                                                      const TextStyle(
                                                                    color:
                                                                        kDarkGreenColor,
                                                                    fontSize:
                                                                        14,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          bottom: 16.0,
                                                          top: 4.0,
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            dropDown.jobPost ==
                                                                    ''
                                                                ? const Text(
                                                                    ' Job Post Required',
                                                                    style:
                                                                        TextStyle(
                                                                      color:
                                                                          kOrangeColor,
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w300,
                                                                    ),
                                                                  )
                                                                : Container(),
                                                            dropDown.jobTime ==
                                                                    ''
                                                                ? const Text(
                                                                    ' Job Type Required',
                                                                    style:
                                                                        TextStyle(
                                                                      color:
                                                                          kOrangeColor,
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w300,
                                                                    ),
                                                                  )
                                                                : Container(),
                                                          ],
                                                        ),
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          // use this button to open the multi-select dialog
                                                          SizedBox(
                                                            width:
                                                                double.infinity,
                                                            child:
                                                                ElevatedButton(
                                                              onPressed:
                                                                  _showMultiSelect,
                                                              autofocus: true,
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                primary:
                                                                    kDarkGreenColor,
                                                                onPrimary:
                                                                    kWhiteColor,
                                                              ),
                                                              child:
                                                                  const CustomTextStyleOne(
                                                                text:
                                                                    'Select Your Skills Set',
                                                                myColor:
                                                                    kWhiteColor,
                                                                fontFamily:
                                                                    redhat,
                                                              ),
                                                            ),
                                                          ),
                                                          const Divider(),
                                                          // display selected items
                                                          const Text(
                                                            ' Selected Skills: ',
                                                            style: TextStyle(
                                                              color:
                                                                  kDarkGreenColor,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                          _selectedItems
                                                                  .isNotEmpty
                                                              ? Wrap(
                                                                  children:
                                                                      _selectedItems
                                                                          .map((e) =>
                                                                              Padding(
                                                                                padding: const EdgeInsets.only(
                                                                                  right: 4.0,
                                                                                ),
                                                                                child: Chip(
                                                                                  backgroundColor: Colors.black38,
                                                                                  label: Text(
                                                                                    e,
                                                                                    style: const TextStyle(
                                                                                      color: kWhiteColor,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ))
                                                                          .toList(),
                                                                )
                                                              : const Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                    top: 8.0,
                                                                    bottom:
                                                                        16.0,
                                                                  ),
                                                                  child: Text(
                                                                    ' Skills Not Selected',
                                                                    style:
                                                                        TextStyle(
                                                                      color:
                                                                          kOrangeColor,
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                    ),
                                                                  ),
                                                                ),
                                                          const Divider(),
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          bottom: 24.0,
                                                        ),
                                                        child: SizedBox(
                                                          width:
                                                              double.infinity,
                                                          height: 48,
                                                          child: ElevatedButton(
                                                            onPressed:
                                                                () async {
                                                              if (userId ==
                                                                  '') {
                                                                showSnackBar(
                                                                  context,
                                                                  'LogIn to Continue',
                                                                  Colors.red,
                                                                );
                                                              } else {
                                                                if (textController
                                                                            .userAddressController
                                                                            .text ==
                                                                        '' ||
                                                                    textController
                                                                            .userAgeController
                                                                            .text ==
                                                                        '') {
                                                                  showSnackBar(
                                                                    context,
                                                                    'Address and Age are required field',
                                                                    Colors.red,
                                                                  );
                                                                } else {
                                                                  if (dropDown
                                                                          .jobPost ==
                                                                      '') {
                                                                    showSnackBar(
                                                                      context,
                                                                      'Select Job Post',
                                                                      Colors
                                                                          .red,
                                                                    );
                                                                  } else {
                                                                    if (dropDown
                                                                            .jobTime ==
                                                                        '') {
                                                                      showSnackBar(
                                                                        context,
                                                                        'Select Job Type',
                                                                        Colors
                                                                            .red,
                                                                      );
                                                                    } else {
                                                                      showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (context) =>
                                                                                const WaitingDialog(title: "Processing"),
                                                                      );
                                                                      try {
                                                                        final number = textController.userPhoneController.text ==
                                                                                ''
                                                                            ? '0'
                                                                            : textController.userPhoneController.text;
                                                                        Map<String,
                                                                                dynamic>
                                                                            data =
                                                                            {
                                                                          "email": textController
                                                                              .userEmailController
                                                                              .text,
                                                                          "phone":
                                                                              int.parse(number),
                                                                          "address": textController
                                                                              .userAddressController
                                                                              .text,
                                                                          "post":
                                                                              dropDown.jobPost,
                                                                          "parttime": dropDown.jobTime == 'Part Time'
                                                                              ? true
                                                                              : false,
                                                                          "age": int.parse(textController
                                                                              .userAgeController
                                                                              .text),
                                                                          "skills":
                                                                              _selectedItems,
                                                                        };
                                                                        final result =
                                                                            await JobDatabase.addJobRequest(data);
                                                                        navigatorKey
                                                                            .currentState!
                                                                            .pop();
                                                                        if (result! ~/
                                                                                100 ==
                                                                            2) {
                                                                          showSnackBar(
                                                                            context,
                                                                            'Job Request Sent Successfully!',
                                                                            kLightGreenColor,
                                                                          );
                                                                          dropDown
                                                                              .changeJobPost('');
                                                                          dropDown
                                                                              .changeJobTime('');
                                                                          textController
                                                                              .userAddressController
                                                                              .text = '';
                                                                          textController
                                                                              .userAgeController
                                                                              .text = '';
                                                                          textController
                                                                              .userEmailController
                                                                              .text = '';
                                                                          textController
                                                                              .userPhoneController
                                                                              .text = '';
                                                                          _selectedItems =
                                                                              [];
                                                                          setState(
                                                                              () {});
                                                                        } else {
                                                                          showSnackBar(
                                                                            context,
                                                                            'Could not send Job Request!',
                                                                            Colors.red,
                                                                          );
                                                                        }
                                                                      } catch (ex) {
                                                                        navigatorKey
                                                                            .currentState!
                                                                            .pop();
                                                                        showSnackBar(
                                                                          context,
                                                                          'something went wrong, try again',
                                                                          Colors
                                                                              .red,
                                                                        );
                                                                      }
                                                                    }
                                                                  }
                                                                }
                                                              }
                                                            },
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              primary:
                                                                  kLightGreenColor,
                                                              onPrimary:
                                                                  kWhiteColor,
                                                            ),
                                                            child:
                                                                const CustomTextStyleOne(
                                                              text:
                                                                  'Send Job Request',
                                                              fontFamily:
                                                                  redhat,
                                                              fontSize: 20,
                                                              myColor:
                                                                  kWhiteColor,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                }
                                                final data = snapshot.data!;
                                                Map<String, dynamic> jobData =
                                                    data[0];
                                                Map<String, dynamic> userData =
                                                    jobData['user'];
                                                List<dynamic> skillsData =
                                                    jobData['skills'];
                                                return Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Card(
                                                      margin: const EdgeInsets
                                                          .symmetric(
                                                        vertical: 12,
                                                        horizontal: 16,
                                                      ),
                                                      elevation: 4,
                                                      color: kWhiteColor,
                                                      shape:
                                                          const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(12),
                                                        ),
                                                      ),
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            height: 56,
                                                            decoration:
                                                                const BoxDecoration(
                                                              color:
                                                                  kLightGreenColor,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        12),
                                                                topRight: Radius
                                                                    .circular(
                                                                        12),
                                                              ),
                                                            ),
                                                            child: jobData[
                                                                    'verification']
                                                                ? const Center(
                                                                    child: Text(
                                                                      'Your Job Request Verified',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style:
                                                                          TextStyle(
                                                                        color:
                                                                            kWhiteColor,
                                                                        fontSize:
                                                                            24,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                      ),
                                                                    ),
                                                                  )
                                                                : const Center(
                                                                    child: Text(
                                                                      'Manage your job request',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style:
                                                                          TextStyle(
                                                                        color:
                                                                            kWhiteColor,
                                                                        fontSize:
                                                                            24,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                      ),
                                                                    ),
                                                                  ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                              left: 16.0,
                                                              right: 16.0,
                                                              bottom: 16.0,
                                                            ),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: const [
                                                                        Padding(
                                                                          padding:
                                                                              EdgeInsets.only(
                                                                            top:
                                                                                8.0,
                                                                            bottom:
                                                                                8.0,
                                                                          ),
                                                                          child:
                                                                              CustomTextStyleOne(
                                                                            text:
                                                                                'Name:  ',
                                                                            myColor:
                                                                                kDarkGreenColor,
                                                                          ),
                                                                        ),
                                                                        CustomTextStyleOne(
                                                                          text:
                                                                              'Phone:  ',
                                                                          myColor:
                                                                              kDarkGreenColor,
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              EdgeInsets.only(
                                                                            top:
                                                                                8.0,
                                                                            bottom:
                                                                                8.0,
                                                                          ),
                                                                          child:
                                                                              CustomTextStyleOne(
                                                                            text:
                                                                                'Email:  ',
                                                                            myColor:
                                                                                kDarkGreenColor,
                                                                          ),
                                                                        ),
                                                                        CustomTextStyleOne(
                                                                          text:
                                                                              'Address:  ',
                                                                          myColor:
                                                                              kDarkGreenColor,
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              EdgeInsets.only(
                                                                            top:
                                                                                8.0,
                                                                            bottom:
                                                                                8.0,
                                                                          ),
                                                                          child:
                                                                              CustomTextStyleOne(
                                                                            text:
                                                                                'Age:  ',
                                                                            myColor:
                                                                                kDarkGreenColor,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.only(
                                                                            top:
                                                                                8.0,
                                                                            bottom:
                                                                                8.0,
                                                                          ),
                                                                          child:
                                                                              CustomTextStyleOne(text: userData['name']),
                                                                        ),
                                                                        CustomTextStyleOne(
                                                                            text:
                                                                                userData['phoneNumber'].toString()),
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.only(
                                                                            top:
                                                                                8.0,
                                                                            bottom:
                                                                                8.0,
                                                                          ),
                                                                          child:
                                                                              CustomTextStyleOne(
                                                                            text:
                                                                                jobData['email'],
                                                                            fontSize: jobData['email'].length > 22
                                                                                ? 13
                                                                                : 15,
                                                                          ),
                                                                        ),
                                                                        CustomTextStyleOne(
                                                                            text:
                                                                                jobData['address'].toString()),
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.only(
                                                                            top:
                                                                                8.0,
                                                                            bottom:
                                                                                8.0,
                                                                          ),
                                                                          child:
                                                                              CustomTextStyleOne(text: jobData['age'].toString()),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      top: 8.0),
                                                                  child: Row(
                                                                    children: const [
                                                                      CustomTextStyleOne(
                                                                        text:
                                                                            'skills:',
                                                                        myColor:
                                                                            kDarkGreenColor,
                                                                      ),
                                                                      CustomTextStyleOne(
                                                                        text:
                                                                            ' [',
                                                                        myColor:
                                                                            kLightGreenColor,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                ListView
                                                                    .builder(
                                                                        shrinkWrap:
                                                                            true,
                                                                        physics:
                                                                            const ScrollPhysics(),
                                                                        itemCount:
                                                                            skillsData
                                                                                .length,
                                                                        itemBuilder:
                                                                            (context,
                                                                                index) {
                                                                          String
                                                                              skill =
                                                                              skillsData[index];

                                                                          return Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(
                                                                              top: 8.0,
                                                                              bottom: 8.0,
                                                                            ),
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.only(left: 16.0),
                                                                              child: CustomTextStyleOne(
                                                                                text: skill,
                                                                              ),
                                                                            ),
                                                                          );
                                                                        }),
                                                                const CustomTextStyleOne(
                                                                  text: ' ]',
                                                                  myColor:
                                                                      kLightGreenColor,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        const Padding(
                                                                          padding:
                                                                              EdgeInsets.only(
                                                                            top:
                                                                                8.0,
                                                                          ),
                                                                          child:
                                                                              CustomTextStyleOne(
                                                                            text:
                                                                                'Position:   ',
                                                                            myColor:
                                                                                kDarkGreenColor,
                                                                          ),
                                                                        ),
                                                                        const Padding(
                                                                          padding:
                                                                              EdgeInsets.only(
                                                                            top:
                                                                                8.0,
                                                                            bottom:
                                                                                8.0,
                                                                          ),
                                                                          child:
                                                                              CustomTextStyleOne(
                                                                            text:
                                                                                'Job Type:   ',
                                                                            myColor:
                                                                                kDarkGreenColor,
                                                                          ),
                                                                        ),
                                                                        jobData['verification']
                                                                            ? Container()
                                                                            : const CustomTextStyleOne(
                                                                                text: 'Verifcation:   ',
                                                                                myColor: kDarkGreenColor,
                                                                              ),
                                                                        jobData['verification']
                                                                            ? const Padding(
                                                                                padding: EdgeInsets.only(
                                                                                  top: 8.0,
                                                                                  bottom: 8.0,
                                                                                ),
                                                                                child: CustomTextStyleOne(
                                                                                  text: 'Vist Date:   ',
                                                                                  myColor: kOrangeColor,
                                                                                ),
                                                                              )
                                                                            : Container(),
                                                                      ],
                                                                    ),
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.only(
                                                                            top:
                                                                                8.0,
                                                                          ),
                                                                          child:
                                                                              CustomTextStyleOne(
                                                                            text:
                                                                                jobData['post'],
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.only(
                                                                            top:
                                                                                8.0,
                                                                            bottom:
                                                                                8.0,
                                                                          ),
                                                                          child:
                                                                              CustomTextStyleOne(
                                                                            text: jobData['parttime']
                                                                                ? 'Part Time'
                                                                                : 'Full Time',
                                                                          ),
                                                                        ),
                                                                        jobData['verification']
                                                                            ? Container()
                                                                            : const CustomTextStyleOne(
                                                                                text: 'Pending ',
                                                                              ),
                                                                        jobData['verification']
                                                                            ? Padding(
                                                                                padding: const EdgeInsets.only(
                                                                                  top: 8.0,
                                                                                  bottom: 8.0,
                                                                                ),
                                                                                child: CustomTextStyleOne(
                                                                                  text: jobData['visitdate'].toString().substring(0, 10),
                                                                                  myColor: kOrangeColor,
                                                                                ),
                                                                              )
                                                                            : Container(),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                                jobData['verification']
                                                                    ? Container()
                                                                    : Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(top: 16.0),
                                                                        child:
                                                                            SizedBox(
                                                                          width:
                                                                              double.infinity,
                                                                          height:
                                                                              48,
                                                                          child:
                                                                              ElevatedButton.icon(
                                                                            icon:
                                                                                const CustomTextStyleOne(
                                                                              text: 'Cancle Request',
                                                                              fontSize: 20,
                                                                              myColor: kWhiteColor,
                                                                            ),
                                                                            label:
                                                                                const Icon(
                                                                              Icons.delete_forever,
                                                                              size: 40,
                                                                              color: kWhiteColor,
                                                                            ),
                                                                            onPressed:
                                                                                () async {
                                                                              showDialog(
                                                                                context: context,
                                                                                builder: (context) => const WaitingDialog(title: "Processing"),
                                                                              );
                                                                              final result = await JobDatabase.cancleJobRequest(jobData['_id']);
                                                                              navigatorKey.currentState!.pop();
                                                                              if (result! ~/ 100 == 2) {
                                                                                showSnackBar(
                                                                                  context,
                                                                                  'Request cancled Successfully!',
                                                                                  kLightGreenColor,
                                                                                );
                                                                                setState(() {});
                                                                              } else {
                                                                                showSnackBar(
                                                                                  context,
                                                                                  'Something went wrong, try again!',
                                                                                  Colors.red,
                                                                                );
                                                                              }
                                                                            },
                                                                            style:
                                                                                ElevatedButton.styleFrom(
                                                                              primary: kLightRedColor,
                                                                              onPrimary: kWhiteColor,
                                                                              shape: RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius.circular(10),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              })
                                        ],
                                      );
                                    });
                              }),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class JobDataInputWidget extends StatelessWidget {
  const JobDataInputWidget({
    Key? key,
    required this.hintText,
    required this.labelText,
    required this.inputController,
    required this.fieldIcon,
    required this.inputType,
  }) : super(key: key);
  final String hintText;
  final String labelText;
  final TextEditingController inputController;
  final IconData fieldIcon;
  final TextInputType inputType;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextFormField(
          controller: inputController,
          maxLines: 1,
          autofocus: false,
          decoration: InputDecoration(
            hintText: hintText,
            labelText: labelText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(
                color: kBlackColor,
                width: 2,
              ),
            ),
            focusColor: kDarkGreenColor,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(
                color: kDarkGreenColor,
                width: 2,
              ),
            ),
            labelStyle: const TextStyle(
              color: kMediumGreenColor,
              fontSize: 14,
            ),
            prefixIcon: Icon(
              fieldIcon,
              color: kOrangeColor,
            ),
            hintStyle: TextStyle(
              fontSize: 16,
              color: kBlackColor.withOpacity(0.2),
            ),
          ),
          cursorColor: kDarkGreenColor,
          keyboardType: inputType,
          onFieldSubmitted: (val) {
            inputController.text = val.toString();
          }),
    );
  }
}
