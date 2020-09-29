import 'package:flutter/material.dart';

class Appointment {
  String name;
  String profession;
  String date;
  String time;
  bool syncToCalender;
  String additionalNotes;
  Appointment(
      {@required this.name,
      @required this.profession,
      @required this.date,
      @required this.time,
      this.syncToCalender = false,
      this.additionalNotes});
}
