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
      : assert(map['appointment_id'] != null),
        id = map['appointment_id'],
        name = map['appointment_name'],
        profession = map['appointment_profession'],
        date = formatter.format(DateTime.parse(map['appointment_date'])) ,
        time = map['appointment_time'],
        additionalNotes = map['appointment_additional_notes'],
        syncToCalendar = map['appointment_sync_to_calendar'];
}
