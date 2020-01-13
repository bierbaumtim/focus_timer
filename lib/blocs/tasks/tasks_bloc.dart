import 'dart:async';
import 'dart:convert';

import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:focus_timer/models/task.dart';
import './bloc.dart';

class TasksBloc extends HydratedBloc<TasksEvent, TasksState> {
  @override
  TasksState get initialState => super.initialState ?? InitialTasksState();

  @override
  Stream<TasksState> mapEventToState(
    TasksEvent event,
  ) async* {
    if (event is AddTask) {
      yield* _mapAddTaskToState(event);
    } else if (event is RemoveTask) {
      yield* _mapRemoveTask(event);
    } else if (event is LoadTasks) {}
  }

  Stream<TasksState> _mapAddTaskToState(AddTask event) async* {
    final currentTasks =
        state is TasksLoaded ? (state as TasksLoaded).tasks : <Task>[];
    yield TasksLoaded(currentTasks..add(event.task));
  }

  Stream<TasksState> _mapRemoveTask(RemoveTask event) async* {
    final currentTasks =
        state is TasksLoaded ? (state as TasksLoaded).tasks : <Task>[];
    currentTasks.removeWhere((t) => t.uuid == event.taskUid);

    yield currentTasks.isEmpty ? TasksEmpty() : TasksLoaded(currentTasks);
  }

  @override
  TasksState fromJson(Map<String, dynamic> json) {
    final tasksJson = json['tasks'] as String;
    if (tasksJson != null && tasksJson.isNotEmpty) {
      final decodedJson = jsonDecode(tasksJson);
      return decodedJson.map<Task>((t) => Task.fromJson(t)).toList();
    }
    return null;
  }

  @override
  Map<String, dynamic> toJson(TasksState state) {
    if (state is TasksLoaded) {
      final tasks = jsonEncode(state.tasks);
      return <String, dynamic>{
        'tasks': tasks,
      };
    }
    return {};
  }
}
