import 'package:aunty_rafiki/models/bag_item.dart';
import 'package:aunty_rafiki/service/database/helper/database_helper.dart';
import 'package:sqflite/sqflite.dart';

//constants
final String tableBagItem = 'items';
final String columnId = 'id';
final String columnOwner = 'owner';
final String columnName = 'name';
final String columnIsPacked = 'isPacked';

class BagItemQueryBuilder {
  static final DatabaseHelper _instance = DatabaseHelper.privateConstructor();

  Future<BagItem> insert(BagItem bagItem) async {
    Database db = await _instance.database;
    bagItem.id = await db.insert(tableBagItem, bagItem.toMap());
    return bagItem;
  }

  Future<BagItem> getBagItem(int id) async {
    Database db = await _instance.database;
    List<Map> maps = await db.query(tableBagItem,
        columns: [
          columnId,
          columnOwner,
          columnName,
          columnIsPacked,
        ],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return BagItem.fromMap(maps.first);
    }
    return null;
  }

  Future<List<BagItem>> getAllBagItems() async {
    Database db = await _instance.database;
    final List<BagItem> _fetchedBagItems = [];
    List<Map<String, dynamic>> records = await db.query(tableBagItem);
    if (records.length > 0) {
      records.forEach((bagItemData) {
        final bagItem = BagItem.fromMap(bagItemData);

        _fetchedBagItems.add(bagItem);
      });
     

      return List<BagItem>.from(_fetchedBagItems);
    }
    return <BagItem>[];
  }

  Future<List<BagItem>> getAllBagItemsWithTrashed() async {
    Database db = await _instance.database;
    final List<BagItem> _fetchedBagItems = [];
    List<Map<String, dynamic>> records = await db.query(tableBagItem);
    if (records.length > 0) {
      records.forEach((bagItemData) {
        final bagItem = BagItem.fromMap(bagItemData);

        _fetchedBagItems.add(bagItem);
      });
      return _fetchedBagItems;
    }
    return <BagItem>[];
  }

  Future<int> update(BagItem bagItem) async {
    Database db = await _instance.database;
    return await db.update(tableBagItem, bagItem.toMap(),
        where: '$columnId = ?', whereArgs: [bagItem.id]);
  }
}
