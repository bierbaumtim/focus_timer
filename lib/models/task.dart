import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'task.g.dart';

@JsonSerializable()
class Task extends Equatable {
  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'uuid', defaultValue: '')
  final String uuid;
  @JsonKey(name: 'session_uuid', defaultValue: '')
  final String sessionUId;

  const Task({this.name, this.uuid, this.sessionUId});

  @override
  List<Object> get props => <Object>[name, uuid, sessionUId];

  factory Task.create(String name) => Task(
        name: name,
        uuid: Uuid().v4(),
        sessionUId: '',
      );

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);
}
