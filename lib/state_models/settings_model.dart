import 'package:states_rebuilder/states_rebuilder.dart';

import '../repositories/interfaces/settings_repository_interface.dart';

class SettingsModel extends StatesRebuilder {
  final ISettingsRepository repository;

  SettingsModel(this.repository) {
    loadSettings();
  }

  bool get darkmode => _settings['darkmode'] ?? true;

  Map<String, dynamic> _settings;

  Map<String, dynamic> get settings => _settings;

  void loadSettings() => _settings = repository.loadSettings();

  void changeDarkmode(bool value) {
    _addOrUpdateSetting('darkmode', value);
    repository.saveSetting('darkmode', value);
    if (hasObservers) {
      rebuildStates();
    }
  }

  void _addOrUpdateSetting(String key, dynamic value) {
    if (_settings.containsKey(key)) {
      _settings[key] = value;
    } else {
      _settings.putIfAbsent(key, () => value);
    }
  }
}
