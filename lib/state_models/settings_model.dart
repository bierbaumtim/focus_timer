import 'package:states_rebuilder/states_rebuilder.dart';

import '../repositories/settings_repository.dart';

class SettingsModel extends StatesRebuilder {
  final ISettingsRepository repository;

  SettingsModel(this.repository) {
    loadSettings();
  }

  bool get darkmode => settings['darkmode'] ?? true;

  Map<String, dynamic> settings;

  void loadSettings() => settings = repository.loadSettings();

  void changeDarkmode(bool value) {
    _addOrUpdateSetting('darkmode', value);
    repository.saveSetting('darkmode', value);
    rebuildStates();
  }

  void _addOrUpdateSetting(String key, dynamic value) {
    if (settings.containsKey(key)) {
      settings[key] = value;
    } else {
      settings.putIfAbsent(key, () => value);
    }
  }
}
