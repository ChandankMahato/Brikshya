import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import '../secrets/secrets.dart';

class ProductDatabase {
  static Future<List> getCategories() async {
    try {
      final response = await Dio().get(API.endPoint + API.getCategories);
      return response.data;
    } on DioError catch (ex) {
      return [];
    } on PlatformException catch (ex) {
      return [];
    }
  }

  static Future<List> allProduct(String filter) async {
    try {
      if (filter == "All") {
        final response = await Dio().get(API.endPoint + API.allProducts);
        return response.data;
      } else {
        final response =
            await Dio().get(API.endPoint + API.categoricalProducts + filter);
        return response.data;
      }
    } on DioError catch (ex) {
      return [];
    } on PlatformException catch (ex) {
      return [];
    }
  }

  static Future<List> multipleProductDetails(List body) async {
    try {
      final response = await Dio()
          .post(API.endPoint + API.multipleProductDetails, data: body);
      return response.data;
    } on DioError catch (ex) {
      return [];
    } on PlatformException catch (ex) {
      return [];
    }
  }

  static Future<List> allListing() async {
    try {
      final response = await Dio().get(API.endPoint + API.allListings);
      return response.data;
    } on DioError catch (ex) {
      return [];
    } on PlatformException catch (ex) {
      return [];
    }
  }
}
