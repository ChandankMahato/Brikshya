import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import '../secrets/secrets.dart';

class Database {
  static Future<int?> userExists(String phoneNumber) async {
    try {
      final response = await Dio().get(
        API.endPoint + API.userExists + phoneNumber,
      );
      return response.statusCode!;
    } on DioError catch (ex) {
      return ex.response!.statusCode;
    } on PlatformException catch (ex) {
      return -1;
    }
  }
}
