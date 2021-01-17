import 'package:flutter/foundation.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../repositories/interfaces/settings_repository_interface.dart';
import '../utils/settings_utils.dart';

class SettingsModel extends ChangeNotifier {
  final ISettingsRepository repository;

  SettingsModel(this.repository) {
    _settings = <String, Object?>{};
    loadSettings();
  }

  bool get darkmode => _settings['darkmode'] as bool ?? true;

  String get backgroundTaskConfig =>
      _settings['background_task_config'] as String ?? 'unknown';
  String get backgroundTaskStartup =>
      _settings['background_task_startup'] as String ?? 'unknown';
  String get backgroundTaskCalc =>
      _settings['background_task_calc'] as String ?? 'unknown';

  late Map<String, Object?> _settings;

  Map<String, Object?> get settings => _settings;

  Future<void> loadSettings() async {
    _settings = await repository.loadSettings();
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    _settings.putIfAbsent(
      'background_task_config',
      () => prefs.getString('background_task_config'),
    );
    _settings.putIfAbsent(
      'background_task_startup',
      () => prefs.getString('background_task_startup'),
    );
    _settings.putIfAbsent(
      'background_task_calc',
      () => prefs.getString('background_task_calc'),
    );
    notifyListeners();
  }

  void changeDarkmode(bool value) {
    _settings = addOrUpdateSetting('darkmode', value, _settings);
    repository.saveSetting('darkmode', value);
    notifyListeners();
  }
}
