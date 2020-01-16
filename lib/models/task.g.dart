// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskAdapter extends TypeAdapter<Task> {
  @override
  final typeId = 1;

  @override
  Task read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Task(
      name: fields[0] as String,
      uuid: fields[1] as String,
      sessionUId: fields[2] as String,
      isCompleted: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Task obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.uuid)
      ..writeByte(2)
      ..write(obj.sessionUId)
      ..writeByte(3)
      ..write(obj.isCompleted);
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) {
  return Task(
    name: json['name'] as String ?? '',
    uuid: json['uuid'] as String ?? '',
    sessionUId: json['session_uuid'] as String ?? '',
    isCompleted: json['iscompleted'] as bool ?? false,
  );
}

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'name': instance.name,
      'uuid': instance.uuid,
      'session_uuid': instance.sessionUId,
      'iscompleted': instance.isCompleted,
    };
