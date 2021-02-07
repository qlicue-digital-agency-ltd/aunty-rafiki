import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  read(String key) async {
    final prefs = await SharedPreferences.getInstance();

    final _data = prefs.getString(key);

    if (_data != null)
      return json.decode(_data);
    else
      return null;
  }

  save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  saveBoolean(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  Future<bool> readBoolean(String key) async {
    bool _result = true;
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool(key) != null) {
      _result = prefs.getBool(key);
    }

    return _result;
  }

  //////
  readStringleString(String key) async {
    final prefs = await SharedPreferences.getInstance();

    final _data = prefs.getString(key);

    return _data;
  }

  saveStringleString(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }
}
