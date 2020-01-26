import 'package:copy_with_annotation/copy_with_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

import 'task.dart';

part 'session.g.dart';

@CopyWith()
@HiveType(typeId: 0)
@JsonSerializable()
class Session extends Equatable {
  @HiveField(0)
  @JsonKey(name: 'uid', defaultValue: '')
  final String uid;
  @HiveField(1)
  @JsonKey(name: 'duration', defaultValue: 0)
  final int duration;
  @HiveField(2)
  @JsonKey(name: 'tasks', defaultValue: <Task>[])
  final List<Task> tasks;
  @JsonKey(name: 'isCompleted', defaultValue: false)
  final bool isCompleted;

  const Session({
    this.uid,
    this.duration,
    this.tasks,
    bool isCompleted,
  }) : isCompleted = isCompleted ?? false;

  @override
  @CopyWithField(ignore: true)
  List<Object> get props => <Object>[uid, duration, tasks];

  factory Session.create(int duration) => Session(
        uid: Uuid().v4(),
        duration: duration,
        tasks: const <Task>[],
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
