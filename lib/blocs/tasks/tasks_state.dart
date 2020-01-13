import 'package:equatable/equatable.dart';
import 'package:focus_timer/models/task.dart';

abstract class TasksState extends Equatable {
  const TasksState();

  @override
  List<Object> get props => [];
}

class InitialTasksState extends TasksState {}

class TasksLoading extends TasksState {}

class TasksLoaded extends TasksState {
  final List<Task> tasks;

  const TasksLoaded(this.tasks);

  @override
  List get props => super.props..add(tasks);
}

class TasksEmpty extends TasksState {}
