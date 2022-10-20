import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:user_app/services/storage.dart';
import '../secrets/secrets.dart';

class CartDatabase {
  static Future<int?> cartTotalPrice() async {
    try {
      String? token = await Storage.getToken();
      Map<String, dynamic> tokenData = jsonDecode(token!);
      final response = await Dio().get(API.endPoint + API.getTotalPrice,
          options: Options(headers: {
            "x-auth-token": tokenData["token"],
          }));
      return response.data;
    } on DioError catch (ex) {
      return ex.response!.statusCode;
    } on PlatformException catch (ex) {
      return -1;
    }
  }

  static Future<int?> addUpdateCart(Map body) async {
    String? token = await Storage.getToken();
    Map<String, dynamic> tokenData = jsonDecode(token!);
    try {
      final response = await Dio().put(API.endPoint + API.userCartAddUpdate,
          data: body,
          options: Options(headers: {
            "x-auth-token": tokenData["token"],
          }));
      return response.statusCode;
    } on DioError catch (ex) {
      return ex.response!.statusCode;
    } on PlatformException catch (ex) {
      await Dio().post(API.endPoint + API.userCartAddUpdate,
          data: body,
          options: Options(headers: {
            "x-auth-token": tokenData["token"],
          }));
      return -1;
    }
  }

  static Future<List> resolveCart(Map body) async {
    String? token = await Storage.getToken();
    Map<String, dynamic> tokenData = jsonDecode(token!);
    try {
      final response = await Dio().put(API.endPoint + API.resolveCart,
          data: body,
          options: Options(headers: {
            "x-auth-token": tokenData["token"],
          }));
      return response.data;
    } on DioError catch (ex) {
      return [];
    } on PlatformException catch (ex) {
      await Dio().post(API.endPoint + API.resolveCart,
          data: body,
          options: Options(headers: {
            "x-auth-token": tokenData["token"],
          }));
      return [];
    }
  }
}
