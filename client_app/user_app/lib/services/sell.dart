import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:user_app/services/storage.dart';
import '../secrets/secrets.dart';

class SellsDatabase {
  static Future<int?> addSellRequest(Map<String, dynamic> body) async {
    try {
      String? token = await Storage.getToken();
      Map<String, dynamic> tokenData = jsonDecode(token!);
      final response = await Dio().post(
        API.endPoint + API.sellRequest,
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

  static Future<int?> cancleSellRequest(String orderId) async {
    try {
      String? token = await Storage.getToken();
      Map<String, dynamic> tokenData = jsonDecode(token!);
      final response = await Dio().delete(
        API.endPoint + API.cancleRequest + orderId,
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

  static Future<List> getPendingRequest() async {
    try {
      String? token = await Storage.getToken();
      Map<String, dynamic> tokenData = jsonDecode(token!);
      final response = await Dio().get(
        API.endPoint + API.pendingRequest,
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

  static Future<List> userSellsHistory() async {
    try {
      String? token = await Storage.getToken();
      Map<String, dynamic> tokenData = jsonDecode(token!);
      final response = await Dio().get(
        API.endPoint + API.sellsHistory,
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
