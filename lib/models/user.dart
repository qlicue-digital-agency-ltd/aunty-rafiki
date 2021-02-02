import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class User {
  final String displayName;
  final List<dynamic> groups;
  final String nameInitials;
  final String phoneNumber;
  final String photoUrl;
  final String uid;
  final int gravida;
  final int haemoLevel;
  final Timestamp haemoLevelDate;
  final Timestamp lastDateTetanusVaccine;
  final int numberOfDeliveries;
  final int numberOfNormalDeliveries;
  final int numberOfOperationDeliveries;
  final String onMedication;
  final int pregnancyWeeks;
  final String startedClinic;
  final String takenTetanusVaccine;
  final int yearOfBirth;

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
      @required this.uid});

  User.fromMap(Map<String, dynamic> map)
      : uid = map['uid'],
        phoneNumber = map['phoneNumber'],
        displayName = map['displayName'],
        nameInitials = map['nameInitials'],
        photoUrl = map['photoUrl'],
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
        photoUrl = doc.data()['photoUrl'],
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
