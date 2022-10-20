import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:user_app/services/storage.dart';
import '../secrets/secrets.dart';

class JobDatabase {
  static Future<int?> addJobRequest(Map<String, dynamic> body) async {
    try {
      String? token = await Storage.getToken();
      Map<String, dynamic> tokenData = jsonDecode(token!);
      final response = await Dio().post(
        API.endPoint + API.addJobRequest,
        data: body,
        options: Options(
          headers: {
            "x-auth-token": tokenData["token"],
          },
        ),
      );
      return response.statusCode;
    } on DioError {
      return 404;
    } on PlatformException catch (ex) {
      return -1;
    }
  }

  static Future<int?> cancleJobRequest(String jobId) async {
    try {
      String? token = await Storage.getToken();
      Map<String, dynamic> tokenData = jsonDecode(token!);
      final response = await Dio().delete(
        API.endPoint + API.cancelJobRequest + jobId,
        options: Options(
          headers: {
            "x-auth-token": tokenData["token"],
          },
        ),
      );
      return response.statusCode;
    } on DioError {
      return 404;
    } on PlatformException {
      return -1;
    }
  }

  static Future<List> getJobData() async {
    try {
      String? token = await Storage.getToken();
      Map<String, dynamic> tokenData = jsonDecode(token!);
      final response = await Dio().get(
        API.endPoint + API.getJobRequest,
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

  static Future<List> getVaccancyData() async {
    try {
      String? token = await Storage.getToken();
      Map<String, dynamic> tokenData = jsonDecode(token!);
      final response = await Dio().get(
        API.endPoint + API.getJobTrainingvaccancy,
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
