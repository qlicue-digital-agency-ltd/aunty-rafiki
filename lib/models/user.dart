import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class User {
  String displayName;
  List<dynamic> groups;
  String nameInitials;
  String phoneNumber;
  String photoUrl;
  String uid;
  int gravida;
  int haemoLevel;
  Timestamp haemoLevelDate;
  Timestamp lastDateTetanusVaccine;
  int numberOfDeliveries;
  int numberOfNormalDeliveries;
  int numberOfOperationDeliveries;
  String onMedication;
  int pregnancyWeeks;
  String startedClinic;
  String takenTetanusVaccine;
  int yearOfBirth;
  bool isAdmin=false;

  User(
      {@required this.phoneNumber,
      this.displayName,
      this.groups,
      this.nameInitials,
      this.photoUrl,
      this.gravida,
      this.haemoLevel,
      this.haemoLevelDate,
      this.lastDateTetanusVaccine,
      this.numberOfDeliveries,
      this.numberOfNormalDeliveries,
      this.numberOfOperationDeliveries,
      this.onMedication,
      this.pregnancyWeeks,
      this.startedClinic,
      this.takenTetanusVaccine,
      this.yearOfBirth,
      this.isAdmin ,
      @required this.uid});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      phoneNumber: phoneNumber,
      displayName: displayName,
      nameInitials: nameInitials,
      photoUrl: photoUrl,
    };

    return map;
  }

  User.fromMap(Map<String, dynamic> map)
      : uid = map['uid'],
        phoneNumber = map['phoneNumber'],
        displayName = map['displayName'],
        nameInitials = map['nameInitials'],
        isAdmin = map['isAdmin'],
        photoUrl = map['photoURL'],
        gravida = map['gravida'],
        haemoLevel = map['haemoLevel'],
        haemoLevelDate = map['haemoLevelDate'],
        lastDateTetanusVaccine = map['lastDateTetanusVaccine'],
        numberOfDeliveries = map['numberOfDeliveries'],
        numberOfNormalDeliveries = map['numberOfNormalDeliveries'],
        numberOfOperationDeliveries = map['numberOfOperationDeliveries'],
        onMedication = map['onMedication'],
        pregnancyWeeks = map['pregnancyWeeks'],
        startedClinic = map['startedClinic'],
        takenTetanusVaccine = map['takenTetanusVaccine'],
        yearOfBirth = map['yearOfBirth'],
        groups = map['groups'];

  User.fromFirestore(DocumentSnapshot doc)
      : uid = doc.id,
        phoneNumber = doc.data()['phoneNumber'],
        displayName = doc.data()['displayName'],
        nameInitials = doc.data()['nameInitials'],
        photoUrl = doc.data()['photoURL'],
        isAdmin = doc.data()['isAdmin'],
        gravida = doc.data()['gravida'],
        haemoLevel = doc.data()['haemoLevel'],
        haemoLevelDate = doc.data()['haemoLevelDate'],
        lastDateTetanusVaccine = doc.data()['lastDateTetanusVaccine'],
        numberOfDeliveries = doc.data()['numberOfDeliveries'],
        numberOfNormalDeliveries = doc.data()['numberOfNormalDeliveries'],
        numberOfOperationDeliveries = doc.data()['numberOfOperationDeliveries'],
        onMedication = doc.data()['onMedication'],
        pregnancyWeeks = doc.data()['pregnancyWeeks'],
        startedClinic = doc.data()['startedClinic'],
        takenTetanusVaccine = doc.data()['takenTetanusVaccine'],
        yearOfBirth = doc.data()['yearOfBirth'],
        groups = doc.data()['groups'];
}

List<User> firestoreToUserList(QuerySnapshot snapshot) {
  return snapshot.docs.map((doc) => User.fromFirestore(doc)).toList();
}
