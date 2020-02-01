abstract class ISettingsRepository {
  Map<String, dynamic> loadSettings();
  Future<void> saveSettings(Map<String, dynamic> settings);
  Future<void> saveSetting(String key, dynamic value);
  Future<void> deleteSetting(String key);
}
