import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:dartx/dartx.dart';

import '../repositories/interfaces/settings_repository_interface.dart';
import '../utils/settings_utils.dart';

class SessionSettingsModel extends StatesRebuilder {
  final ISettingsRepository repository;

  SessionSettingsModel(this.repository) : assert(repository != null) {
    _settings = repository.loadSettings();
  }

  Map<String, dynamic> _settings;

  Map<String, dynamic> get settings => _settings;

  double get sessionsDuration =>
      _settings['sessions_duration'] ?? 25.minutes.inSeconds.toDouble();

  double get shortBreakDuration =>
      _settings['short_break_duration'] ?? 5.minutes.inSeconds.toDouble();

  double get longBreakDuration =>
      _settings['long_break_duration'] ?? 25.minutes.inSeconds.toDouble();

  void setSessionDuration(double duration) {
    _settings = addOrUpdateSetting(
      'sessions_duration',
      duration.truncate().toDouble(),
      _settings,
    );
    repository.saveSetting('sessions_duration', duration);
    if (hasObservers) {
      rebuildStates();
    }
  }

  void setShortBreakDuration(double duration) {
    _settings = addOrUpdateSetting(
      'short_break_duration',
      duration.truncate().toDouble(),
      _settings,
    );
    repository.saveSetting('short_break_duration', duration);
    if (hasObservers) {
      rebuildStates();
    }
  }

  void setLongBreakDuration(double duration) {
    _settings = addOrUpdateSetting(
      'long_break_duration',
      duration.truncate().toDouble(),
      _settings,
    );
    repository.saveSetting('long_break_duration', duration);
    if (hasObservers) {
      rebuildStates();
    }
  }
}
