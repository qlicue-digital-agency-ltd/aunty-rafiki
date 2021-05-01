import 'package:aunty_rafiki/service/database/language_query_builder.dart';

class LanguageData {
  int id;
  final String flag;
  final String name;
  final String languageCode;

  LanguageData(this.id, this.flag, this.name, this.languageCode);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnName: name,
      columnFlag: flag,
      columnLanguageCode: languageCode
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  LanguageData.fromMap(Map<String, dynamic> map)
      : assert(map[columnName] != null),
        id = map[columnId],
        name = map[columnName],
        flag = map[columnFlag],
        languageCode = map[columnLanguageCode];

  static List<LanguageData> languageList() {
    return <LanguageData>[
      LanguageData(1, "🇺🇸", "English", 'en'),
      LanguageData(1, "🇹🇿", "Swahili", 'sw'),
    ];
  }
}
