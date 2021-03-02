import 'package:flutter/material.dart';

class Profile {
  final int id;
  final String avatar;
  final String phone;
  final String gender;
  final String location;
  final int userId;

  Profile(
      {@required this.id,
      @required this.userId,
      @required this.avatar,
      @required this.phone,
      @required this.gender,
      @required this.location});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'user_id': userId,
      'avatar': avatar,
      'phone': phone,
      'location': location,
      'gender': gender,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  Profile.fromMap(Map<String, dynamic> map)
      : assert(map['id'] != null),
        assert(map['user_id'] != null),
        id = map['id'],
        userId = int.parse(map['user_id'].toString()),
        avatar = map['avatar'].toString(),
        phone = map['phone'].toString(),
        gender = map['gender'].toString(),
        location = map['location'].toString();
}
