import 'package:shared_preferences/shared_preferences.dart';

class User {
  static final _universityKey = "university";
  static final _keywordsKey = "keywords";
  static final _isNoticeVisibleKey = "isNoticeVisible";

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

  static Future<bool> get isNoticeVisible async =>
      (await preferences).getBool(_isNoticeVisibleKey);

  static Future<void> setNoticeVisibility(bool isVisible) async =>
      (await preferences).setBool(_isNoticeVisibleKey, isVisible);
}
