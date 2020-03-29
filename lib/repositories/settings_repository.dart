import 'package:hive/hive.dart';

import '../constants/hive_constants.dart';
import 'interfaces/settings_repository_interface.dart';

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

class DesktopSettingsRepository implements ISettingsRepository {
  @override
  Future<void> deleteSetting(String key) {
    // TODO: implement deleteSetting
    return null;
  }

  @override
  Map<String, dynamic> loadSettings() {
    // TODO: implement loadSettings
    return <String, dynamic>{
      'darkmode': true,
    };
  }

  @override
  Future<void> saveSetting(String key, dynamic value) {
    // TODO: implement saveSetting
    return null;
  }

  @override
  Future<void> saveSettings(Map<String, dynamic> settings) {
    // TODO: implement saveSettings
    return null;
  }
}
