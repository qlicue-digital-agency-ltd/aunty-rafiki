import 'package:aunty_rafiki/service/database/query-builder/items_query_builder.dart';
import 'package:flutter/foundation.dart';

class BagItem {
  int id;
  final String name;
  final String owner;
  bool isPacked;

  BagItem({
    @required this.id,
    @required this.name,
    @required this.isPacked,
    @required this.owner,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnName: name,
      columnIsPacked: isPacked,
      columnOwner: owner
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  BagItem.fromMap(Map<String, dynamic> map)
      : assert(map[columnId] != null),
        assert(map[columnName] != null),
        id = map[columnId],
        owner = map[columnOwner],
        name = map[columnName],
        isPacked = map[columnIsPacked] == 1 ? true : false;
}
