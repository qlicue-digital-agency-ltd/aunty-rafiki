import 'package:flutter/material.dart';
import 'package:aunty_rafiki/constants/enums/enums.dart';
import 'package:intl/intl.dart';

class Tracker {
  Tracker(
      {@required this.id,
      @required this.title,
      @required this.subtitle,
      @required this.body,
      this.media,
      @required this.type,
      @required this.day,
       @required this.days,
      @required this.color,
      @required this.week,
      this.time,
      @required this.show});

  Tracker.fromMap(Map<String, dynamic> map)
      : assert(map['id'] != null),
        id = map['id'],
        title = map['title'],
        subtitle = map['subtitle'],
        body = map['body'],
        media = map['media'],
        time = DateTime.parse(map['time']),
        type = map['type'] == "line" ? Type.line : Type.checkpoint,
        day = format.format(DateTime.parse(map['time'])),
        week = map['week'],
        days = map['days'],
        show = true,
        color =
            map['type'] == "checkpoint" ? Colors.pink : colors[map['id'] % 7];

  //color List
  static final colors = <Color>[
    Colors.blue,
    Colors.green,
    Colors.red,
    Colors.cyan,
    Colors.yellow,
    Colors.brown,
    Colors.teal
  ];


  final String body;
  final Color color;
  final String day;
  final int id;
  final int days;
  final String media;
  bool show;
  final String subtitle;
  final DateTime time;
  final String title;
  final Type type;
  final int week;

  bool get isCheckpoint => type == Type.checkpoint;

  bool get hasDay => day != null && day.isNotEmpty;
  static final DateFormat format = DateFormat("EE");
}
