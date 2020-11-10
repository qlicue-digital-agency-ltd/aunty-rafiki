import 'package:flutter/material.dart';
import 'package:aunty_rafiki/constants/enums/enums.dart';

class Tracker {
  final int id;
  final String title;
  final String subtitle;
  final String body;
  final String media;
  final DateTime time;
  final Type type;
  final String day;
  final Color color;
  final int week;
  bool show;

  Tracker(
      {@required this.id,
      @required this.title,
      @required this.subtitle,
      @required this.body,
      this.media,
      @required this.type,
      @required this.day,
      @required this.color,
      @required this.week,
      this.time,
      @required this.show});

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

  bool get isCheckpoint => type == Type.checkpoint;

  bool get hasDay => day != null && day.isNotEmpty;

  Tracker.fromMap(Map<String, dynamic> map)
      : assert(map['id'] != null),
        id = map['id'],
        title = map['title'],
        subtitle = map['subtitle'],
        body = map['body'],
        media = map['media'],
        time = DateTime.now(),
        type = map['type'] == "line" ? Type.line : Type.checkpoint,
        day = map['day'],
        week = map['week'],
        show = true,
        color =
            map['type'] == "checkpoint" ? Colors.pink : colors[map['id'] % 7];
}
