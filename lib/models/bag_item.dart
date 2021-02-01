import 'package:flutter/foundation.dart';

class BagItem {
  int id;
  final String name;
  final String owner;
  final String type;
  final String uid;
  bool isPacked;

  BagItem({
    @required this.id,
    @required this.name,
    @required this.isPacked,
    @required this.owner,
    @required this.type,
    @required this.uid,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'name': name,
      'is_packed': isPacked,
      'owner': owner,
      'type': type,
      'uid': uid,
      'id': id
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  BagItem.fromMap(Map<String, dynamic> map)
      : assert(map['id'] != null),
        assert(map['name'] != null),
        id = map['id'],
        owner = map['owner'],
        name = map['name'],
        type = map['type'],
        uid = map['uid'],
        isPacked = map['is_packed'] == 1 ? true : false;
}
