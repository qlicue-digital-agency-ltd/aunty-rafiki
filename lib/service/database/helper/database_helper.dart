import 'dart:io';

import 'package:aunty_rafiki/service/database/migrations/bag_items_migrations.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseName = "uzzar_pro.db";
  static final _databaseVersion = 1;

  ///migrations
  BagItemMigration _bagItemMigration = BagItemMigration();

  // make this a singleton class
  DatabaseHelper.privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    ///create product table
    await _bagItemMigration.createBagItemsTable(db);
  }

  Future<bool> deleteDataBase(path) async {
    // Delete the database
    await deleteDatabase(path);
    return true;
  }
}
