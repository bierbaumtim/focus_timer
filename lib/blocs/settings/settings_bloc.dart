import 'dart:async';

import 'package:hydrated_bloc/hydrated_bloc.dart';

import './bloc.dart';

class SettingsBloc extends HydratedBloc<SettingsEvent, SettingsState> {
  @override
  SettingsState get initialState =>
      super.initialState ?? InitialSettingsState();

  @override
  Stream<SettingsState> mapEventToState(
    SettingsEvent event,
  ) async* {
    if (event is ChangeTheme) {
      yield* _mapChangeThemeToState(event);
    }
  }

  Stream<SettingsState> _mapChangeThemeToState(ChangeTheme event) async* {
    final currentSetting =
        state is SettingsLoaded ? (state as SettingsLoaded).darkmode : true;
        
    yield SettingsLoaded(darkmode: !currentSetting);
  }

  @override
  SettingsState fromJson(Map<String, dynamic> json) {
    bool darkmode;
    try {
      darkmode = json['darkmode'] as bool ?? true;
    } catch (e) {
      darkmode = true;
    }
    return SettingsLoaded(darkmode: darkmode);
  }

  @override
  Map<String, dynamic> toJson(SettingsState state) {
    final darkmode = state is SettingsLoaded ? state.darkmode : true;

    return <String, dynamic>{
      'darkmode': darkmode,
    };
  }
}
