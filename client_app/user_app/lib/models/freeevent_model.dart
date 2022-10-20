import 'package:user_app/secrets/secrets.dart';

class FreeEvents {
  late String id;
  late String image;
  late String title;
  late String date;
  late String location;

  FreeEvents.fromData({required Map<String, dynamic> data}) {
    id = data['_id'];
    image = data['image'];
    title = data['title'];
    date = data['date'];
    location = data['location'];
  }
}
