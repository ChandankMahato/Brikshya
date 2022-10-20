import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class CloudStorage {
  static final instance = FirebaseStorage.instance;

  //uploads file in firebase storage
  static Future<String> uploadImage(
    String type,
    File image,
    String fileName,
  ) async {
    try {
      final ref = instance.ref(type);
      await ref.child(fileName).putFile(image);
      String url = await imageUrl('$type/$fileName');
      return url;
    } catch (e) {
      return "error";
    }
  }

  static Future<String> imageUrl(String address) async {
    try {
      return await instance.ref(address).getDownloadURL();
    } catch (e) {
      throw "error";
    }
  }
}
