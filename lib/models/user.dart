import 'package:flutter/material.dart';

class User {
  final String displayName;
  final List<String> groups;
  final String nameInitials;
  final String phoneNumber;
  final String photoUrl;
  final String uid;

  User(
      {@required this.phoneNumber,
      this.displayName,
      this.groups,
      this.nameInitials,
      this.photoUrl,
      @required this.uid});

  User.fromMap(Map<String, dynamic> map)
      : assert(map['uid'] != null),
        assert(map['phoneNumber'] != null),
        uid = map['uid'],
        phoneNumber = map['phoneNumber'],
        displayName = map['displayName'],
        nameInitials = map['nameInitials'],
        photoUrl = map['photoUrl'],
        groups = map['groups'];
}
