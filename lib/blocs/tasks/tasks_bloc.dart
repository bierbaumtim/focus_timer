import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  @override
  TasksState get initialState => InitialTasksState();

  @override
  Stream<TasksState> mapEventToState(
    TasksEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
