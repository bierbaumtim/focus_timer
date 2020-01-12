import 'package:equatable/equatable.dart';
import 'package:focus_timer/models/task.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'session.g.dart';

@JsonSerializable()
class Session extends Equatable {
  final String uid;
  final int duration;
  final int position;
  final List<Task> tasks;

  const Session({
    this.uid,
    this.duration,
    this.position,
    this.tasks,
  });

  @override
  List<Object> get props => <Object>[uid, duration, position, tasks];

  factory Session.create(int duration, int position) => Session(
        duration: duration,
        position: position,
        tasks: <Task>[],
        uid: Uuid().v4(),
      );

  factory Session.fromJson(Map<String, dynamic> json) =>
      _$SessionFromJson(json);

  Map<String, dynamic> toJson() => _$SessionToJson(this);

  void addTask(Task task) {
    final index = tasks.indexWhere((t) => t.uuid == task.uuid);
    if (index == -1) {
      tasks.add(task);
    } else {
      tasks.replaceRange(index, index + 1, <Task>[task]);
    }
  }

  void removeTask(String taskUid) =>
      tasks.removeWhere((t) => t.uuid == taskUid);
}
