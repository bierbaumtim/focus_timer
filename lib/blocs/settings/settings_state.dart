import 'package:equatable/equatable.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

class InitialSettingsState extends SettingsState {}

class SettingsLoaded extends SettingsState {
  final bool darkmode;

  const SettingsLoaded({this.darkmode});
  @override
  List get props => super.props..add(darkmode);
}
