import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:user_app/services/storage.dart';
import '../secrets/secrets.dart';

class OrderDatabase {
  static Future<int?> placeUserOrder(Map<String, dynamic> body) async {
    try {
      String? token = await Storage.getToken();
      Map<String, dynamic> tokenData = jsonDecode(token!);
      final response = await Dio().post(
        API.endPoint + API.placeOrder,
        data: body,
        options: Options(
          headers: {
            "x-auth-token": tokenData["token"],
          },
        ),
      );
      return response.statusCode;
    } on DioError catch (ex) {
      return 404;
    } on PlatformException catch (ex) {
      return -1;
    }
  }

  static Future<int?> cancleUserOrder(String orderId) async {
    try {
      String? token = await Storage.getToken();
      Map<String, dynamic> tokenData = jsonDecode(token!);
      final response = await Dio().delete(
        API.endPoint + API.cancleOrder + orderId,
        options: Options(
          headers: {
            "x-auth-token": tokenData["token"],
          },
        ),
      );
      return response.statusCode;
    } on DioError catch (ex) {
      return 404;
    } on PlatformException catch (ex) {
      return -1;
    }
  }

  static Future<List> getUnpackedOrder() async {
    try {
      String? token = await Storage.getToken();
      Map<String, dynamic> tokenData = jsonDecode(token!);
      final response = await Dio().get(
        API.endPoint + API.unpackedOrder,
        options: Options(
          headers: {
            "x-auth-token": tokenData["token"],
          },
        ),
      );
      return response.data;
    } on DioError catch (ex) {
      return [];
    } on PlatformException catch (ex) {
      return [];
    }
  }

  static Future<List> userOrderHistory() async {
    try {
      String? token = await Storage.getToken();
      Map<String, dynamic> tokenData = jsonDecode(token!);
      final response = await Dio().get(
        API.endPoint + API.orderHistory,
        options: Options(
          headers: {
            "x-auth-token": tokenData["token"],
          },
        ),
      );
      return response.data;
    } on DioError catch (ex) {
      return [];
    } on PlatformException catch (ex) {
      return [];
    }
  }
}
