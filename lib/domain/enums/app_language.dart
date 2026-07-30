/// Languages supported by Compass for native / target selection.
///
/// Codes follow BCP-47 primary language subtags.
enum AppLanguage {
  en(code: 'en', englishName: 'English', nativeName: 'English'),
  ru(code: 'ru', englishName: 'Russian', nativeName: 'Русский'),
  uz(code: 'uz', englishName: 'Uzbek', nativeName: "O'zbek"),
  de(code: 'de', englishName: 'German', nativeName: 'Deutsch'),
  fr(code: 'fr', englishName: 'French', nativeName: 'Français'),
  es(code: 'es', englishName: 'Spanish', nativeName: 'Español'),
  tr(code: 'tr', englishName: 'Turkish', nativeName: 'Türkçe'),
  zh(code: 'zh', englishName: 'Chinese', nativeName: '中文'),
  ja(code: 'ja', englishName: 'Japanese', nativeName: '日本語'),
  ko(code: 'ko', englishName: 'Korean', nativeName: '한국어'),
  ar(code: 'ar', englishName: 'Arabic', nativeName: 'العربية'),
  it(code: 'it', englishName: 'Italian', nativeName: 'Italiano'),
  pt(code: 'pt', englishName: 'Portuguese', nativeName: 'Português'),
  hi(code: 'hi', englishName: 'Hindi', nativeName: 'हिन्दी');

  const AppLanguage({
    required this.code,
    required this.englishName,
    required this.nativeName,
  });

  final String code;
  final String englishName;
  final String nativeName;

  static AppLanguage fromCode(String code) {
    return AppLanguage.values.firstWhere(
      (language) => language.code == code,
      orElse: () => AppLanguage.en,
    );
  }
}
