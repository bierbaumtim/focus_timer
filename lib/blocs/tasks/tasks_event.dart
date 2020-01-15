import 'package:equatable/equatable.dart';
import 'package:focus_timer/models/task.dart';

abstract class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List get props => <Object>[];
}

class AddTask extends TasksEvent {
  final Task task;

  const AddTask(this.task);

  @override
  List get props => super.props..add(task);
}

class UpdateTask extends TasksEvent {
  final Task task;

  const UpdateTask(this.task);

  @override
  List get props => super.props..add(task);
}

class RemoveTask extends TasksEvent {
  final String taskUid;

  const RemoveTask(this.taskUid);

  @override
  List get props => super.props..add(taskUid);
}

class LoadTasks extends TasksEvent {}
