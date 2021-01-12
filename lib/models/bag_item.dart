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

List<BagItem> motherBagList = <BagItem>[
  BagItem(id: 1, name: 'Birth plan', isPacked: false, owner: "mother"),
  BagItem(id: 2, name: 'Book magazine', isPacked: false, owner: "mother"),
  BagItem(id: 3, name: 'Breast pads', isPacked: false, owner: "mother"),
  BagItem(
      id: 4, name: 'Camera and batteries', isPacked: false, owner: "mother"),
  BagItem(id: 5, name: 'Dressing gown', isPacked: false, owner: "mother"),
  BagItem(id: 6, name: 'Facecloth of fan', isPacked: false, owner: "mother"),
  BagItem(
      id: 7,
      name: 'Gift for your older children',
      isPacked: false,
      owner: "mother"),
  BagItem(id: 8, name: 'Glucose tablets', isPacked: false, owner: "mother"),
  BagItem(id: 9, name: 'Going home outfit', isPacked: false, owner: "mother"),
];

List<BagItem> partnerBagList = <BagItem>[
  BagItem(id: 1, name: 'Birth plan', isPacked: false, owner: "partner"),
  BagItem(id: 2, name: 'Book magazine', isPacked: false, owner: "partner"),
  BagItem(id: 3, name: 'Breast pads', isPacked: false, owner: "partner"),
  BagItem(
      id: 4, name: 'Camera and batteries', isPacked: false, owner: "partner"),
  BagItem(id: 5, name: 'Dressing gown', isPacked: false, owner: "partner"),
  BagItem(id: 6, name: 'Facecloth of fan', isPacked: false, owner: "partner"),
  BagItem(
      id: 7,
      name: 'Gift for your older children',
      isPacked: false,
      owner: "partner"),
  BagItem(id: 8, name: 'Glucose tablets', isPacked: false, owner: "partner"),
  BagItem(id: 9, name: 'Going home outfit', isPacked: false, owner: "partner"),
];

List<BagItem> babyBagList = <BagItem>[
  BagItem(id: 1, name: 'Birth plan', isPacked: false, owner: "baby"),
  BagItem(id: 2, name: 'Book magazine', isPacked: false, owner: "baby"),
  BagItem(id: 3, name: 'Breast pads', isPacked: false, owner: "baby"),
  BagItem(id: 4, name: 'Camera and batteries', isPacked: false, owner: "baby"),
  BagItem(id: 5, name: 'Dressing gown', isPacked: false, owner: "baby"),
  BagItem(id: 6, name: 'Facecloth of fan', isPacked: false, owner: "baby"),
  BagItem(
      id: 7,
      name: 'Gift for your older children',
      isPacked: false,
      owner: "baby"),
  BagItem(id: 8, name: 'Glucose tablets', isPacked: false, owner: "baby"),
  BagItem(id: 9, name: 'Going home outfit', isPacked: false, owner: "baby"),
];
