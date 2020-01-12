// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) {
  return Task(
    name: json['name'] as String ?? '',
    uuid: json['uuid'] as String ?? '',
    sessionUId: json['session_uuid'] as String ?? '',
  );
}

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'name': instance.name,
      'uuid': instance.uuid,
      'session_uuid': instance.sessionUId,
    };
