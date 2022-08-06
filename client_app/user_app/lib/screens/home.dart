import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:user_app/components/appbar.dart';
import 'package:user_app/components/banner.dart';
import 'package:user_app/components/category.dart';
import 'package:user_app/components/footer.dart';
import 'package:user_app/components/popular.dart';
import 'package:user_app/components/product.dart';
import 'package:user_app/constants.dart';
import 'package:user_app/main.dart';
import 'package:user_app/models/onboarding_content.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  static const String id = "/home";

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _showBackToTopButton = false;

  // scroll controller
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          if (_scrollController.offset >= 200) {
            _showBackToTopButton = true; // show the back-to-top button
          } else {
            _showBackToTopButton = false; // hide the back-to-top button
          }
        });
      });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose(); // dispose the controller
    super.dispose();
  }

  // This function is triggered when the user presses the back-to-top button
  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(seconds: 1), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: CustomAppBar(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              CustomBanner(),
              CategorysWidget(),
              PopularWdiget(),
              ProductWidget(),
              FooterWidget(),
            ],
          ),
        ),
      ),
      floatingActionButton: _showBackToTopButton == false
          ? null
          : Padding(
              padding: const EdgeInsets.only(bottom: 64.0),
              child: FloatingActionButton(
                onPressed: _scrollToTop,
                backgroundColor: kOrangeColor,
                child: const Icon(
                  Icons.arrow_upward,
                ),
              ),
            ),
    );
  }
}
