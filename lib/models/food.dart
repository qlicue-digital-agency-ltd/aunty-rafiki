import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Food {
  final int id;
  final String title;
  final String subtitle;
  final String body;
  final String cover;

  Food({
    @required this.id,
    @required this.title,
    @required this.subtitle,
    @required this.body,
    @required this.cover,
  });

  static final DateFormat formatter = DateFormat('yyyy-MM-dd');

  Food.fromMap(Map<String, dynamic> map)
      : assert(map['id'] != null),
        id = map['id'],
        title = map['title'],
        subtitle = map['subtitle'],
        body = map['body'],
        cover = map['cover'];
}
