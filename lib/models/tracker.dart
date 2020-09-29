import 'package:flutter/material.dart';

class Tracker {
  final String headText;
  final String subheadText;
  final String supportText;
  final String media;
  final DateTime time;

  Tracker({
    @required this.headText,
    @required this.subheadText,
    @required this.supportText,
    @required this.media,
    this.time,
  });
}
