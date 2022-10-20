import 'dart:convert';

// import 'package:user_app/services/storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import '../secrets/secrets.dart';

class Database {
  static Future<List> getCategories() async {
    // final token = await Storage.getToken();
    // Map<String, dynamic> tokenData = json.decode(token!);
    final response = await Dio().get(API.endPoint + API.allCategories);
    // options: Options(headers: {
    //   "x-auth-token": tokenData["token"],
    // }));
    return response.data;
  }

  static Future<List> getAllProducts(String filter) async {
    if (filter == "All") {
      final response = await Dio().get(API.endPoint + API.allProducts);
      return response.data;
    } else {
      final response =
          await Dio().get(API.endPoint + API.categoricalProducts + filter);
      return response.data;
    }
  }
}
