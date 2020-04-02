// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

// ignore_for_file: argument_type_not_assignable, implicit_dynamic_type, always_specify_types

extension SessionCopyWithExtension on Session {
  Session copyWith({
    int duration,
    bool isCompleted,
    List tasks,
    String uid,
  }) {
    return Session(
      duration: duration ?? this.duration,
      isCompleted: isCompleted ?? this.isCompleted,
      tasks: tasks ?? this.tasks,
      uid: uid ?? this.uid,
    );
  }
}

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
      tasks: (fields[2] as List)?.cast<Task>(),
    );
  }

  @override
  void write(BinaryWriter writer, Session obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.uid)
      ..writeByte(1)
      ..write(obj.duration)
      ..writeByte(2)
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
    tasks: (json['tasks'] as List)
            ?.map((e) =>
                e == null ? null : Task.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [],
    isCompleted: json['isCompleted'] as bool ?? false,
  );
}

Map<String, dynamic> _$SessionToJson(Session instance) => <String, dynamic>{
      'uid': instance.uid,
      'duration': instance.duration,
      'tasks': instance.tasks?.map((e) => e?.toJson())?.toList(),
      'isCompleted': instance.isCompleted,
    };
