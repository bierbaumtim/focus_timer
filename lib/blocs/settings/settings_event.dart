import 'package:equatable/equatable.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List get props => <Object>[];
}

class ChangeTheme extends SettingsEvent {}
