class LanguageData {
  final int id;
  final String flag;
  final String name;
  final String languageCode;

  LanguageData(this.id, this.flag, this.name, this.languageCode);

  static List<LanguageData> languageList() {
    return <LanguageData>[
      LanguageData(1, "🇺🇸", "English", 'en'),
      LanguageData(2, "🇸🇦", "اَلْعَرَبِيَّةُ‎", "ar"),
      LanguageData(3, "🇹🇿", "Swahili", 'sw'),
    ];
  }
}
