// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SessionAdapter extends TypeAdapter<Session> {
  @override
  final typeId = 0;

  @override
  Session read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Session(
      uid: fields[0] as String,
      duration: fields[1] as int,
      position: fields[2] as int,
      tasks: (fields[3] as List)?.cast<Task>(),
    );
  }

  @override
  void write(BinaryWriter writer, Session obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.uid)
      ..writeByte(1)
      ..write(obj.duration)
      ..writeByte(2)
      ..write(obj.position)
      ..writeByte(3)
      ..write(obj.tasks);
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Session _$SessionFromJson(Map<String, dynamic> json) {
  return Session(
    uid: json['uid'] as String ?? '',
    duration: json['duration'] as int ?? 0,
    position: json['position'] as int ?? 0,
    tasks: (json['tasks'] as List)
            ?.map((e) =>
                e == null ? null : Task.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [],
  );
}

Map<String, dynamic> _$SessionToJson(Session instance) => <String, dynamic>{
      'uid': instance.uid,
      'duration': instance.duration,
      'position': instance.position,
      'tasks': instance.tasks,
    };
