import 'package:states_rebuilder/states_rebuilder.dart';

import '../repositories/interfaces/settings_repository_interface.dart';

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
    if (hasObservers) {
      rebuildStates();
    }
  }

  void _addOrUpdateSetting(String key, dynamic value) {
    if (settings.containsKey(key)) {
      settings[key] = value;
    } else {
      settings.putIfAbsent(key, () => value);
    }
  }
}
