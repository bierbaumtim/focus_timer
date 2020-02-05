import 'package:states_rebuilder/states_rebuilder.dart';

import '../repositories/interfaces/settings_repository_interface.dart';
import '../utils/settings_utils.dart';

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
    _settings = addOrUpdateSetting('darkmode', value, _settings);
    repository.saveSetting('darkmode', value);
    if (hasObservers) {
      rebuildStates();
    }
  }
}
