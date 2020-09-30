import 'package:flutter/material.dart';

class Appointment {
  String name;
  String profession;
  String date;
  String time;
  bool syncToCalendar;
  String additionalNotes;
  Appointment(
      {@required this.name,
      @required this.profession,
      @required this.date,
      @required this.time,
      this.syncToCalendar = false,
      this.additionalNotes});
}
