import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import '../secrets/secrets.dart';
import '../services/storage.dart';

class Authentication {
  static Future<int?> signUp(Map<String, dynamic> body) async {
    try {
      final response = await Dio().post(API.endPoint + API.signUp, data: body);
      final resData = response.data;
      await Storage.setToken(json.encode(resData));
      return response.statusCode!;
    } on DioError catch (ex) {
      return ex.response!.statusCode;
    } on PlatformException catch (ex) {
      await Dio().post(API.endPoint + API.signUp, data: body);
      return -1;
    }
  }

  static Future<int?> signIn(Map<String, dynamic> body) async {
    try {
      final response = await Dio().post(API.endPoint + API.signIn, data: body);
      await Storage.setToken(json.encode(response.data));
      return response.statusCode;
    } on DioError catch (ex) {
      return ex.response!.statusCode;
    } on PlatformException catch (ex) {
      return -1;
    }
  }

  static Future<bool> signOut() async {
    try {
      await Storage.removeToken();
      return true;
    } on PlatformException catch (ex) {
      return false;
    }
  }

  static Future<Map> userProfile() async {
    try {
      String? token = await Storage.getToken();
      Map<String, dynamic> tokenData = jsonDecode(token!);
      final response = await Dio().get(
        API.endPoint + API.userProfile,
        options: Options(
          headers: {
            "x-auth-token": tokenData["token"],
          },
        ),
      );
      return response.data;
    } on DioError catch (ex) {
      return {};
    } on PlatformException catch (ex) {
      return {};
    }
  }

  static Future<int?> updateProfileImage(Map<String, dynamic> body) async {
    try {
      String? token = await Storage.getToken();
      Map<String, dynamic> tokenData = jsonDecode(token!);
      final response = await Dio().put(
        API.endPoint + API.upadateProfileImage,
        data: body,
        options: Options(
          headers: {
            "x-auth-token": tokenData["token"],
          },
        ),
      );

      return response.statusCode!;
    } on DioError catch (ex) {
      return ex.response!.statusCode;
    } on PlatformException catch (ex) {
      await Dio().post(API.endPoint + API.upadateProfileImage, data: body);
      return -1;
    }
  }

  static Future<int?> changeUserName(Map<String, dynamic> body) async {
    try {
      final response =
          await Dio().put(API.endPoint + API.changeUsername, data: body);

      return response.statusCode!;
    } on DioError catch (ex) {
      return ex.response!.statusCode;
    } on PlatformException catch (ex) {
      await Dio().post(API.endPoint + API.changeUsername, data: body);
      return -1;
    }
  }

  static Future<int?> changePhoneNumber(Map<String, dynamic> body) async {
    try {
      final response =
          await Dio().put(API.endPoint + API.changePhonenumber, data: body);
      return response.statusCode!;
    } on DioError catch (ex) {
      return ex.response!.statusCode;
    } on PlatformException catch (ex) {
      await Dio().post(API.endPoint + API.changePhonenumber, data: body);
      return -1;
    }
  }

  static Future<int?> changePassword(Map<String, dynamic> body) async {
    try {
      final response =
          await Dio().put(API.endPoint + API.changePassword, data: body);
      return response.statusCode!;
    } on DioError catch (ex) {
      return ex.response!.statusCode;
    } on PlatformException catch (ex) {
      await Dio().post(API.endPoint + API.changePassword, data: body);
      return -1;
    }
  }
}
