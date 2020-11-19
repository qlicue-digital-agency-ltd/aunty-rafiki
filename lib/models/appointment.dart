import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Appointment {
  final int id;
  final String name;
  final String profession;
  final String date;
  final String time;
  bool syncToCalendar;
  String additionalNotes;
  Appointment(
      {@required this.id,
      @required this.name,
      @required this.profession,
      @required this.date,
      @required this.time,
      this.syncToCalendar = false,
      this.additionalNotes});

     static final DateFormat formatter = DateFormat('yyyy-MM-dd');

  Appointment.fromMap(Map<String, dynamic> map)
      : assert(map['id'] != null),
        id = map['id'],
        name = map['name'],
        profession = map['profession'],
        date = formatter.format(DateTime.parse(map['date'])) ,
        time = map['time'],
        additionalNotes = map['additional_notes'],
        syncToCalendar = map['sync_to_calendar'];
}
