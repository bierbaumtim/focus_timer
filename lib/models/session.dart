import 'package:equatable/equatable.dart';
import 'package:focus_timer/models/task.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'session.g.dart';

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
  @JsonKey(name: 'position', defaultValue: 0)
  final int position;
  @HiveField(3)
  @JsonKey(name: 'tasks', defaultValue: <Task>[])
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
        uid: Uuid().v4(),
        duration: duration,
        position: position,
        tasks: <Task>[],
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
