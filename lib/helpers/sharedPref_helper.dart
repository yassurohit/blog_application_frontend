import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  // Singleton pattern
  static final SharedPrefsHelper _instance = SharedPrefsHelper._internal();
  factory SharedPrefsHelper() => _instance;

  SharedPreferences? _prefs;

  // Private constructor
  SharedPrefsHelper._internal();

  // Initialize SharedPreferences instance once
  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  // Save data to SharedPreferences
  Future<void> saveString(String key, String value) async {
    await _prefs?.setString(key, value);
  }

  Future<void> saveBool(String key, bool value) async {
    await _prefs?.setBool(key, value);
  }

  Future<void> saveInt(String key, int value) async {
    await _prefs?.setInt(key, value);
  }

  // Retrieve data from SharedPreferences
  String? getString(String key) => _prefs?.getString(key);
  bool? getBool(String key) => _prefs?.getBool(key);
  int? getInt(String key) => _prefs?.getInt(key);

  // Remove a specific item
  Future<void> remove(String key) async {
    await _prefs?.remove(key);
  }

  // Clear all data
  Future<void> clear() async {
    await _prefs?.clear();
  }
}

//#Example
// await SharedPrefsHelper().saveString('username', 'JohnDoe');
// String? username = SharedPrefsHelper().getString('username');
// await SharedPrefsHelper().remove('username');
// await SharedPrefsHelper().clear();
