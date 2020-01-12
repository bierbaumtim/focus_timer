import 'package:equatable/equatable.dart';

abstract class TasksState extends Equatable {
  const TasksState();
}

class InitialTasksState extends TasksState {
  @override
  List<Object> get props => [];
}
