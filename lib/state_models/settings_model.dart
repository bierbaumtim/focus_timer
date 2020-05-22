import 'package:flutter/foundation.dart';

import '../repositories/interfaces/settings_repository_interface.dart';
import '../utils/settings_utils.dart';

class SettingsModel extends ChangeNotifier {
  final ISettingsRepository repository;

  SettingsModel(this.repository) : assert(repository != null) {
    _settings = <String, dynamic>{};
    loadSettings();
  }

  bool get darkmode => _settings['darkmode'] ?? true;

  Map<String, dynamic> _settings;

  Map<String, dynamic> get settings => _settings;

  Future<void> loadSettings() async {
    _settings = await repository.loadSettings();
    notifyListeners();
  }

  void changeDarkmode(bool value) {
    _settings = addOrUpdateSetting('darkmode', value, _settings);
    repository.saveSetting('darkmode', value);
    notifyListeners();
  }
}
