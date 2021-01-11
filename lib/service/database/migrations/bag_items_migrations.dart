import 'package:aunty_rafiki/service/database/query-builder/items_query_builder.dart';
import 'package:sqflite/sqflite.dart';

class BagItemMigration {
  Future createBagItemsTable(Database db) async {
    try {
      await db.execute('''
create table $tableBagItem ( 
  $columnId integer primary key autoincrement, 
  $columnName text not null,
  $columnOwner text,
  $columnIsPacked integer not null
  )
''');
    } catch (error) {
      print(error);
    }
  }
}
