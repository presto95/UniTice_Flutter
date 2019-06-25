import 'package:shared_preferences/shared_preferences.dart';

class User {
  static final String _universityKey = "university";
  static final String _keywordsKey = "keywords";

  static Future<SharedPreferences> get preferences =>
      SharedPreferences.getInstance();

  static Future<String> get university async =>
      (await preferences).getString(_universityKey);

  static Future<void> setUniversity(String university) async =>
      (await preferences).setString(_universityKey, university);

  static Future<List<String>> get keywords async =>
      (await preferences).getStringList(_keywordsKey);

  static Future<void> setKeywords(List<String> keywords) async =>
      (await preferences).setStringList(_keywordsKey, keywords);
}
