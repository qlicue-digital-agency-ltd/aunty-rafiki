import 'package:aunty_rafiki/constants/enums/enums.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Task {
  final int id;
  final String name;
  final String category;
  final String date;
  final String time;
  TodoTask stage;
  bool reminder;

  Task({
    @required this.id,
    @required this.name,
    @required this.category,
    @required this.date,
    @required this.time,
    this.stage = TodoTask.INCOMING,
    this.reminder = false,
  });

  static final DateFormat formatter = DateFormat('yyyy-MM-dd');

  Task.fromMap(Map<String, dynamic> map)
      : assert(map['id'] != null),
        id = map['id'],
        name = map['name'],
        category = map['category'],
        date = formatter.format(DateTime.parse(map['date'])),
        time = map['time'],
        stage = map['stage'] == "completed"
            ? TodoTask.COMPLETED
            : (map['stage'] == "incoming"
                ? TodoTask.INCOMING
                : TodoTask.INCOMPLETE),
        reminder = map['reminder'];
}
