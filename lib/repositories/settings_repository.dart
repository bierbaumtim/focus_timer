import 'package:shared_preferences/shared_preferences.dart';

import 'interfaces/settings_repository_interface.dart';

class SettingsRepository implements ISettingsRepository {
  Future<SharedPreferences> get _prefs => SharedPreferences.getInstance();

  @override
  Future<void> deleteSetting(String key) async => (await _prefs).remove(key);

  @override
  Future<Map<String, dynamic>> loadSettings() async {
    final settings = <String, dynamic>{};
    final keys = (await _prefs).getKeys();
    for (var key in keys) {
      final value = (await _prefs).get(key);
      settings.putIfAbsent(key, () => value);
    }
    return settings;
  }

  @override
  Future<void> saveSetting(String key, dynamic value) async {
    if (value is int) {
      (await _prefs).setInt(key, value);
    } else if (value is double) {
      (await _prefs).setDouble(key, value);
    } else if (value is bool) {
      (await _prefs).setBool(key, value);
    } else if (value is String) {
      (await _prefs).setString(key, value);
    } else {
      throw UnsupportedError(
        '${value.runtimeType} of value is not supported.',
      );
    }
  }

  @override
  Future<void> saveSettings(Map<String, dynamic> settings) async {
    for (var key in settings.keys) {
      await saveSetting(key, settings[key]);
    }
  }
}
