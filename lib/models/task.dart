import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'task.g.dart';

@JsonSerializable(explicitToJson: true)
class Task {
  @JsonKey(name: 'uuid')
  final String uuid;

  @JsonKey(name: 'name', defaultValue: '')
  final String name;

  @JsonKey(name: 'isCompleted', defaultValue: false)
  final bool isCompleted;

  const Task({
    @required this.uuid,
    @required this.name,
    @required this.isCompleted,
  });

  factory Task.create({
    @required String name,
    @required bool isCompleted,
  }) =>
      Task(
        uuid: Uuid().v4(),
        name: name,
        isCompleted: isCompleted,
      );

  Task copyWith({String name, bool isCompleted}) => Task(
        uuid: uuid,
        name: name ?? this.name,
        isCompleted: isCompleted ?? this.isCompleted,
      );

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);
}
