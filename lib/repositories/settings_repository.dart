import 'package:hive/hive.dart';

import '../constants/hive_constants.dart';

abstract class ISettingsRepository {
  Map<String, dynamic> loadSettings();
  Future<void> saveSettings(Map<String, dynamic> settings);
  Future<void> saveSetting(String key, dynamic value);
  Future<void> deleteSetting(String key);
}

class SettingsRepository implements ISettingsRepository {
  @override
  Future<void> deleteSetting(String key) {
    final settingsBox = Hive.box(kSettingsHiveBox);
    return settingsBox.delete(key);
  }

  @override
  Map<String, dynamic> loadSettings() {
    final settingsBox = Hive.box(kSettingsHiveBox);
    return Map<String, dynamic>.from(settingsBox.toMap());
  }

  @override
  Future<void> saveSetting(String key, dynamic value) {
    final settingsBox = Hive.box(kSettingsHiveBox);
    return settingsBox.put(key, value);
  }

  @override
  Future<void> saveSettings(Map<String, dynamic> settings) {
    final settingsBox = Hive.box(kSettingsHiveBox);
    return settingsBox.putAll(settings);
  }
}
