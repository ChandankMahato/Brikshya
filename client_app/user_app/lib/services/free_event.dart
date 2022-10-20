import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:user_app/services/storage.dart';
import '../secrets/secrets.dart';

class FreeEventDatabase {
  static Future<int?> registerFreeEvent(String eventId) async {
    try {
      String? token = await Storage.getToken();
      Map<String, dynamic> tokenData = jsonDecode(token!);
      final response = await Dio().put(
        API.endPoint + API.registerUser + eventId,
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

  static Future<int?> unregisterFreeEvent(String eventId) async {
    try {
      String? token = await Storage.getToken();
      Map<String, dynamic> tokenData = jsonDecode(token!);
      final response = await Dio().put(
        API.endPoint + API.unregisterUser + eventId,
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

  static Future<List> upcommingFreeEvent() async {
    try {
      final response = await Dio().get(API.endPoint + API.upcomingFreeEvents);
      return response.data;
    } on DioError catch (ex) {
      return [];
    } on PlatformException catch (ex) {
      return [];
    }
  }

  static Future<List> historyFreeEvent() async {
    try {
      final response = await Dio().get(API.endPoint + API.finishedFreeEvents);
      return response.data;
    } on DioError catch (ex) {
      return [];
    } on PlatformException catch (ex) {
      return [];
    }
  }

  static Future<List> upcommingRegisteredFreeEvent() async {
    try {
      String? token = await Storage.getToken();
      Map<String, dynamic> tokenData = jsonDecode(token!);
      final response = await Dio().get(
        API.endPoint + API.upcomingRegisteredFreeEvents,
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

  static Future<List> historyRegisteredFreeEvent() async {
    try {
      String? token = await Storage.getToken();
      Map<String, dynamic> tokenData = jsonDecode(token!);
      final response = await Dio().get(
        API.endPoint + API.finishedRegisteredFreeEvents,
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
