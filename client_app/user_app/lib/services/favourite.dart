import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:user_app/services/storage.dart';
import '../secrets/secrets.dart';

class FavouriteDatabase {
  static Future<int?> addUpdateFavourite(List<dynamic> body) async {
    String? token = await Storage.getToken();
    Map<String, dynamic> tokenData = jsonDecode(token!);
    try {
      final response = await Dio().put(
        API.endPoint + API.addUpdateUserFavourites,
        data: body,
        options: Options(
          headers: {
            "x-auth-token": tokenData["token"],
          },
        ),
      );
      return response.statusCode;
    } on DioError catch (ex) {
      return ex.response!.statusCode;
    } on PlatformException catch (ex) {
      await Dio().post(
        API.endPoint + API.addUpdateUserFavourites,
        data: body,
        options: Options(
          headers: {
            "x-auth-token": tokenData["token"],
          },
        ),
      );
      return -1;
    }
  }

  static Future<List> resolveFavourite(Map body) async {
    String? token = await Storage.getToken();
    Map<String, dynamic> tokenData = jsonDecode(token!);
    try {
      final response = await Dio().put(
        API.endPoint + API.resolveFavourites,
        data: body,
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
      await Dio().post(
        API.endPoint + API.resolveFavourites,
        data: body,
        options: Options(
          headers: {
            "x-auth-token": tokenData["token"],
          },
        ),
      );
      return [];
    }
  }
}
