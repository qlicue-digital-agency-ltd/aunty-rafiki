import 'package:flutter/material.dart';
import 'package:aunty_rafiki/constants/enums/enums.dart';
import 'package:intl/intl.dart';

import 'img.dart';

class Tracker {
  Tracker(
      {@required this.id,
      @required this.title,
      @required this.subtitle,
      @required this.body,
      @required this.normal,
      @required this.abnormal,
      @required this.content,
      @required this.images,
      @required this.type,
      @required this.day,
      @required this.days,
      @required this.color,
      @required this.week,
      this.time,
      @required this.show});

  Tracker.fromMap(Map<String, dynamic> map)
      : assert(map['tracker_id'] != null),
        id = map['tracker_id'],
        title = map['tracker_title'],
        subtitle = map['tracker_subtitle'],
        body = map['tracker_body'],
        content = map['tracker_content'],
        normal = map['tracker_normal'],
        abnormal = map['tracker_abnormal'],
        time = DateTime.parse(map['tracker_time']),
        type = map['tracker_type'] == "line" ? Type.line : Type.checkpoint,
        day = format.format(DateTime.parse(map['tracker_time'])),
        week = map['tracker_week'],
        days = map['tracker_days'],
        show = true,
        color = map['tracker_type'] == "checkpoint"
            ? Colors.pink
            : colors[map['tracker_id'] % 7],
        images = map['images'] != null
            ? (map['images'] as List).map((i) => Img.fromMap(i)).toList()
            : null;

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

  String body;
  Color color;
  String day;
  int id;
  int days;
  String normal;
  String abnormal;
  String content;
  bool show;
  String subtitle;
  DateTime time;
  String title;
  Type type;
  int week;
  List<Img> images;

  bool get isCheckpoint => type == Type.checkpoint;

  bool get hasDay => day != null && day.isNotEmpty;
  static DateFormat format = DateFormat("EE");
}
