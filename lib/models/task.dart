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

  @JsonKey(name: 'sortId', defaultValue: 0)
  final int sortId;

  const Task({
    required this.uuid,
    required this.name,
    required this.isCompleted,
    required this.sortId,
  });

  factory Task.create({
    required String name,
    required bool isCompleted,
    required int sortId,
  }) =>
      Task(
        uuid: const Uuid().v4(),
        name: name,
        isCompleted: isCompleted,
        sortId: sortId,
      );

  Task copyWith({
    String? name,
    bool? isCompleted,
    int? sortId,
  }) =>
      Task(
        uuid: uuid,
        name: name ?? this.name,
        isCompleted: isCompleted ?? this.isCompleted,
        sortId: sortId ?? this.sortId,
      );

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);
}
