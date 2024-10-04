import 'package:login_and_registration/data/services/shared_pref/shared_pref_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefImpl implements SharedPrefService {
  late SharedPreferences _prefInstance;

  @override
  Future<void> init() async {
    _prefInstance = await SharedPreferences.getInstance();
  }

  @override
  Future<String?> getString(String key) async {
    return (_prefInstance).getString(key);
  }

  @override
  Future<bool> setString(String key, String value) async {
    return await (_prefInstance).setString(key, value);
  }

  @override
  Future<bool> getBool(String key, [bool defValue = false]) async {
    return (_prefInstance).getBool(key) ?? defValue;
  }

  @override
  Future<bool> setBool(String key, bool value) async {
    return await (_prefInstance).setBool(key, value);
  }

  @override
  Future<bool> containsKey(String key) async {
    return (_prefInstance).containsKey(key);
  }

  @override
  Future<int?> getInt(String key, [int defValue = 0]) async {
    return (_prefInstance).getInt(key) ?? defValue;
  }

  @override
  Future<bool> clearData() async {
    return await (_prefInstance).clear();
  }

  @override
  Future<bool> remove(String key) async {
    return await (_prefInstance).remove(key);
  }
}
