// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Session _$SessionFromJson(Map<String, dynamic> json) {
  return Session(
    uid: json['uid'] as String,
    duration: json['duration'] as int,
    position: json['position'] as int,
    tasks: (json['tasks'] as List)
        ?.map(
            (e) => e == null ? null : Task.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SessionToJson(Session instance) => <String, dynamic>{
      'uid': instance.uid,
      'duration': instance.duration,
      'position': instance.position,
      'tasks': instance.tasks,
    };
