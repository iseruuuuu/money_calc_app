import 'package:enum_to_string/enum_to_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum PreferenceKey {
  //パスワード
  password,

  //記録を消去したかどうか
  isDelete,

  //初回の記録のため
  isCheckCount
}

class Preference {
  final preference = SharedPreferences.getInstance();

  Future<String> getString(PreferenceKey key) async {
    final pref = await preference;
    final value = pref.getString(EnumToString.convertToString(key)) ?? '';
    return value;
  }

  Future<void> setString(PreferenceKey key, String value) async {
    final pref = await preference;
    await pref.setString(EnumToString.convertToString(key), value);
  }

  Future<void> setStringList(PreferenceKey key, List<String> value) async {
    final pref = await preference;
    await pref.setStringList(EnumToString.convertToString(key), value);
  }

  Future<List<String>> getStringList(PreferenceKey key) async {
    final pref = await preference;
    final value = pref.getStringList(EnumToString.convertToString(key)) ?? [];
    return value;
  }

  Future<bool> getBool(PreferenceKey key) async {
    final pref = await preference;
    final value = pref.getBool(EnumToString.convertToString(key)) ?? false;
    return value;
  }

  Future<void> setBool(PreferenceKey key, bool value) async {
    final pref = await preference;
    await pref.setBool(EnumToString.convertToString(key), value);
  }
}