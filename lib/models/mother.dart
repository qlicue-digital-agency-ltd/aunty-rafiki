import 'package:flutter/material.dart';

class Mother {
  final int id;
  final String uid;
  final String conceptionDate;

  Mother({
    @required this.id,
    @required this.uid,
    @required this.conceptionDate,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'uid': uid,
      'conception_date': conceptionDate
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  Mother.fromMap(Map<String, dynamic> map)
      : assert(map['id'] != null),
        id = map['id'],
        uid = map['uid'],
        conceptionDate = map['conception_date'];
}
