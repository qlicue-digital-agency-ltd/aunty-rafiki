//constants
 
import 'package:aunty_rafiki/models/language_data.dart';
import 'package:sqflite/sqflite.dart';

import 'database_helper.dart';

final String tableLanguage = 'languages';
final String columnId = 'id';
final String columnFlag = 'flag';
final String columnName = 'name';
final String columnLanguageCode = 'languageCode';

class LanguageQueryBuilder {
  static final DatabaseHelper _instance = DatabaseHelper.privateConstructor();

  Future<LanguageData> insert(LanguageData language) async {
    Database db = await _instance.database;
    language.id = await db.insert(tableLanguage, language.toMap());
    return language;
  }

  Future<LanguageData> getLanguage(int id) async {
    Database db = await _instance.database;
    List<Map> maps = await db.query(tableLanguage,
        columns: [columnId, columnFlag, columnName, columnLanguageCode],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return LanguageData.fromMap(maps.first);
    }
    return null;
  }

  Future<List<LanguageData>> getAllLanguages() async {
    Database db = await _instance.database;
    final List<LanguageData> _fetchedLanguages = [];
    List<Map<String, dynamic>> records = await db.query(tableLanguage);

    if (records.length > 0) {
      records.forEach((languageData) {
        final language = LanguageData.fromMap(languageData);

        _fetchedLanguages.add(language);
      });

   
      return List<LanguageData>.from(_fetchedLanguages);
    }
    return <LanguageData>[];
  }

  Future<List<LanguageData>> getAllLanguagesWithTrashed() async {
    Database db = await _instance.database;
    final List<LanguageData> _fetchedLanguages = [];
    List<Map<String, dynamic>> records = await db.query(tableLanguage);

    if (records.length > 0) {
      records.forEach((languageData) {
        final language = LanguageData.fromMap(languageData);

        _fetchedLanguages.add(language);
      });
      return _fetchedLanguages;
    }
    return <LanguageData>[];
  }

  Future<int> update(LanguageData language) async {
    Database db = await _instance.database;
    return await db.update(tableLanguage, language.toMap(),
        where: '$columnId = ?', whereArgs: [language.id]);
  }
}
