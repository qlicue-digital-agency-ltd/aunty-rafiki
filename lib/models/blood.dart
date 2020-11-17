import 'package:aunty_rafiki/constants/enums/enums.dart';
import 'package:flutter/material.dart';

class Blood {
  const Blood({
    this.id,
    this.level,
    this.action,
    this.title,
    this.subtitle,
    this.quantity,
  });
  final int id;
  final Level level;
  final Status action;
  final String title;
  final String subtitle;
  final double quantity;

  Blood.fromMap(Map<String, dynamic> map)
      : assert(map['id'] != null),
        id = map['id'],
        title = map['title'],
        subtitle = map['subtitle'],
        quantity = map['quantity'],
        level = map['level'] == "normal" ? Level.normal : Level.low,
        action = map['status'] == "veryWeak"
            ? Status.veryWeak
            : (map['status'] == "weak"
                ? Status.weak
                : (map['status'] == "good")
                    ? Status.good
                    : (map['status'] == "veryGood")
                        ? Status.veryGood
                        : Status.excellent);
}
