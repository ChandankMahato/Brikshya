import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:user_app/models/banner_content.dart';

class CustomBanner extends StatelessWidget {
  const CustomBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List banners = [
      {'image': 'images/banners/banner1.png'},
      {'image': 'images/banners/banner2.png'},
      {'image': 'images/banners/banner3.jpg'},
      {'image': 'images/banners/banner4.jpg'},
      {'image': 'images/banners/banner5.jpg'},
    ];

    return Center(
      child: CarouselSlider.builder(
        itemCount: banners.length,
        itemBuilder: (context, index, realIndex) {
          final banner = Banners.fromData(data: banners[index]);
          return buildImage(banner.image, index);
        },
        options: CarouselOptions(
          height: size.height / 3.5,
          autoPlay: true,
          viewportFraction: 1,
        ),
      ),
    );
  }

  Widget buildImage(String image, int index) => Container(
        color: Colors.grey,
        child: Image.asset(
          image,
          fit: BoxFit.fill,
        ),
      );
}
