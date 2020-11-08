import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class User {
  final String displayName;
  final List<dynamic> groups;
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
      : uid = map['uid'],
        phoneNumber = map['phoneNumber'],
        displayName = map['displayName'],
        nameInitials = map['nameInitials'],
        photoUrl = map['photoUrl'],
        groups = map['groups'];

  User.fromFirestore(DocumentSnapshot doc)
      : uid = doc.id,
        phoneNumber = doc.data()['phoneNumber'],
        displayName = doc.data()['displayName'],
        nameInitials = doc.data()['nameInitials'],
        photoUrl = doc.data()['photoUrl'],
        groups = doc.data()['groups'];
}

List<User> firestoreToUserList(QuerySnapshot snapshot) {
  return snapshot.docs.map((doc) => User.fromFirestore(doc)).toList();
}

