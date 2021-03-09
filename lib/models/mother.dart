import 'package:flutter/material.dart';

class Mother {
  final int id;
  final String uuid;
  final String conceptionDate;

  Mother({
    @required this.id,
    @required this.uuid,
    @required this.conceptionDate,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'uuid': uuid,
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
        uuid = map['uuid'],
        conceptionDate = map['conception_date'];
}
