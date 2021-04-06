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
      : assert(map['bagItem_id'] != null),
        assert(map['bagItem_name'] != null),
        id = map['bagItem_id'],
        owner = map['bagItem_owner'],
        name = map['bagItem_name'],
        type = map['bagItem_type'],
        uid = map['bagItem_uid'],
        isPacked = map['bagItem_is_packed'] == 1 ? true : false;
}
