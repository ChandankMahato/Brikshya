import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:user_app/services/storage.dart';
import '../secrets/secrets.dart';

class TrainingDatabase {
  static Future<int?> addTrainingRequest(Map<String, dynamic> body) async {
    try {
      String? token = await Storage.getToken();
      Map<String, dynamic> tokenData = jsonDecode(token!);
      final response = await Dio().post(
        API.endPoint + API.addTrainingRequest,
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

  static Future<int?> cancleTrainingRequest(String trainingId) async {
    try {
      String? token = await Storage.getToken();
      Map<String, dynamic> tokenData = jsonDecode(token!);
      final response = await Dio().delete(
        API.endPoint + API.cancelTrainingRequest + trainingId,
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

  static Future<List> getTrainingData() async {
    try {
      String? token = await Storage.getToken();
      Map<String, dynamic> tokenData = jsonDecode(token!);
      final response = await Dio().get(
        API.endPoint + API.getTrainingRequest,
        options: Options(
          headers: {
            "x-auth-token": tokenData["token"],
          },
        ),
      );
      return response.data;
    } on DioError {
      return [];
    } on PlatformException {
      return [];
    }
  }
}
