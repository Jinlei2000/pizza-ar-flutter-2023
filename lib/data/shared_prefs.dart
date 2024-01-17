// shared_prefs.dart
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  SharedPreferences? prefs;

  SharedPrefs() {
    // Call the asynchronous method for initialization
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    // Use the 'await' keyword to wait for the result of the asynchronous call
    prefs = await SharedPreferences.getInstance();
  }

  // Set List<String>
  Future<void> setStringList(String key, List<String> value) async {
    await prefs?.setStringList(key, value);
  }

  // Get List<String>
  Future<List<String>> getStringList(String key) async {
    return prefs?.getStringList(key) ?? [];
  }

  //Get test
  Future<String?> getTest() async {
    return prefs?.getString('test');
  }

  // Clear all data
  // TODO: add a clear button in the app (delete cache data)
  Future<void> clear() async {
    await prefs?.clear();
  }
}
