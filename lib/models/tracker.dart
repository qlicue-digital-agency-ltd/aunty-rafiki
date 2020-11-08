import 'package:flutter/material.dart';
import 'package:aunty_rafiki/constants/enums/enums.dart';

class Tracker {
  final int id;
  final String headText;
  final String subheadText;
  final String supportText;
  final String media;
  final DateTime time;
  final Type type;
  final String day;
  final Color color;
  final int week;
  bool show;

  Tracker(
      {@required this.id,
      @required this.headText,
      @required this.subheadText,
      @required this.supportText,
      this.media,
      @required this.type,
      @required this.day,
      @required this.color,
      @required this.week,
      this.time,
      @required this.show});

  bool get isCheckpoint => type == Type.checkpoint;

  bool get hasDay => day != null && day.isNotEmpty;
}
