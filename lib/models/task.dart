import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'task.g.dart';

@CopyWith()
@HiveType(typeId: 1)
@JsonSerializable()
// ignore: must_be_immutable
class Task extends Equatable {
  @HiveField(0)
  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @HiveField(1)
  @JsonKey(name: 'uuid', defaultValue: '')
  final String uuid;
  @HiveField(2)
  @JsonKey(name: 'session_uuid', defaultValue: '')
  final String sessionUId;
  @HiveField(3)
  @JsonKey(name: 'iscompleted', defaultValue: false)
  bool isCompleted;

  Task({
    this.name,
    this.uuid,
    this.sessionUId,
    this.isCompleted,
  });

  void toggleIsCompleted() => isCompleted = !isCompleted;

  @override
  List<Object> get props => <Object>[
        name,
        uuid,
        sessionUId,
        isCompleted,
      ];

  @override
  bool get stringify => true;

  factory Task.create(String name) => Task(
        name: name,
        uuid: Uuid().v4(),
        sessionUId: '',
        isCompleted: false,
      );

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);
}
