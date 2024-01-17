// shared_prefs.dart
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static Future<SharedPreferences> _getPrefsInstance() async {
    return await SharedPreferences.getInstance();
  }

  static Future<void> setStringList(String key, List<String> value) async {
    final prefs = await _getPrefsInstance();
    await prefs.setStringList(key, value);
  }

  static Future<List<String>> getStringList(String key) async {
    final prefs = await _getPrefsInstance();
    return prefs.getStringList(key) ?? [];
  }

  // clear all data
  static Future<void> clear() async {
    final prefs = await _getPrefsInstance();
    await prefs.clear();
  }
}
