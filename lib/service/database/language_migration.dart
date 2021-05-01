 
import 'package:sqflite/sqflite.dart';

import 'language_query_builder.dart';

class LanguageMigration {
  Future createLanguageTable(Database db) async {
    try {
      await db.execute('''
create table $tableLanguage ( 
  $columnId integer primary key autoincrement, 
  $columnName text not null,
  $columnFlag text,
  $columnLanguageCode integer not null 
  
  )
''');
    } catch (error) {
      print(error);
    }
  }
}
